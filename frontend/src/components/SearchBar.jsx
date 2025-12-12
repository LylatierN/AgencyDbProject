import React, { Component } from 'react'

export default class SearchBar extends Component {
    constructor(props) {
        super(props)
        this.state = {
            searchTerm: ''
        }
    }

    handleInputChange = (e) => {
        this.setState({ searchTerm: e.target.value });
    }

    handleSearch = (e) => {
        e.preventDefault();
        const { searchTerm } = this.state;
        console.log('Searching for:', searchTerm);
        // Call the parent's search handler with the search term (empty or not)
        this.props.onSearch(searchTerm);
    }

    handleClear = () => {
        this.setState({ searchTerm: '' });
        // Call search with empty string to show all data
        this.props.onSearch('');
    }

    render() {
        const { searchTerm } = this.state;

        return (
            <div className=" rounded-lgw-1/2 mx-0 basis1/2">
                <form onSubmit={this.handleSearch} className="flex gap-4 items-center">
                    <div className="flex-1">
                        <input
                            type="text"
                            value={searchTerm}
                            onChange={this.handleInputChange}
                            placeholder="Search database..."
                            className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                        />
                    </div>
                    <button
                        type="submit"
                        className="px-6 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors"
                    >
                        Search
                    </button>
                    {searchTerm && (
                        <button
                            type="button"
                            onClick={this.handleClear}
                            className="px-6 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 transition-colors"
                        >
                            Clear
                        </button>
                    )}
                </form>
            </div>
        )
    }
}
