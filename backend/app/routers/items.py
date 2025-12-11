from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from ..database import SessionLocal
from .. import crud, schemas

router = APIRouter(prefix="/items", tags=["Items"])


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get("/", response_model=list[schemas.Item])
def read_items(db: Session = Depends(get_db)):
    return crud.get_items(db)


@router.post("/", response_model=schemas.Item)
def create_items(item: schemas.ItemCreate, db: Session = Depends(get_db)):
    return crud.create_item(db, item)


@router.put("/{id}")
def update_item(id: int, item: schemas.ItemCreate, db: Session = Depends(get_db)):
    return crud.update_item(db, id, item)


@router.delete("/{id}")
def delete_item(id: int, db: Session = Depends(get_db)):
    return crud.delete_item(db, id)


@router.get("/search")
def search_items(q: str, db: Session = Depends(get_db)):
    return crud.search_items(db, q)
