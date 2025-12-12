import React, { Component } from 'react'

export default class EmployeesByRole extends Component {
  constructor(props) {
    super(props)
    this.state = {
      role: ''
    }
  }

  handleChange = (e) => {
    this.setState({ role: e.target.value })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Find all employees with role</span>
        <select
          value={this.state.role}
          onChange={this.handleChange}
          className="px-3 py-1 border-2 border-blue-400 rounded bg-white text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        >
          <option value="">--</option>
          <option value="Manager">Manager</option>
          <option value="Developer">Developer</option>
          <option value="Designer">Designer</option>
          <option value="Analyst">Analyst</option>
        </select>
      </div>
    )
  }
}
