from fastapi import APIRouter, Depends, Query, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import select, func, literal_column
from datetime import datetime
from typing import List, Dict, Any

from ..models import Personnel, ProductionSchedule, PersonnelAssignment 
from ..schemas import APIResponse
from ..database import get_db

router = APIRouter(
    prefix="/personnel",
    tags=["Personnel Management"]
)


# =================================================================
# ROUTE 1: List Personnel by Type (Query 1)
# =================================================================

@router.get(
    "/by-type",
    response_model=APIResponse,
    summary="(Q1)List Personnel by Position/Type (Director, Actor, etc.)"
)
def list_personnel_by_type(
    db: Session = Depends(get_db),
    personnel_types: List[str] = Query(
        ['Director', 'Costumer', 'Makeup', 'Actor'],
        description="List of personnel types to filter by."
    ),
    limit: int = Query(10, ge=1, description="Maximum number of records to return.")
) -> Dict[str, Any]:
    """
    Retrieves a list of personnel filtered by their specified position/type.
    """
    stmt = (
        select(
            Personnel.personnel_id,
            Personnel.name,
            Personnel.personnel_type
        )
        .where(Personnel.personnel_type.in_(personnel_types))
        .limit(limit)
    )
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "personnel_id": r.personnel_id,
            "name": r.name,
            "personnel_type": r.personnel_type
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["personnel_id", "name", "personnel_type"],
        "data": data_list
    }


# =================================================================
# ROUTE 2: Find Available Personnel (Query 2)
# =================================================================

@router.get(
    "/available",
    response_model=APIResponse,
    summary="(Q2)Find Personnel Free within a Time Range"
)
def get_available_personnel(
    db: Session = Depends(get_db),
    start_dt: datetime = Query(..., description="Start datetime of the required availability period (e.g., 2024-02-10T09:00:00)."),
    end_dt: datetime = Query(..., description="End datetime of the required availability period (e.g., 2024-02-10T12:00:00)."),
    personnel_types: List[str] = Query(
        ['Actor', 'Crew'],
        description="Personnel types to check availability for."
    )
) -> Dict[str, Any]:
    """
    Finds personnel of specified types who do not have a conflicting schedule
    between `start_dt` and `end_dt`.
    """
    conflicting_personnel_ids = (
        select(ProductionSchedule.personnel_id)
        .where(
            ProductionSchedule.start_dt < end_dt,
            ProductionSchedule.end_dt > start_dt
        )
        .distinct()
    ).scalar_subquery()

    stmt = (
        select(
            Personnel.personnel_id,
            Personnel.name,
            Personnel.personnel_type
        )
        .where(
            Personnel.personnel_type.in_(personnel_types),
            Personnel.personnel_id.not_in(conflicting_personnel_ids)
        )
    )
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "personnel_id": r.personnel_id,
            "name": r.name,
            "personnel_type": r.personnel_type
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["personnel_id", "name", "personnel_type"],
        "data": data_list
    }


# =================================================================
# ROUTE 3: Top N Actors by Projects (Query 5)
# =================================================================

@router.get(
    "/actors/top-projects",
    response_model=APIResponse,
    summary="(Q5)Top N Actors/Actresses with the most production projects"
)
def get_top_n_actors_by_projects(
    db: Session = Depends(get_db),
    n: int = Query(3, ge=1, description="The number of top actors/actresses to return.")
) -> Dict[str, Any]:
    """
    Calculates and returns the top `n` actors/actresses based on their total number of production assignments.
    """
    stmt = (
        select(
            Personnel.name,
            func.count(PersonnelAssignment.production_id).label("total_projects")
        )
        .join(PersonnelAssignment, Personnel.personnel_id == PersonnelAssignment.personnel_id)
        .where(Personnel.personnel_type.in_(['Actor', 'Actress']))
        .group_by(Personnel.name)
        .order_by(literal_column("total_projects").desc())
        .limit(n)
    )
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "name": r.name,
            "total_projects": r.total_projects
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["name", "total_projects"],
        "data": data_list
    }


# =================================================================
# ROUTE 4: Least N Actors by Jobs (Query 6)
# =================================================================

@router.get(
    "/actors/least-jobs",
    response_model=APIResponse,
    summary="(Q6)N Actors/Actresses with the least jobs"
)
def get_least_n_actors_by_jobs(
    db: Session = Depends(get_db),
    n: int = Query(5, ge=1, description="The number of actors/actresses with the least jobs to return.")
) -> Dict[str, Any]:
    """
    Calculates and returns the least `n` actors/actresses based on their total number of production assignments, 
    including those with zero assignments (jobs).
    """
    stmt = (
        select(
            Personnel.name,
            func.count(PersonnelAssignment.production_id).label("total_jobs")
        )
        .outerjoin(PersonnelAssignment, Personnel.personnel_id == PersonnelAssignment.personnel_id)
        .where(Personnel.personnel_type.in_(['Actor', 'Actress']))
        .group_by(Personnel.name)
        .order_by(literal_column("total_jobs").asc())
        .limit(n)
    )
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "name": r.name,
            "total_jobs": r.total_jobs
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["name", "total_jobs"],
        "data": data_list
    }