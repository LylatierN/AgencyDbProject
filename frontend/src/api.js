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

// ====================================================
// PERSONNEL ENDPOINTS
// ====================================================
export const queryEmployeesByPosition = (position, limit = 10) =>
  apiCall(`/personnel/by-type?personnel_types=${encodeURIComponent(position)}&limit=${limit}`);

export const queryAvailableEmployees = (startDt, endDt, types = ['Actor', 'Crew']) =>
  apiCall(`/personnel/available?start_dt=${encodeURIComponent(startDt)}&end_dt=${encodeURIComponent(endDt)}&personnel_types=${types.join(',')}`);

// ====================================================
// RENTAL ENDPOINTS
// ====================================================
export const queryAvailableLocations = (startDt, endDt) =>
  apiCall(`/rental/available?start_dt=${encodeURIComponent(startDt)}&end_dt=${encodeURIComponent(endDt)}`);

export const queryLocationsInUse = (targetDate) =>
  apiCall(`/rental/in-use-on-date?target_date=${encodeURIComponent(targetDate)}`);

// ====================================================
// SCHEDULE ENDPOINTS
// ====================================================
export const queryActivityCounts = (startDt, endDt) =>
  apiCall(`/schedule/activity/counts?start_dt=${encodeURIComponent(startDt)}&end_dt=${encodeURIComponent(endDt)}`);

export const queryMusicProductions = (startDate) =>
  apiCall(`/schedule/production/music?start_date=${encodeURIComponent(startDate)}`);

export const queryUpcomingSchedules = () =>
  apiCall('/schedule/upcoming');

// ====================================================
// GENERAL STATS ENDPOINTS
// ====================================================
export const queryPersonnelAssignments = (nameSearch = null, titleSearch = null) => {
  let url = '/stats/personnel/assignments';
  const params = [];
  if (nameSearch) params.push(`name_search=${encodeURIComponent(nameSearch)}`);
  if (titleSearch) params.push(`title_search=${encodeURIComponent(titleSearch)}`);
  if (params.length) url += '?' + params.join('&');
  return apiCall(url);
};

export const queryPersonnelContracts = (startDate, endDate, nameSearch = null) => {
  let url = `/stats/personnel/contracts?start_date=${encodeURIComponent(startDate)}&end_date=${encodeURIComponent(endDate)}`;
  if (nameSearch) url += `&name_search=${encodeURIComponent(nameSearch)}`;
  return apiCall(url);
};

export const queryTopActors = (limit = 3) =>
  apiCall(`/stats/top-actors?limit=${limit}`);

export const queryLeastJobActors = (limit = 5) =>
  apiCall(`/stats/least-job-actors?limit=${limit}`);

export const queryProductionsByPartner = (nameSearch = null) => {
  let url = '/stats/production/by-partner';
  if (nameSearch) url += `?partner_search=${encodeURIComponent(nameSearch)}`;
  return apiCall(url);
};

export const queryAllPerformers = () =>
  apiCall('/stats/all-performers');

export const queryProductionExpenses = (productionId = null) => {
  let url = '/stats/production/expenses';
  if (productionId) url += `?production_id=${productionId}`;
  return apiCall(url);
};
