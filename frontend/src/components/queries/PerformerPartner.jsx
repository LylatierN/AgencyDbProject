import React, { Component } from 'react'

export default class PerformerPartner extends Component {
  constructor(props) {
    super(props)
    this.state = {
      performer_name: ''
    }
    this.typingTimer = null;
  }

  handleNameChange = (e) => {
    const value = e.target.value;
    this.setState({ performer_name: value }, () => {
      console.log('Performer Name:', this.state.performer_name)
      
      // Clear existing timer
      if (this.typingTimer) {
        clearTimeout(this.typingTimer);
      }
      
      // Set new timer to submit after user stops typing for 500ms
      if (value) {
        this.typingTimer = setTimeout(() => {
          this.props.onParamsChange({ performer_name: value });
        }, 500);
      }
    })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Find all partners of the performers</span>
        <input
          type="text"
          value={this.state.performer_name}
          onChange={this.handleNameChange}
          placeholder="Enter name"
          className="px-3 py-1 border-2 border-blue-400 rounded text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />
      </div>
    )
  }
}
