from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base, Session
import os
from dotenv import load_dotenv
from typing import Generator

load_dotenv()

DATABASE_URL = (
    f"mysql+pymysql://{os.getenv('DB_USER')}:{os.getenv('DB_PASS')}"
    f"@{os.getenv('DB_HOST')}/{os.getenv('DB_NAME')}"
)

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(
    autocommit=False, 
    autoflush=False, 
    bind=engine
)

Base = declarative_base()

def get_db() -> Generator[Session, None, None]:
    """
    Dependency function that yields a database session.
    It ensures the session is properly closed after the request is processed.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
