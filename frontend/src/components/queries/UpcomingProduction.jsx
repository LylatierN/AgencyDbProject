import React, { Component } from 'react'

export default class UpcomingProduction extends Component {
  constructor(props) {
    super(props)
    // Get current datetime in YYYY-MM-DDTHH:MM format
    const now = new Date();
    const today = now.toISOString().slice(0, 16);
    this.state = {
      current_datetime: today
    }
  }

  handleDateChange = (e) => {
    const value = e.target.value;
    this.setState({ current_datetime: value }, () => {
      console.log('Date:', this.state.current_datetime)
      if (value) {
        this.props.onParamsChange({ current_datetime: value });
      }
    })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Upcoming production schedule</span>
        <input
          type="datetime-local"
          value={this.state.current_datetime}
          onChange={this.handleDateChange}
          className="px-3 py-1 border-2 border-blue-400 rounded text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />
      </div>
    )
  }
}
