# Backend-Frontend Connectivity & Backend Functions - Analysis & Fixes

## Issues Found & Fixed

### 1. **Query Components Missing Submit Handlers** ✅ FIXED
**Problem**: Query components (EmployeesByPosition, etc.) had no way to submit data to the backend
**Solution**: 
- Added `handleSubmit()` method to query components
- Updated components to pass `onQuerySubmit` prop from parent
- Added submit buttons with proper parameter validation

### 2. **Query.jsx Not Passing Props to Child Components** ✅ FIXED
**Problem**: The Query.jsx component wasn't passing `onQuerySubmit` to child query components
**Solution**: Updated line that renders QueryComponent to include `onQuerySubmit={this.props.onQuerySubmit}`

### 3. **API Endpoints Mismatch** ✅ FIXED
**Problem**: 
- App.jsx was trying to call endpoints like `/personnel/query` and `/rental/query`
- Backend actually has endpoints like `/personnel/by-type`, `/personnel/available`, etc.

**Solution**: Updated `api.js` with correct endpoint mappings:
```
Backend Endpoints Available:
├── /personnel/by-type              → queryEmployeesByPosition()
├── /personnel/available            → queryAvailableEmployees()
├── /rental/available               → queryAvailableLocations()
├── /rental/in-use-on-date          → queryLocationsInUse()
├── /schedule/activity/counts       → queryActivityCounts()
├── /schedule/production/music      → queryMusicProductions()
├── /stats/personnel/assignments    → queryPersonnelAssignments()
├── /stats/personnel/contracts      → queryPersonnelContracts()
├── /stats/top-actors               → queryTopActors()
├── /stats/least-job-actors         → queryLeastJobActors()
├── /stats/production/by-partner    → queryProductionsByPartner()
├── /stats/all-performers           → queryAllPerformers()
└── /stats/production/expenses      → queryProductionExpenses()
```

### 4. **Query Type Names Mismatch** ✅ FIXED
**Problem**: App.jsx switch statement had query types like 'personnel', 'rental' but Query.jsx uses 'employees_by_position', 'location_available', etc.

**Solution**: Updated switch statement in App.jsx to match Query.jsx query type names exactly

### 5. **API Response Format Issues** ✅ FIXED
**Problem**: App.jsx wasn't properly handling the APIResponse format with count, key, and data fields

**Solution**: Updated handler to:
```javascript
setNumData(response.count || response.data?.length || 0);
setAllKey(response.key || Object.keys((response.data || [{}])[0]));
```

## Backend Architecture Overview

### Routers Structure:
1. **`personnel.py`** - Employee management queries
   - GET `/personnel/by-type` - Filter by position
   - GET `/personnel/available` - Find free employees in time range

2. **`rental.py`** - Rental location management
   - GET `/rental/available` - Find available places in date range
   - GET `/rental/in-use-on-date` - Places currently in use

3. **`schedule_activity.py`** - Schedule and activity tracking
   - GET `/schedule/activity/counts` - Activity counts by type in date range
   - GET `/schedule/production/music` - Music productions with performers

4. **`general_stats.py`** - General statistics and listings
   - GET `/stats/personnel/assignments` - All personnel and assignments
   - GET `/stats/personnel/contracts` - Personnel contracts in date range
   - GET `/stats/top-actors` - Top actors by number of projects
   - GET `/stats/least-job-actors` - Actors with least projects
   - GET `/stats/production/by-partner` - Productions grouped by partner
   - GET `/stats/all-performers` - All performers with details

### Response Format (All endpoints):
```json
{
  "count": 5,
  "key": ["personnel_id", "name", "personnel_type"],
  "data": [
    {"personnel_id": 1, "name": "Alice Kim", "personnel_type": "Actor"},
    ...
  ]
}
```

## Frontend Architecture Overview

### Query Flow:
1. **App.jsx** - Main component with state management
   - `handleQuerySubmit(queryType, queryParams)` - Receives query and params
   - Routes to appropriate API endpoint
   - Updates state with results

2. **Query.jsx** - Query selector component
   - Renders dropdown with all available queries
   - Passes selected query component with `onQuerySubmit` prop
   - Each query component is displayed in a form interface

3. **Query Components** (e.g., `EmployeesByPosition.jsx`)
   - Collect user input
   - Call `this.props.onQuerySubmit(queryType, params)` when submitted
   - Send structured parameters to parent

4. **SearchBar.jsx** - Frontend-side search filter
   - Filters already-loaded results
   - Doesn't make backend calls

5. **Result.jsx** - Results display
   - Shows data in table/grid format
   - Uses the `key` field to dynamically render columns

## Remaining Backend Features Not Yet Mapped to Frontend

These endpoints exist but Query components haven't been created yet:
- Top N actors by projects (TopActors.jsx needs `onQuerySubmit` handler)
- Least job actors (LeastJob.jsx needs handler)
- Upcoming production schedules (UpcomingProduction.jsx needs handler)
- All performers (AllPerformer.jsx needs handler)
- Location in use (LocationUse.jsx needs handler)
- Music releases (MusicRelease.jsx needs handler)
- Employee assignments (EmployeesAssign.jsx needs handler)
- Performer partners (PerformerPartner.jsx needs handler)
- Activities on dates (ActivitiesOnDates.jsx needs handler)
- Free employees by role (FreeEmployeesByRole.jsx needs handler)
- Location available (LocationOnDates.jsx needs handler)

## Next Steps to Complete Frontend

Each of the remaining query components needs:
1. Input fields for their specific parameters (dates, limits, search terms)
2. A `handleSubmit()` method that calls `this.props.onQuerySubmit(queryType, params)`
3. A submit button that triggers the handler
4. Parameter validation

## Testing the Connectivity

After these fixes, test with:
```bash
# Start the docker containers
docker-compose up --build

# Test a query in browser at http://localhost:3000
1. Select "Find all employees in a position"
2. Choose a position (e.g., "Actor")
3. Click Search
4. Check browser console (F12) for request details
5. Verify results display in the table below
```

## Debugging Tips

If queries don't work:
1. Check browser console (F12) for API errors
2. Check Network tab to see the actual API calls being made
3. Verify backend is running: `curl http://localhost:8000`
4. Check backend logs: `docker-compose logs -f api`
5. Verify database has data: `docker exec -it agency_mysql mysql -u root -p$env:DB_PASS agency_db -e "SELECT * FROM personnel LIMIT 5;"`
