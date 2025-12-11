from fastapi import FastAPI
from .routers import items
from .database import Base, engine

# auto create tables
Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(items.router)


@app.get("/")
def root():
    return {"message": "Backend is running"}
