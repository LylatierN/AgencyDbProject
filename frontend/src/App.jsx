import './App.css';
import Header from './components/Header.jsx';
import Query from './components/Query.jsx';

function App() {
  return (<>
    <Header />
    <div className="min-h-screen bg-gray-100 py-8 px-4">
      <Query />

    <div className="max-w-4xl mx-auto">
      <h1 className="text-4xl font-bold text-center text-blue-600 mb-8">
        Tailwind CSS Test Page
      </h1>

      {/* Card 1 - Colors & Spacing */}
      <div className="bg-white rounded-lg shadow-lg p-6 mb-6">
        <h2 className="text-2xl font-semibold text-gray-800 mb-4">
          Colors & Spacing Test
        </h2>
        <div className="flex gap-4 flex-wrap">
          <div className="bg-red-500 text-white p-4 rounded">Red</div>
          <div className="bg-green-500 text-white p-4 rounded">Green</div>
          <div className="bg-blue-500 text-white p-4 rounded">Blue</div>
          <div className="bg-purple-500 text-white p-4 rounded">Purple</div>
        </div>
      </div>

      {/* Card 2 - Typography */}
      <div className="bg-white rounded-lg shadow-lg p-6 mb-6">
        <h2 className="text-2xl font-semibold text-gray-800 mb-4">
          Typography Test
        </h2>
        <p className="text-sm text-gray-600 mb-2">Small text</p>
        <p className="text-base text-gray-700 mb-2">Base text</p>
        <p className="text-lg text-gray-800 mb-2">Large text</p>
        <p className="text-xl font-bold text-gray-900">Extra large bold text</p>
      </div>

      {/* Card 3 - Hover & Interactive */}
      <div className="bg-white rounded-lg shadow-lg p-6 mb-6">
        <h2 className="text-2xl font-semibold text-gray-800 mb-4">
          Interactive Elements
        </h2>
        <button className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mr-2 transition duration-300">
          Hover Me!
        </button>
        <button className="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded transition duration-300">
          Click Me!
        </button>
      </div>

      {/* Card 4 - Flexbox & Grid */}
      <div className="bg-white rounded-lg shadow-lg p-6 mb-6">
        <h2 className="text-2xl font-semibold text-gray-800 mb-4">
          Layout Test (Flexbox & Grid)
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="bg-indigo-100 p-4 rounded text-center">Item 1</div>
          <div className="bg-indigo-200 p-4 rounded text-center">Item 2</div>
          <div className="bg-indigo-300 p-4 rounded text-center">Item 3</div>
        </div>
      </div>

      {/* Success Message */}
      <div className="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded">
        <p className="font-bold">✅ Tailwind CSS is working!</p>
        <p className="text-sm">If you can see styled elements above, Tailwind is properly configured.</p>
      </div>
    </div>
  </div></>
  );
}

export default App;
