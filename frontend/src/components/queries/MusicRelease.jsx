import React, { Component } from 'react'

export default class MusicRelease extends Component {
  constructor(props) {
    super(props)
    // Get current date in YYYY-MM-DD format
    const today = new Date().toISOString().split('T')[0]
    this.state = {
      start_date: today
    }
  }

  handleStartDateChange = (e) => {
    this.setState({ start_date: e.target.value }, () => {
      console.log('Start Date:', this.state.start_date)
    })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">List music production with performers and plan released info since</span>
        <input
          type="date"
          value={this.state.start_date}
          onChange={this.handleStartDateChange}
          className="px-3 py-1 border-2 border-blue-400 rounded text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />
      </div>
    )
  }
}
