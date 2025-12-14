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
      
      // Route query to appropriate API endpoint
      switch(queryType) {
        case 'personnel':
          response = await api.queryPersonnel(queryParams);
          break;
        case 'rental':
          response = await api.queryRental(queryParams);
          break;
        case 'schedule':
          response = await api.queryScheduleActivity(queryParams);
          break;
        case 'stats':
          response = await api.queryGeneralStats(queryParams);
          break;
        default:
          console.error('Unknown query type:', queryType);
          return;
      }
      
      setAllData(response.data || response);
      setResultsData(response.data || response);
      setNumData((response.data || response).length);
      setAllKey(Object.keys((response.data || response)[0] || {}));
    } catch (error) {
      console.error('Error fetching data:', error);
      alert('Failed to fetch data. Make sure the backend is running.');
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
