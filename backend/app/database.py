# backend/app/database.py

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from sqlalchemy.exc import OperationalError
import os
import time

DATABASE_URL = (
    f"mysql+pymysql://{os.getenv('DB_USER')}:{os.getenv('DB_PASS')}"
    f"@{os.getenv('DB_HOST')}/{os.getenv('DB_NAME')}"
)

MAX_RETRIES = 10
RETRY_DELAY = 5 

engine = None 

for i in range(MAX_RETRIES):
    try:
        temp_engine = create_engine(
            DATABASE_URL,
            pool_pre_ping=True, 
            pool_recycle=3600
        )
        with temp_engine.connect():
            engine = temp_engine
            print("INFO: Database connection successful! FastAPI starting...")
            break 
            
    except OperationalError:
        if i < MAX_RETRIES - 1:
            print(f"WARNING: Database connection failed (Attempt {i+1}/{MAX_RETRIES}). Retrying in {RETRY_DELAY} seconds...")
            time.sleep(RETRY_DELAY)
        else:
            print(f"FATAL: Database connection failed after {MAX_RETRIES} attempts.")
            raise 

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()