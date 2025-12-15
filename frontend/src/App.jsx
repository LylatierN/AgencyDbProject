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
  };  // This function will be called by Query component when user submits


  // This function will be called by Query component when user submits
  const handleQuerySubmit = async (queryType, queryParams) => {
    console.log('Query submitted:', queryType, queryParams);
    
    try {
      let response;
      
      // Route query to appropriate API endpoint
      switch(queryType) {
        case 'employees_by_position':
          response = await api.employees_by_position(queryParams);
          break;
        case 'activities_on_dates':
          response = await api.activities_on_dates(queryParams);
          break;
        case 'employees_available':
          response = await api.free_employees_by_role(queryParams);
          break;
        case 'location_available':
          response = await api.location_on_dates(queryParams);
          break;
        case 'top_actors':
          response = await api.top_actors(queryParams);
          break;
        case 'least_job':
          response = await api.least_job(queryParams);
          break;
        case 'employees_assign':
          response = await api.employees_assign(queryParams);
          break;
        case 'music_release':
          response = await api.music_release(queryParams);
          break;
        case 'location_use':
          response = await api.location_use(queryParams);
          break;
        case 'performer_partner':
          response = await api.performer_partner(queryParams);
          break;
        case 'production_expense':
          response = await api.production_expense(queryParams);
          break;
        case 'upcoming_production':
          response = await api.upcoming_production(queryParams);
          break;
        case 'all_performer':
          response = await api.all_performer(queryParams);
          break;
        default:
          console.error('Unknown query type:', queryType);
          alert('Unknown query type: ' + queryType);
          return;
      }
      console.log('API Response:', response);
      // Update state with response data (using your backend structure)
      setAllData(response.data);          // Store all data
      setResultsData(response.data);      // Display all data
      setNumData(response.counted);       // Store count from backend
      setAllKey(response.keys);           // Store keys from backend
      setFilteredCount(response.counted); // Set filtered count to total
    } catch (error) {
      console.error('Error fetching data:', error);
      alert(`Failed to fetch data: ${error.message}\n\nMake sure the backend is running on port 8000.`);
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
