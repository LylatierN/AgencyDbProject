// API configuration for frontend
const API_BASE_URL = process.env.REACT_APP_API_URL || 'http://localhost:8000';

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

// Specific API endpoints
export const getPersonnel = () => apiCall('/personnel');
export const getRentals = () => apiCall('/rental');
export const getScheduleActivities = () => apiCall('/schedule-activity');
export const getGeneralStats = () => apiCall('/general-stats');

// Query endpoints
export const queryPersonnel = (params) => 
  apiCall('/personnel/query', { 
    method: 'POST', 
    body: JSON.stringify(params) 
  });

export const queryRental = (params) => 
  apiCall('/rental/query', { 
    method: 'POST', 
    body: JSON.stringify(params) 
  });

export const queryScheduleActivity = (params) => 
  apiCall('/schedule-activity/query', { 
    method: 'POST', 
    body: JSON.stringify(params) 
  });

export const queryGeneralStats = (params) => 
  apiCall('/general-stats/query', { 
    method: 'POST', 
    body: JSON.stringify(params) 
  });
