import './App.css';
import Header from './components/Header.jsx';
import SearchBar from './components/SearchBar.jsx';
import Query from './components/Query.jsx';
import Results from './components/Result.jsx';
import { useState } from 'react';

function App() {
  // All data from backend
  const [allData, setAllData] = useState([
    { id: 1, name: 'Sample Data 1', value: 'Value 1' },
    { id: 2, name: 'Sample Data 2', value: 'Value 2' },
    { id: 3, name: 'Sample Data 3', value: 'Value 3' },
    { id: 4, name: 'Sample Data 4', value: 'Value 4' },
    { id: 5, name: 'Sample Data 5', value: 'Value 5' },
  ]);
  
  // Filtered data for display
  const [resultsData, setResultsData] = useState(allData);

  // Handle frontend search - filter existing data
  const handleSearch = (searchTerm) => {
    console.log('Searching for:', searchTerm);
    
    if (!searchTerm.trim()) {
      // If search is empty, show all data
      setResultsData(allData);
      return;
    }

    // Filter data based on search term
    const filtered = allData.filter(item => {
      const searchLower = searchTerm.toLowerCase();
      return (
        item.name?.toLowerCase().includes(searchLower) ||
        item.value?.toLowerCase().includes(searchLower) ||
        item.id?.toString().includes(searchLower)
      );
    });
    
    setResultsData(filtered);
  };

  // This function will be called by Query component when user submits
  const handleQuerySubmit = async (queryType, queryParams) => {
    console.log('Query submitted:', queryType, queryParams);
    // TODO: Replace with actual API call to get new data
    // const response = await fetch(`/api/${queryType}`, {
    //   method: 'POST',
    //   body: JSON.stringify(queryParams)
    // });
    // const data = await response.json();
    // setAllData(data);  // Store all data
    // setResultsData(data);  // Display all data
  };

  return (
    <div className="bg-gray-100 h-screen flex flex-col overflow-hidden">
      <Header />
      <div className="flex-shrink-0 bg-gray-100 py-8 px-4 space-y-6">
        <Query onQuerySubmit={handleQuerySubmit} />
      </div>
      <div className="flex-shrink-0 bg-gray-100 py-0 px-4 flex justify-start w-full mb-4 mx-5">
        <SearchBar onSearch={handleSearch} />
      </div>
      <div className="flex-1 bg-gray-100 px-4 pb-8 min-h-0 max-h-screen mx-5">
        <Results data={resultsData} />
      </div>
    </div>
  );
}

export default App;
