import React, { Component } from 'react'

export default class EmployeesByPosition extends Component {
  constructor(props) {
    super(props)
    this.state = {
      position: '',
      positions: [
        'Director','Costumer','Makeup','Actor', 'Singer','Dancer','Photographer','Editor','Writer','Producer','Cinematographer'
      ]
    }
  }

  handleChange = (e) => {
    this.setState({ position: e.target.value })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Find all employees that are</span>
        <select
          value={this.state.position}
          onChange={this.handleChange}
          className="px-3 py-1 border-2 border-blue-400 rounded bg-white text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        >
          <option value="">--</option>
          {this.state.positions.map((pos, index) => (
            <option key={index} value={pos}>
              {pos}
            </option>
          ))}
        </select>
      </div>
    )
  }
}
