import React, { Component } from 'react'

export default class UpcomingProduction extends Component {
  constructor(props) {
    super(props)
    // Get current date in YYYY-MM-DD format
    const today = new Date().toISOString().split('T')[0]
    this.state = {
      date: today
    }
  }

  handleDateChange = (e) => {
    this.setState({ date: e.target.value }, () => {
      console.log('Date:', this.state.date)
    })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Upcoming production schedule</span>
        <input
          type="date"
          value={this.state.date}
          onChange={this.handleDateChange}
          className="px-3 py-1 border-2 border-blue-400 rounded text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />
      </div>
    )
  }
}
