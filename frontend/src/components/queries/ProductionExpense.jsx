import React, { Component } from 'react'

export default class ProductionExpense extends Component {
  componentDidMount() {
    // Trigger submission immediately since no params needed
    this.props.onParamsChange({});
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">total expense amount for every production</span>
      </div>
    )
  }
}
