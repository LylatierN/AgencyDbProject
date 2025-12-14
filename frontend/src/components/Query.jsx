import React, { Component } from 'react'
import EmployeesByPosition from './queries/EmployeesByPosition'
import ActivitiesOnDates from './queries/ActivitiesOnDates'
import FreeEmployeesByRole from './queries/FreeEmployeesByRole'
import LocationAvailable from './queries/LocationOnDates'
import TopActors from './queries/TopActors'
import LeastJob from './queries/LeastJob'
import EmployeesAssign from './queries/EmployeesAssign'
import MusicRelease from './queries/MusicRelease'
import LocationUse from './queries/LocationUse'
import PerformerPartner from './queries/PerformerPartner'
import UpcomingProduction from './queries/UpcomingProduction'
import AllPerformer from './queries/AllPerformer'

export default class Query extends Component {
  constructor(props) {
    super(props)
    this.state = {
      selectedQuery: '',
      isSelecting: true,
      queries: {
        // TODO: add queries apis' name and component here
        'employees_by_position': {
          label: 'Find all employees in a position',
          component: EmployeesByPosition
        },
        'activities_on_dates': {
          label: 'Find amount of activities each types of activities between certain dates',
          component: ActivitiesOnDates
        },
        'employees_available': {
          label: 'Find available employees by role in certain dates',
          component: FreeEmployeesByRole
        },
        'location_available': {
          label: 'Location available in certain dates',
          component: LocationAvailable
        },
        'top_actors': {
          label: 'Find top N actors with most productions projects',
          component: TopActors
        },
        'least_job': {
          label: 'Find N actors with least project',
          component: LeastJob
        },
        'employees_assign': {
          label: 'All employee and their Production',
          component: EmployeesAssign
        },
        'music_release': {
          label: 'List music production with performers and plan released info since date',
          component: MusicRelease
        },
        'location_use': {
          label: 'List all rental places that currently in use on the day',
          component: LocationUse
        },
        'performer_partner': {
          label: 'Find all partners of the performers',
          component: PerformerPartner
        },
        'upcoming_production': {
          label: 'Upcoming production schedule',
          component: UpcomingProduction
        },
        'all_performer': {
          label: 'All performers',
          component: AllPerformer
        }
      }
    }
  }

  handleSelectChange = (e) => {
    this.setState({
      selectedQuery: e.target.value,
      isSelecting: false
    })
  }

  handleChangeClick = () => {
    this.setState({
      selectedQuery: '',
      isSelecting: true
    })
  }

  render() {
    const { selectedQuery, isSelecting, queries } = this.state
    const QueryComponent = selectedQuery ? queries[selectedQuery].component : null

    return (
      <div className="w-full px-4 py-6">
        {isSelecting ? (
          // Dropdown Mode
          <div className="w-full">
            <select
              value={selectedQuery}
              onChange={this.handleSelectChange}
              className="w-full px-6 py-4 text-lg border-2 border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 bg-white cursor-pointer"
            >
              <option value="">-- Select a query --</option>
              {Object.entries(queries).map(([key, query]) => (
                <option key={key} value={key}>
                  {query.label}
                </option>
              ))}
            </select>
          </div>
        ) : (
          // Display Mode with embedded component
          <div
            onClick={this.handleChangeClick}
            className="w-full flex items-center justify-between bg-blue-50 border-2 border-blue-300 hover:border-blue-400 hover:bg-blue-100 rounded-lg px-6 py-4 transition duration-200 cursor-pointer"
          >
            <div className="flex-1">
              {QueryComponent && <QueryComponent onQuerySubmit={this.props.onQuerySubmit} />}
            </div>
            <svg 
              className="w-5 h-5 text-blue-500 flex-shrink-0 ml-4" 
              fill="none" 
              stroke="currentColor" 
              viewBox="0 0 24 24"
            >
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
            </svg>
          </div>
        )}
      </div>
    )
  }
}
