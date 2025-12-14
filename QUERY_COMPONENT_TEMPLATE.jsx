// TEMPLATE FOR REMAINING QUERY COMPONENTS
// Copy this for TopActors.jsx, LeastJob.jsx, etc.

import React, { Component } from 'react'

export default class QueryComponentName extends Component {
  constructor(props) {
    super(props)
    this.state = {
      // TODO: Add your input fields here
      // Example:
      // limit: 5,
      // startDate: '',
      // endDate: ''
    }
  }

  // TODO: Add handlers for each input field
  // Example:
  // handleLimitChange = (e) => {
  //   this.setState({ limit: parseInt(e.target.value) || 5 })
  // }

  handleSubmit = () => {
    // TODO: Validate inputs
    // if (!this.state.someField) {
    //   alert('Please fill in all fields');
    //   return;
    // }

    // Call parent's onQuerySubmit with:
    // 1. The query type (must match case in App.jsx)
    // 2. The parameters object
    this.props.onQuerySubmit('query_type_here', {
      // TODO: Pass your parameters here
      // param1: this.state.value1,
      // param2: this.state.value2
    });
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-4 w-full">
        {/* TODO: Add your input fields here */}
        
        <button
          onClick={(e) => {
            e.stopPropagation();
            this.handleSubmit();
          }}
          className="px-6 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition font-semibold"
        >
          Search
        </button>
      </div>
    )
  }
}
