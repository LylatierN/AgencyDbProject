from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from sqlalchemy import select, cast, Date
from datetime import datetime, date
from typing import Dict, Any, List

from ..models import RentalPlace, RentalUsage
from ..schemas import APIResponse
from ..database import get_db

router = APIRouter(
    prefix="/rental",
    tags=["Rental Management"]
)

# =================================================================
# ROUTE 1: Find Available Rental Places (Query 3)
# =================================================================

@router.get(
    "/available",
    response_model=APIResponse,
    summary="(Q3)Find available rental places for a given datetime range"
)
def get_available_rental_places(
    db: Session = Depends(get_db),
    start_dt: datetime = Query(..., description="Start datetime of the required rental period."),
    end_dt: datetime = Query(..., description="End datetime of the required rental period.")
) -> Dict[str, Any]:
    """
    Finds rental places that have no usage conflict between `start_dt` and `end_dt`.
    """
    conflicting_place_ids = (
        select(RentalUsage.place_id)
        .where(
            RentalUsage.start_time < end_dt,
            RentalUsage.end_time > start_dt
        )
        .distinct()
    ).scalar_subquery()

    stmt = (
        select(
            RentalPlace.place_id,
            RentalPlace.name,
            RentalPlace.address,
            RentalPlace.type,
            RentalPlace.capacity
        )
        .where(RentalPlace.place_id.not_in(conflicting_place_ids))
    )
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "place_id": r.place_id,
            "name": r.name,
            "address": r.address,
            "type": r.type,
            "capacity": r.capacity
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["place_id", "name", "address", "type", "capacity"],
        "data": data_list
    }


# =================================================================
# ROUTE 2: Places In Use on Date (Query 10)
# =================================================================

@router.get(
    "/in-use-on-date",
    response_model=APIResponse,
    summary="(Q10)List all rental places in use on a specific date"
)
def get_places_in_use_on_date(
    db: Session = Depends(get_db),
    target_date: date = Query(..., description="The date (YYYY-MM-DD) to check for rental usage.")
) -> Dict[str, Any]:
    """
    Finds rental places with usage that overlaps with any time on the specified `target_date`.
    """
    stmt = (
        select(
            RentalPlace.name,
            RentalPlace.address,
            RentalUsage.start_time,
            RentalUsage.end_time
        )
        .join(RentalUsage, RentalPlace.place_id == RentalUsage.place_id)
        .where(
            cast(RentalUsage.start_time, Date) <= target_date,
            cast(RentalUsage.end_time, Date) >= target_date
        )
        .distinct()
    )
    result = db.execute(stmt).all()
    
    data_list = [
        {
            "name": r.name,
            "address": r.address,
            "start_time": r.start_time.isoformat(),
            "end_time": r.end_time.isoformat()
        }
        for r in result
    ]

    return {
        "count": len(data_list),
        "key": ["name", "address", "start_time", "end_time"],
        "data": data_list
    }