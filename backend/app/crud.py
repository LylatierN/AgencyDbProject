from sqlalchemy.orm import Session
from . import models, schemas


def get_items(db: Session):
    return db.query(models.Item).all()


def create_item(db: Session, item: schemas.ItemCreate):
    db_item = models.Item(name=item.name, description=item.description)
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item


def update_item(db: Session, id: int, item: schemas.ItemCreate):
    db_item = db.query(models.Item).filter(models.Item.id == id).first()
    if not db_item:
        return None
    db_item.name = item.name
    db_item.description = item.description
    db.commit()
    return db_item


def delete_item(db: Session, id: int):
    db_item = db.query(models.Item).filter(models.Item.id == id).first()
    if not db_item:
        return None
    db.delete(db_item)
    db.commit()
    return True


def search_items(db: Session, keyword: str):
    return db.query(models.Item).filter(models.Item.name.like(f"%{keyword}%")).all()
