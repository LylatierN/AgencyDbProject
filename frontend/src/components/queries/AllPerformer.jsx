import React, { Component } from 'react'

export default class EmployeesAssign extends Component {
  componentDidMount() {
    // Trigger submission immediately since no params needed
    this.props.onParamsChange({});
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">All Performers Data</span>
      </div>
    )
  }
}
