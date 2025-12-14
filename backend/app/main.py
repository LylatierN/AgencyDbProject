from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers import general_stats, personnel, rental, schedule_activity
from .database import Base, engine

Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Entertainment Agency Database API",
    version="1.0.0"
)

# Enable CORS for frontend communication
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, replace with specific domains
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(personnel.router)
app.include_router(rental.router)
app.include_router(schedule_activity.router)
app.include_router(general_stats.router)


@app.get("/")
def root():
    return {"message": "Backend is running"}
