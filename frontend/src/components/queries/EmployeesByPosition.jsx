import React, { Component } from 'react'

export default class EmployeesByPosition extends Component {
  constructor(props) {
    super(props)
    this.state = {
      position: '',
      limit: 10,
      positions: [
        'Director','Costumer','Makeup','Actor', 'Singer','Dancer','Photographer','Editor','Writer','Producer','Cinematographer','Crew'
      ]
    }
  }

  handlePositionChange = (e) => {
    this.setState({ position: e.target.value })
  }

  handleLimitChange = (e) => {
    this.setState({ limit: parseInt(e.target.value) || 10 })
  }

  handleSubmit = () => {
    const { position, limit } = this.state;
    if (!position) {
      alert('Please select a position');
      return;
    }
    
    // Call parent's onQuerySubmit with query type and parameters
    this.props.onQuerySubmit('employees_by_position', {
      position: [position],
      limit: limit
    });
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-4 w-full">
        <div className="flex items-center gap-2">
          <span className="text-lg text-gray-800">Find all employees that are</span>
          <select
            value={this.state.position}
            onChange={this.handlePositionChange}
            className="px-3 py-2 border-2 border-blue-400 rounded bg-white text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
            onClick={(e) => e.stopPropagation()}
          >
            <option value="">-- Select --</option>
            {this.state.positions.map((pos, index) => (
              <option key={index} value={pos}>
                {pos}
              </option>
            ))}
          </select>
        </div>
        
        <div className="flex items-center gap-2">
          <span className="text-lg text-gray-800">Limit:</span>
          <input
            type="number"
            min="1"
            max="100"
            value={this.state.limit}
            onChange={this.handleLimitChange}
            className="px-3 py-2 border-2 border-blue-400 rounded w-20 focus:outline-none focus:ring-2 focus:ring-blue-500"
            onClick={(e) => e.stopPropagation()}
          />
        </div>

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
