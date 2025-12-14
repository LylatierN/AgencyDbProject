import React, { Component } from 'react'

export default class LocationAvailables extends Component {
  constructor(props) {
    super(props)
    // Get current datetime in YYYY-MM-DDTHH:MM format
    const now = new Date();
    const today = now.toISOString().slice(0, 16);
    this.state = {
      start_dt: today,
      end_dt: ''
    }
  }

  handleStartDateChange = (e) => {
    this.setState({ start_dt: e.target.value }, () => {
      if (this.props.onParamsChange) {
        this.props.onParamsChange(this.state);
      }
    })
  }

  handleEndDateChange = (e) => {
    this.setState({ end_dt: e.target.value }, () => {
      if (this.props.onParamsChange) {
        this.props.onParamsChange(this.state);
      }
    })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Find available places between</span>
        <input
          type="datetime-local"
          value={this.state.start_dt}
          onChange={this.handleStartDateChange}
          className="px-3 py-1 border-2 border-blue-400 rounded text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />

        <span className="text-lg text-gray-800">and</span>

        <input
          type="datetime-local"
          value={this.state.end_dt}
          onChange={this.handleEndDateChange}
          className="px-3 py-1 border-2 border-blue-400 rounded text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />
      </div>
    )
  }
}
