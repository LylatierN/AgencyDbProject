from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from sqlalchemy import select, func
from datetime import datetime, date
from typing import List, Dict, Any

from ..models import (
    Personnel, 
    ProductionSchedule, 
    Production, 
    GeneralProduction, 
    PersonnelAssignment
) 

from ..schemas import APIResponse 
from ..database import get_db

router = APIRouter(
    prefix="/schedule",
    tags=["Schedule & Activity"]
)


# =================================================================
# ROUTE 1: Activity Type Counts (Query 4)
# =================================================================

@router.get(
    "/activity/counts",
    response_model=APIResponse,
    summary="(Q4)Count of activities (tasks) within a time range"
)
def get_activity_type_counts(
    db: Session = Depends(get_db),
    start_dt: datetime = Query(..., description="Start datetime for the count range."),
    end_dt: datetime = Query(..., description="End datetime for the count range.")
) -> Dict[str, Any]:
    """
    Counts the number of occurrences for each distinct task name 
    within the schedule between `start_dt` and `end_dt`.
    """
    stmt = (
        select(
            ProductionSchedule.taskname,
            func.count().label("activity_count")
        )
        .where(ProductionSchedule.start_dt >= start_dt)
        .where(ProductionSchedule.end_dt <= end_dt)
        .group_by(ProductionSchedule.taskname)
        .order_by(func.count().desc())
    )
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "taskname": r.taskname,
            "activity_count": r.activity_count
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["taskname", "activity_count"],
        "data": data_list
    }


# =================================================================
# ROUTE 2: Music Production Details (Query 9)
# =================================================================

@router.get(
    "/production/music",
    response_model=APIResponse,
    summary="(Q9)List Music Productions with Performer and Release Info"
)
def get_music_production_details(
    db: Session = Depends(get_db),
    start_date: date = Query(..., description="Contract hire date start filter.")
) -> Dict[str, Any]:
    """
    Finds all general productions with the genre 'Music' that were contracted on 
    or after the `start_date`, listing the assigned performer(s) and planned release details.
    """
    stmt = (
        select(
            Production.title.label("production_title"),
            Personnel.name.label("performer_name"),
            GeneralProduction.plan_release_quarter,
            GeneralProduction.plan_release_year
        )
        .join(GeneralProduction, Production.production_id == GeneralProduction.production_id)
        .join(PersonnelAssignment, Production.production_id == PersonnelAssignment.production_id)
        .join(Personnel, PersonnelAssignment.personnel_id == Personnel.personnel_id)
        .where(GeneralProduction.genre == 'Music')
        .where(Production.contract_hire_date >= start_date)
        .order_by(Production.title, Personnel.name)
    )
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "production_title": r.production_title,
            "performer_name": r.performer_name,
            "plan_release_quarter": r.plan_release_quarter,
            "plan_release_year": r.plan_release_year
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["production_title", "performer_name", "plan_release_quarter", "plan_release_year"],
        "data": data_list
    }


# =================================================================
# ROUTE 3: Upcoming Schedule (Query 14)
# =================================================================

@router.get(
    "/upcoming",
    response_model=APIResponse,
    summary="(Q14)List upcoming production schedules"
)
def get_upcoming_schedule(
    db: Session = Depends(get_db),
    # Optional parameter defaults to current time if not provided
    current_datetime: datetime = Query(datetime.now(), description="Schedules starting at or after this datetime.")
) -> Dict[str, Any]:
    """
    Retrieves all production schedule entries that are upcoming (start at or after 
    the specified datetime).
    """
    stmt = (
        select(
            ProductionSchedule.start_dt,
            ProductionSchedule.end_dt,
            ProductionSchedule.taskname,
            ProductionSchedule.location,
            Production.title.label("production_title"),
            Personnel.name.label("personnel_name")
        )
        .join(Production, ProductionSchedule.production_id == Production.production_id)
        .join(Personnel, ProductionSchedule.personnel_id == Personnel.personnel_id)
        .where(ProductionSchedule.start_dt >= current_datetime)
        .order_by(ProductionSchedule.start_dt)
    )
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "start_dt": r.start_dt.isoformat(),
            "end_dt": r.end_dt.isoformat(),
            "taskname": r.taskname,
            "location": r.location,
            "production_title": r.production_title,
            "personnel_name": r.personnel_name
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["start_dt", "end_dt", "taskname", "location", "production_title", "personnel_name"],
        "data": data_list
    }