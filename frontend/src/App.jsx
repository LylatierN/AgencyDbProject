import './App.css';
import Header from './components/Header.jsx';
import SearchBar from './components/SearchBar.jsx';
import Query from './components/Query.jsx';
import Results from './components/Result.jsx';
import { useState } from 'react';
import * as api from './api.js';

function App() {
  // All data from backend
  const [allData, setAllData] = useState([]);

  const [numData, setNumData] = useState(0);
  
  const [allKey, setAllKey] = useState(
    []
  );
  
  // Filtered data for display
  const [resultsData, setResultsData] = useState(allData);
  const [filteredCount, setFilteredCount] = useState(numData);

  // Handle frontend search - filter existing data
  const handleSearch = (searchTerm) => {
    console.log('Searching for:', searchTerm);
    
    if (!searchTerm.trim()) {
      // If search is empty, show all data
      setResultsData(allData);
      setFilteredCount(allData.length);
      return;
    }

    // Filter data based on search term
    const filtered = allData.filter(item => {
      const searchLower = searchTerm.toLowerCase();
      // Check all keys dynamically
      return allKey.some(key => 
        item[key]?.toString().toLowerCase().includes(searchLower)
      );
    });
    
    setResultsData(filtered);
    setFilteredCount(filtered.length);
  };

  // This function will be called by Query component when user submits
  const handleQuerySubmit = async (queryType, queryParams) => {
    console.log('Query submitted:', queryType, queryParams);
    
    try {
      let response;
      
      // Route query to appropriate API endpoint based on query type
      switch(queryType) {
        case 'employees_by_position':
          response = await api.queryEmployeesByPosition(queryParams.position, queryParams.limit);
          break;
        case 'activities_on_dates':
          response = await api.queryActivityCounts(queryParams.startDt, queryParams.endDt);
          break;
        case 'employees_available':
          response = await api.queryAvailableEmployees(queryParams.startDt, queryParams.endDt, queryParams.types);
          break;
        case 'location_available':
          response = await api.queryAvailableLocations(queryParams.startDt, queryParams.endDt);
          break;
        case 'top_actors':
          response = await api.queryTopActors(queryParams.limit);
          break;
        case 'least_job':
          response = await api.queryLeastJobActors(queryParams.limit);
          break;
        case 'employees_assign':
          response = await api.queryPersonnelAssignments(queryParams.nameSearch, queryParams.titleSearch);
          break;
        case 'music_release':
          response = await api.queryMusicProductions(queryParams.startDate);
          break;
        case 'location_use':
          response = await api.queryLocationsInUse(queryParams.targetDate);
          break;
        case 'performer_partner':
          response = await api.queryAllPerformers();
          break;
        case 'upcoming_production':
          response = await api.queryUpcomingSchedules();
          break;
        case 'all_performer':
          response = await api.queryAllPerformers();
          break;
        default:
          console.error('Unknown query type:', queryType);
          alert('Unknown query type');
          return;
      }
      
      // The response should be APIResponse format with count, key, and data
      setAllData(response.data || []);
      setResultsData(response.data || []);
      setNumData(response.count || response.data?.length || 0);
      setAllKey(response.key || Object.keys((response.data || [{}])[0]));
      
      console.log('Data loaded successfully:', response.count, 'records');
    } catch (error) {
      console.error('Error fetching data:', error);
      alert('Failed to fetch data. Make sure the backend is running. Check console for details.');
    }
  };

  return (
    <div className="bg-gray-100 h-screen flex flex-col overflow-hidden">
      <Header />
      <div className="flex-shrink-0 bg-gray-100 py-8 px-4 space-y-6">
        <Query onQuerySubmit={handleQuerySubmit} />
      </div>
      <div className="flex-shrink-0 bg-gray-100 py-0 px-4 flex justify-between w-90 mb-4 mx-5 me-5">
        <SearchBar onSearch={handleSearch} />
        <div className="text-gray-700 flex gap-4">
            <strong>{filteredCount}</strong>
        </div>
      </div>
      <div className="flex-1 bg-gray-100 px-4 pb-8 min-h-0 max-h-screen mx-5">
        <Results data={resultsData} />
      </div>
    
    </div>
  );
}

export default App;
