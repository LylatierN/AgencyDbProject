import React, { Component } from 'react'

export default class DepartmentsByLocation extends Component {
  constructor(props) {
    super(props)
    this.state = {
      location: ''
    }
  }

  handleChange = (e) => {
    this.setState({ location: e.target.value })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Find all departments in</span>
        <select
          value={this.state.location}
          onChange={this.handleChange}
          className="px-3 py-1 border-2 border-blue-400 rounded bg-white text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        >
          <option value="">--</option>
          <option value="New York">New York</option>
          <option value="San Francisco">San Francisco</option>
          <option value="London">London</option>
          <option value="Tokyo">Tokyo</option>
        </select>
      </div>
    )
  }
}
