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
export const employees_by_position = (params) => 
  apiCall('/personnel/by-type', { 
    method: 'GET', 
    params: JSON.stringify(params) 
  });

export const free_employees_by_role = (params) => 
  apiCall('/personnel/available', { 
    method: 'GET', 
    params: JSON.stringify(params) 
  });

export const top_actors = (params) => 
  apiCall('/personnel/actors/top-projects', { 
    method: 'GET', 
    params: JSON.stringify(params) 
  });

export const least_job = (params) => 
  apiCall('/personnel/actors/least-jobs', { 
    method: 'GET', 
    params: JSON.stringify(params) 
  });

// Query endpoints - Rental Management
export const location_on_dates = (params) => 
  apiCall('/rental/available', { 
    method: 'GET', 
    params: JSON.stringify(params) 
  });

export const location_use = (params) => 
  apiCall('/rental/in-use-on-date', { 
    method: 'GET', 
    params: JSON.stringify(params) 
  });

// Query endpoints - Schedule & Activity
export const activities_on_dates = (params) => 
  apiCall('/schedule/activity/counts', { 
    method: 'GET', 
    params: JSON.stringify(params) 
  });

export const music_release = (params) => 
  apiCall('/schedule/production/music', { 
    method: 'GET', 
    params: JSON.stringify(params) 
  });

export const upcoming_production = (params) => 
  apiCall('/schedule/upcoming', { 
    method: 'GET', 
    params: JSON.stringify(params) 
  });

// Query endpoints - General Listings & Statistics
export const employees_assign = (params) => 
  apiCall('/stats/personnel/assignments', { 
    method: 'GET', 
    params: JSON.stringify(params) 
  });

export const contract_overlap = (params) => 
  apiCall('/stats/personnel/contracts', { 
    method: 'GET', 
    params: JSON.stringify(params) 
  });

export const production_expense = (params) =>
  apiCall("/stats/production/expenses/summary");

export const all_performer = (params) =>
  apiCall("/stats/performers");
  
export const performer_partner = (params) =>
  apiCall("/stats/partners/for-performer", {
    method: "GET",
    params: JSON.stringify(params)
  });
