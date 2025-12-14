import React, { Component } from 'react'

export default class LocationUse extends Component {
  constructor(props) {
    super(props)
    // Get current date in YYYY-MM-DD format
    const today = new Date().toISOString().split('T')[0]
    this.state = {
      target_date: today
    }
  }

  componentDidMount() {
    // Submit immediately with default date
    if (this.props.onParamsChange) {
      this.props.onParamsChange({ target_date: this.state.target_date });
    }
  }

  handleDayChange = (e) => {
    const value = e.target.value;
    this.setState({ target_date: value }, () => {
      console.log('Day:', this.state.target_date)
      if (value) {
        this.props.onParamsChange({ target_date: value });
      }
    })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800"> All rental places that currently in use on the day</span>
        <input
          type="date"
          value={this.state.target_date}
          onChange={this.handleDayChange}
          className="px-3 py-1 border-2 border-blue-400 rounded text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />
      </div>
    )
  }
}
