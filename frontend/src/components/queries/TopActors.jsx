import React, { Component } from 'react'

export default class TopActors extends Component {
  constructor(props) {
    super(props)
    this.state = {
      n: '3'
    }
  }

  componentDidMount() {
    // Submit immediately with default value
    if (this.props.onParamsChange) {
      this.props.onParamsChange({ n: this.state.n });
    }
  }

  handleChange = (e) => {
    const value = e.target.value;
    this.setState({ n: value }, () => {
      console.log('Number:', this.state.n)
      if (value) {
        this.props.onParamsChange({ n: value });
      }
    })
  }

  render() {
    return (
      <div className="flex items-center flex-wrap gap-2">
        <span className="text-lg text-gray-800">Top</span>
        <input
          type="number"
          value={this.state.n}
          onChange={this.handleChange}
          placeholder="10"
          min="1"
          className="px-3 py-1 border-2 border-blue-400 rounded w-20 text-gray-800 focus:outline-none focus:ring-2 focus:ring-blue-500"
          onClick={(e) => e.stopPropagation()}
        />
        <span className="text-lg text-gray-800">actors with most productions projects</span>
      </div>
    )
  }
}
