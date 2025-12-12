from fastapi import FastAPI
from app.routers import general_stats, personnel, rental, schedule_activity
from database import Base, engine

Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Production Database API",
    version="1.0.0"
)

app.include_router(personnel.router)
app.include_router(rental.router)
app.include_router(schedule_activity.router)
app.include_router(general_stats.router)


@app.get("/")
def root():
    return {"message": "Backend is running"}
