# Complete Query Mapping: Frontend ↔ Backend

## ✅ COMPLETED & TESTED

### 1. Employees by Position
- **Query Type**: `employees_by_position`
- **Frontend Component**: `EmployeesByPosition.jsx` ✅ UPDATED
- **Backend Endpoint**: `GET /personnel/by-type`
- **Parameters**: `position` (array), `limit` (int)
- **Returns**: List of personnel matching position type

---

## 🚧 NEEDS QUERY COMPONENT UPDATES

Below are the remaining queries that have backend endpoints but need frontend component handlers:

### 2. Activities on Dates
- **Query Type**: `activities_on_dates`
- **Frontend Component**: `ActivitiesOnDates.jsx` ⚠️ NEEDS UPDATE
- **Backend Endpoint**: `GET /schedule/activity/counts`
- **Parameters**: 
  ```javascript
  {
    startDt: "2024-02-10T09:00:00",
    endDt: "2024-02-10T12:00:00"
  }
  ```
- **Returns**: Task name and count of activities in time range

### 3. Free Employees by Role
- **Query Type**: `employees_available`
- **Frontend Component**: `FreeEmployeesByRole.jsx` ⚠️ NEEDS UPDATE
- **Backend Endpoint**: `GET /personnel/available`
- **Parameters**:
  ```javascript
  {
    startDt: "2024-02-10T09:00:00",
    endDt: "2024-02-10T12:00:00",
    types: ["Actor", "Crew"]  // Optional
  }
  ```
- **Returns**: Available personnel in date range

### 4. Location Available on Dates
- **Query Type**: `location_available`
- **Frontend Component**: `LocationOnDates.jsx` ⚠️ NEEDS UPDATE
- **Backend Endpoint**: `GET /rental/available`
- **Parameters**:
  ```javascript
  {
    startDt: "2024-02-10T09:00:00",
    endDt: "2024-02-10T12:00:00"
  }
  ```
- **Returns**: Available rental places in date range

### 5. Top Actors
- **Query Type**: `top_actors`
- **Frontend Component**: `TopActors.jsx` ⚠️ NEEDS UPDATE
- **Backend Endpoint**: `GET /stats/top-actors`
- **Parameters**:
  ```javascript
  {
    limit: 3  // Number of top actors to return
  }
  ```
- **Returns**: Top N actors by number of productions

### 6. Least Job Actors
- **Query Type**: `least_job`
- **Frontend Component**: `LeastJob.jsx` ⚠️ NEEDS UPDATE
- **Backend Endpoint**: `GET /stats/least-job-actors`
- **Parameters**:
  ```javascript
  {
    limit: 5  // Number of least-active actors to return
  }
  ```
- **Returns**: Actors with fewest projects

### 7. Employees and their Assignments
- **Query Type**: `employees_assign`
- **Frontend Component**: `EmployeesAssign.jsx` ⚠️ NEEDS UPDATE
- **Backend Endpoint**: `GET /stats/personnel/assignments`
- **Parameters**:
  ```javascript
  {
    nameSearch: "Alice",      // Optional: filter by personnel name
    titleSearch: "Moonlight"  // Optional: filter by production title
  }
  ```
- **Returns**: Personnel with their production assignments and roles

### 8. Music Production Releases
- **Query Type**: `music_release`
- **Frontend Component**: `MusicRelease.jsx` ⚠️ NEEDS UPDATE
- **Backend Endpoint**: `GET /schedule/production/music`
- **Parameters**:
  ```javascript
  {
    startDate: "2024-01-01"  // Contract date filter
  }
  ```
- **Returns**: Music productions with performers and release info

### 9. Locations in Use on Specific Date
- **Query Type**: `location_use`
- **Frontend Component**: `LocationUse.jsx` ⚠️ NEEDS UPDATE
- **Backend Endpoint**: `GET /rental/in-use-on-date`
- **Parameters**:
  ```javascript
  {
    targetDate: "2024-02-10"  // Date to check (YYYY-MM-DD)
  }
  ```
- **Returns**: Rental places with current usage

### 10. All Performers
- **Query Type**: `all_performer`
- **Frontend Component**: `AllPerformer.jsx` ⚠️ NEEDS UPDATE
- **Backend Endpoint**: `GET /stats/all-performers`
- **Parameters**: None (no parameters needed)
- **Returns**: All performers with their types and agencies

### 11. Performer Partner Information
- **Query Type**: `performer_partner`
- **Frontend Component**: `PerformerPartner.jsx` ⚠️ NEEDS UPDATE
- **Backend Endpoint**: `GET /stats/production/by-partner`
- **Parameters**: Optional name search
- **Returns**: Partners and their associated performers

### 12. Upcoming Production Schedule
- **Query Type**: `upcoming_production`
- **Frontend Component**: `UpcomingProduction.jsx` ⚠️ NEEDS UPDATE
- **Backend Endpoint**: `GET /schedule/upcoming`
- **Parameters**: None
- **Returns**: Upcoming production schedules

---

## 📝 How to Update Each Query Component

### Step 1: Add Input Fields
```jsx
constructor(props) {
  super(props)
  this.state = {
    // Add fields needed for this query
    position: '',
    limit: 5,
    startDate: ''
  }
}
```

### Step 2: Create Change Handlers
```jsx
handlePositionChange = (e) => {
  this.setState({ position: e.target.value })
}

handleLimitChange = (e) => {
  this.setState({ limit: parseInt(e.target.value) })
}
```

### Step 3: Create Submit Handler
```jsx
handleSubmit = () => {
  // Validate inputs
  if (!this.state.position) {
    alert('Please select a position');
    return;
  }

  // Call parent with correct query type and params
  this.props.onQuerySubmit('employees_by_position', {
    position: [this.state.position],
    limit: this.state.limit
  });
}
```

### Step 4: Render Form
```jsx
render() {
  return (
    <div className="flex items-center flex-wrap gap-4 w-full">
      {/* Input fields */}
      <select value={this.state.position} onChange={this.handlePositionChange}>
        {/* options */}
      </select>

      {/* Submit button */}
      <button
        onClick={(e) => {
          e.stopPropagation();
          this.handleSubmit();
        }}
        className="px-6 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition font-semibold"
      >
        Search
      </button>
    </div>
  )
}
```

---

## 🔍 Backend Endpoints Already Implemented

All of these are ready to use, just need frontend components:

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/personnel/by-type` | GET | Filter personnel by position |
| `/personnel/available` | GET | Find free personnel in date range |
| `/rental/available` | GET | Find available rental places |
| `/rental/in-use-on-date` | GET | Rental places in use on specific date |
| `/schedule/activity/counts` | GET | Count activities by type in range |
| `/schedule/production/music` | GET | Music productions with performers |
| `/schedule/upcoming` | GET | Upcoming production schedules |
| `/stats/personnel/assignments` | GET | Personnel and their assignments |
| `/stats/personnel/contracts` | GET | Personnel contracts in date range |
| `/stats/top-actors` | GET | Top N actors by projects |
| `/stats/least-job-actors` | GET | N actors with fewest projects |
| `/stats/production/by-partner` | GET | Productions grouped by partner |
| `/stats/all-performers` | GET | All performers and their info |
| `/stats/production/expenses` | GET | Production expenses breakdown |

---

## ✨ Priority Order for Updates

1. **HIGH PRIORITY** (Most commonly used)
   - TopActors.jsx - Need limit input
   - LeastJob.jsx - Need limit input
   - ActivitiesOnDates.jsx - Need date range inputs
   - FreeEmployeesByRole.jsx - Need date range + role selection

2. **MEDIUM PRIORITY** (Important features)
   - LocationOnDates.jsx - Need date range inputs
   - MusicRelease.jsx - Need date input
   - EmployeesAssign.jsx - Need search inputs

3. **LOW PRIORITY** (Nice to have)
   - LocationUse.jsx - Need date input
   - AllPerformer.jsx - No inputs needed!
   - PerformerPartner.jsx - Optional search
   - UpcomingProduction.jsx - No inputs needed!
