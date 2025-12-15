# 🎬 AgencyDB  
## Production & Talent Management Database (Website Query Project)

AgencyDB is a relational database system designed to support the operations of a **media and talent agency**.  
The database manages **personnel, performers, productions, schedules, rental venues, partners, and expenses**, and provides a collection of **practical SQL queries** that simulate real-world website/database usage.



## 📌 Project Scope & Purpose

The goal of this project is to design a database that can answer common operational questions for an agency, such as:

- Which actors or crew members are available at a given time?
- Which rental places are currently in use?
- Which productions have the highest expenses?
- Who are the most active actors?
- What upcoming schedules are planned?
---

## 📝 Project Structure
```
AgencyDbProject/
│
├── README.md
├── docker-compose.yml           # Docker orchestration
├── .env                         # Environment variables
│
├── backend/                     # FastAPI Backend
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── dbproject.sql           # Database schema & data
│   └── app/                    # API application
│       ├── main.py
│       ├── database.py
│       ├── models.py
│       ├── schemas.py
│       └── routers/            # API endpoints
│
└── frontend/                    # React Frontend
    ├── Dockerfile
    ├── package.json
    ├── public/                 # Static files
    └── src/                    # React app
        ├── App.jsx
        ├── api.js
        └── components/         # UI components
            └── queries/        # Query input components
```

---

## 📋 Available Queries

1. Find all employees in a specific position (Director, Actor, Costumer, etc.)
2. Find available employees by role within certain dates
3. Find top N actors with most production projects
4. Find N actors with least project assignments
5. Find amount of activities for each type between certain dates
6. List locations available on certain dates
7. List all rental places currently in use on a specific day
8. List music productions with performers and release info since a date
9. View upcoming production schedules
10. Find all partners of specific performers
11. List all performers data
12. View total expense amount for every production

---

## 🚀 How to Run

### Prerequisites
- Docker and Docker Compose installed
- Git (to clone the repository)

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/LylatierN/AgencyDbProject.git
   cd AgencyDbProject
   ```

2. **Set up environment variables**
   
   Create a `.env` file in the root directory:
   ```env
   DB_HOST=db
   DB_NAME=AgencyDb
   DB_USER=root
   DB_PASS=your_password
   DB_PORT=3306
   ```

3. **Build and run with Docker**
   ```bash
   docker compose up --build
   ```

4. **Access the application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000
   - API Documentation: http://localhost:8000/docs

### Development Mode

To run frontend with hot-reload (outside Docker):
```bash
cd frontend
npm install
npm start
```

Keep backend and database running in Docker for API access.

### Updating Database

If you modify `dbproject.sql`:
```bash
docker compose down -v
docker compose up --build
```

---



