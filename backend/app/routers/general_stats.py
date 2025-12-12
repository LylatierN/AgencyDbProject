from fastapi import APIRouter, Depends, Query, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import select, func, or_
from datetime import datetime, date
from typing import Dict, Any, List, Optional

from ..models import (
    Personnel, 
    Production, 
    PersonnelAssignment, 
    ProductionExpense, 
    Performer, 
    PartnerPersonnel
)
from ..schemas import APIResponse 
from ..database import get_db

router = APIRouter(
    prefix="/stats",
    tags=["General Listings & Statistics"]
)


# =================================================================
# ROUTE 1: All Personnel and Assignments (Searchable) (Query 7)
# =================================================================

@router.get(
    "/personnel/assignments",
    response_model=APIResponse,
    summary="(Q7)List all personnel and their assignments (Searchable)"
)
def list_all_personnel_assignments(
    db: Session = Depends(get_db),
    name_search: Optional[str] = Query(None, description="Partial name of personnel to search for."),
    title_search: Optional[str] = Query(None, description="Partial title of production to search for.")
) -> Dict[str, Any]:
    """
    Lists all personnel, their assigned production, and their role. 
    Allows filtering by personnel name or production title using partial matches.
    """
    stmt = (
        select(
            Personnel.name.label("personnel_name"),
            Personnel.personnel_type,
            Production.title.label("production_title"),
            PersonnelAssignment.role_title
        )
        .outerjoin(PersonnelAssignment, Personnel.personnel_id == PersonnelAssignment.personnel_id)
        .outerjoin(Production, PersonnelAssignment.production_id == Production.production_id)
        .order_by(Personnel.name)
    )

    filters = []
    if name_search:
        filters.append(Personnel.name.like(f"%{name_search}%"))
    if title_search:
        filters.append(Production.title.like(f"%{title_search}%"))
        
    if filters:
        stmt = stmt.where(or_(*filters))

    result = db.execute(stmt).all()
    
    data_list = [
        {
            "personnel_name": r.personnel_name,
            "personnel_type": r.personnel_type,
            "production_title": r.production_title if r.production_title else "N/A",
            "role_title": r.role_title if r.role_title else "N/A"
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["personnel_name", "personnel_type", "production_title", "role_title"],
        "data": data_list
    }


# =================================================================
# ROUTE 2: Personnel Contract Details in Range (Query 8)
# =================================================================

@router.get(
    "/personnel/contracts",
    response_model=APIResponse,
    summary="(Q8)Personnel Contract Overlap (Searchable)"
)
def list_personnel_contract_data(
    db: Session = Depends(get_db),
    start_date: date = Query(..., description="Start date of the required contract period."),
    end_date: date = Query(..., description="End date of the required contract period."),
    name_search: Optional[str] = Query(None, description="Partial name of personnel to search for.")
) -> Dict[str, Any]:
    """
    Displays personnel whose contract duration overlaps with the specified date range. 
    Allows optional filtering by personnel name.
    """
    stmt = (
        select(
            Personnel.personnel_id,
            Personnel.name,
            Personnel.personnel_type,
            Personnel.contract_hire_date,
            Personnel.contract_expiration_date
        )
        .where(Personnel.contract_hire_date <= end_date)
        .where(Personnel.contract_expiration_date >= start_date)
    )

    if name_search:
        stmt = stmt.where(Personnel.name.like(f"%{name_search}%"))
    
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "personnel_id": r.personnel_id,
            "name": r.name,
            "personnel_type": r.personnel_type,
            "contract_hire_date": r.contract_hire_date.isoformat(),
            "contract_expiration_date": r.contract_expiration_date.isoformat()
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["personnel_id", "name", "personnel_type", "contract_hire_date", "contract_expiration_date"],
        "data": data_list
    }


# =================================================================
# ROUTE 3: Production Expense Summary (Query 11)
# =================================================================

@router.get(
    "/production/expenses/summary",
    response_model=APIResponse,
    summary="(Q11)Total expenses grouped by production"
)
def show_production_expense_summary(
    db: Session = Depends(get_db)
) -> Dict[str, Any]:
    """
    Calculates the total expense amount for every production, including productions with zero expenses.
    """
    stmt = (
        select(
            Production.title.label("production_title"),
            func.sum(ProductionExpense.amount).label("total_expense")
        )
        .outerjoin(ProductionExpense, Production.production_id == ProductionExpense.production_id)
        .group_by(Production.title)
        .order_by(func.sum(ProductionExpense.amount).desc())
    )
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "production_title": r.production_title,
            "total_expense": float(r.total_expense) if r.total_expense is not None else 0.0
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["production_title", "total_expense"],
        "data": data_list
    }


# =================================================================
# ROUTE 4: List All Performers (Query 12)
# =================================================================

@router.get(
    "/performers",
    response_model=APIResponse,
    summary="(Q12)List all performers and their performance types/agencies"
)
def list_all_performers(
    db: Session = Depends(get_db)
) -> Dict[str, Any]:
    """
    Lists all individuals classified as performers, along with their performance type and agency.
    """
    stmt = (
        select(
            Personnel.name.label("performer_name"),
            Performer.performance_type,
            Performer.agency
        )
        .join(Performer, Personnel.personnel_id == Performer.personnel_id)
        .order_by(Personnel.name)
    )
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "performer_name": r.performer_name,
            "performance_type": r.performance_type,
            "agency": r.agency
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["performer_name", "performance_type", "agency"],
        "data": data_list
    }


# =================================================================
# ROUTE 5: Find Partners and Their Contracted Personnel (Query 13)
# =================================================================

@router.get(
    "/partners/for-performer",
    summary="(Q13)Find all partners contracted with a specific Performer"
)
def get_partners_by_performer_name(
    db: Session = Depends(get_db),
    performer_name: str = Query(..., description="Full name of the Performer (e.g., 'Alice Kim').")
) -> Dict[str, Any]:
    """
    Retrieves all external partners and their service types that are contracted
    with the specified personnel, provided that personnel is a Performer.
    """
    personnel_id = (
        select(Personnel.personnel_id)
        .join(Performer, Personnel.personnel_id == Performer.personnel_id)
        .where(Personnel.name == performer_name)
    ).scalar_one_or_none()

    if personnel_id is None:
        raise HTTPException(
            status_code=404, 
            detail=f"Performer '{performer_name}' not found or is not listed as a Performer."
        )

    stmt = (
        select(
            PartnerPersonnel.name.label("partner_name"),
            PartnerPersonnel.service_type,
            Personnel.name.label("personnel_name")
        )
        .join(Personnel, PartnerPersonnel.personnel_id == Personnel.personnel_id)
        .where(PartnerPersonnel.personnel_id == personnel_id)
        .order_by(PartnerPersonnel.name)
    )

    result = db.execute(stmt).all()
    
    data_list = [
        {
            "partner_name": r.partner_name,
            "service_type": r.service_type,
            "personnel_name": r.personnel_name
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["partner_name", "service_type", "personnel_name"],
        "data": data_list
    }