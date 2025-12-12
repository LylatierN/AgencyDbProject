import React, { Component } from 'react'

export default class ProjectsByBudget extends Component {
  constructor(props) {
    super(props)
    this.state = {
      minBudget: '',
      maxBudget: ''
    }
  }

  handleMinChange = (e) => {
    this.setState({ minBudget: e.target.value })
  }

  handleMaxChange = (e) => {
    this.setState({ maxBudget: e.target.value })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Find projects with budget between</span>
        <input
          type="text"
          value={this.state.minBudget}
          onChange={this.handleMinChange}
          placeholder="Min"
          className="px-3 py-1 border-2 border-blue-400 rounded w-24 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />
        <span className="text-lg text-gray-800">and</span>
        <input
          type="text"
          value={this.state.maxBudget}
          onChange={this.handleMaxChange}
          placeholder="Max"
          className="px-3 py-1 border-2 border-blue-400 rounded w-24 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />
      </div>
    )
  }
}
