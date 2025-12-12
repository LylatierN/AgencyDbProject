import React, { Component } from 'react'

export default class EmployeesByDepartment extends Component {
  constructor(props) {
    super(props)
    this.state = {
      department: ''
    }
  }

  handleChange = (e) => {
    this.setState({ department: e.target.value })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Find all employees in</span>
        <select
          value={this.state.department}
          onChange={this.handleChange}
          className="px-3 py-1 border-2 border-blue-400 rounded bg-white text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        >
          <option value="">--</option>
          <option value="Sales">Sales</option>
          <option value="Engineering">Engineering</option>
          <option value="HR">HR</option>
          <option value="Marketing">Marketing</option>
        </select>
      </div>
    )
  }
}
