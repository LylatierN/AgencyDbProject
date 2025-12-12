import React, { Component } from 'react'

export default class PerformerPartner extends Component {
  constructor(props) {
    super(props)
    this.state = {
      name: ''
    }
  }

  handleNameChange = (e) => {
    this.setState({ name: e.target.value }, () => {
      console.log('Performer Name:', this.state.name)
    })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Find all partners of the performers</span>
        <input
          type="text"
          value={this.state.name}
          onChange={this.handleNameChange}
          placeholder="Enter name"
          className="px-3 py-1 border-2 border-blue-400 rounded text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />
      </div>
    )
  }
}
