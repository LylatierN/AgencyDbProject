import React, { Component } from 'react'

export default class ActivitiesOnDates extends Component {
  constructor(props) {
    super(props)
    this.state = {
      startDate: '',
      endDate: ''
    }
  }

  handleStartDateChange = (e) => {
    this.setState({ startDate: e.target.value }, () => {
      console.log('Start Date:', this.state.startDate)
      console.log('All values:', this.state)
    })
  }

  handleEndDateChange = (e) => {
    this.setState({ endDate: e.target.value }, () => {
      console.log('End Date:', this.state.endDate)
      console.log('All values:', this.state)
    })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Find types of activities between</span>
        <input
          type="date"
          value={this.state.startDate}
          onChange={this.handleStartDateChange}
          className="px-3 py-1 border-2 border-blue-400 rounded text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />

        <span className="text-lg text-gray-800">and</span>

        <input
          type="date"
          value={this.state.endDate}
          onChange={this.handleEndDateChange}
          className="px-3 py-1 border-2 border-blue-400 rounded text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />
      </div>
    )
  }
}
