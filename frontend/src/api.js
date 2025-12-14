// API configuration for frontend
const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:8000';

export const apiCall = async (endpoint, options = {}) => {
  let url = `${API_BASE_URL}${endpoint}`;
  
  // Handle query parameters for GET requests
  if (options.params) {
    const queryString = new URLSearchParams(options.params).toString();
    if (queryString) {
      url += `?${queryString}`;
    }
  }
  
  try {
    const response = await fetch(url, {
      method: options.method || 'GET',
      headers: {
        'Content-Type': 'application/json',
        ...options.headers,
      },
      ...(options.body && { body: JSON.stringify(options.body) }),
    });

    if (!response.ok) {
      const errorText = await response.text();
      throw new Error(`API Error (${response.status}): ${response.statusText} - ${errorText}`);
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
    params: params 
  });

export const free_employees_by_role = (params) => 
  apiCall('/personnel/available', { 
    method: 'GET', 
    params: params 
  });

export const top_actors = (params) => 
  apiCall('/personnel/actors/top-projects', { 
    method: 'GET', 
    params: params 
  });

export const least_job = (params) => 
  apiCall('/personnel/actors/least-jobs', { 
    method: 'GET', 
    params: params 
  });

// Query endpoints - Rental Management
export const location_on_dates = (params) => 
  apiCall('/rental/available', { 
    method: 'GET', 
    params: params 
  });

export const location_use = (params) => 
  apiCall('/rental/in-use-on-date', { 
    method: 'GET', 
    params: params 
  });

// Query endpoints - Schedule & Activity
export const activities_on_dates = (params) => 
  apiCall('/schedule/activity/counts', { 
    method: 'GET', 
    params: params 
  });

export const music_release = (params) => 
  apiCall('/schedule/production/music', { 
    method: 'GET', 
    params: params 
  });

export const upcoming_production = (params) => 
  apiCall('/schedule/upcoming', { 
    method: 'GET', 
    params: params 
  });

// Query endpoints - General Listings & Statistics
export const employees_assign = (params) => 
  apiCall('/stats/personnel/assignments', { 
    method: 'GET', 
    params: params 
  });

export const contract_overlap = (params) => 
  apiCall('/stats/personnel/contracts', { 
    method: 'GET', 
    params: params 
  });

export const production_expense = () =>
  apiCall("/stats/production/expenses/summary", {
    method: 'GET'
  });

export const all_performer = () =>
  apiCall("/stats/performers", {
    method: 'GET'
  });
  
export const performer_partner = (params) =>
  apiCall("/stats/partners/for-performer", {
    method: "GET",
    params: params
  });
