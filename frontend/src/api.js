// API configuration for frontend
const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:2300';

export const apiCall = async (endpoint, options = {}) => {
  const url = `${API_BASE_URL}${endpoint}`;
  
  try {
    const response = await fetch(url, {
      headers: {
        'Content-Type': 'application/json',
        ...options.headers,
      },
      ...options,
    });

    if (!response.ok) {
      throw new Error(`API Error: ${response.statusText}`);
    }

    return await response.json();
  } catch (error) {
    console.error('API call failed:', error);
    throw error;
  }
};

// Query endpoints - Personnel Management
export const EmployeesByPosition = (params) => 
  apiCall('/personnel/by-type', { 
    method: 'GET', 
    body: JSON.stringify(params) 
  });

export const FreeEmployeesByRole = (params) => 
  apiCall('/personnel/available', { 
    method: 'GET', 
    body: JSON.stringify(params) 
  });

export const TopActors = (params) => 
  apiCall('/personnel/actors/top-projects', { 
    method: 'GET', 
    body: JSON.stringify(params) 
  });

export const LeastJob = (params) => 
  apiCall('/personnel/actors/least-jobs', { 
    method: 'GET', 
    body: JSON.stringify(params) 
  });

// Query endpoints - Rental Management
export const LocationOnDates = (params) => 
  apiCall('/rental/available', { 
    method: 'GET', 
    body: JSON.stringify(params) 
  });

export const LocationUse = (params) => 
  apiCall('/rental/in-use-on-date', { 
    method: 'GET', 
    body: JSON.stringify(params) 
  });

// Query endpoints - Schedule & Activity
export const ActivitiesOnDates = (params) => 
  apiCall('/schedule/activity/counts', { 
    method: 'GET', 
    body: JSON.stringify(params) 
  });

export const MusicRelease = (params) => 
  apiCall('/schedule/production/music', { 
    method: 'GET', 
    body: JSON.stringify(params) 
  });

export const UpcomingProduction = (params) => 
  apiCall('/schedule/upcoming', { 
    method: 'GET', 
    body: JSON.stringify(params) 
  });

// Query endpoints - General Listings & Statistics
export const EmployeesAssign = (params) => 
  apiCall('/stats/personnel/assignments', { 
    method: 'GET', 
    body: JSON.stringify(params) 
  });

export const ContractOverlap = (params) => 
  apiCall('/stats/personnel/contracts', { 
    method: 'GET', 
    body: JSON.stringify(params) 
  });

export const ProductionExpense = (params) =>
  apiCall("/stats/production/expenses/summary", {
    method: "GET",
    params: 
      JSON.stringify(params)
  });

export const AllPerformer = (params) =>
  apiCall("/stats/performers", {
    method: "GET",
    params: 
      JSON.stringify(params)
  });
  
export const PerformerPartner = (params) =>
  apiCall("/stats/partners/for-performer", {
    method: "GET",
    params: 
      JSON.stringify(params)
  });
