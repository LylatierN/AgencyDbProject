import React, { Component } from 'react'
import EmployeesByPosition from './queries/EmployeesByPosition'
import ActivitiesOnDates from './queries/ActivitiesOnDates'
import FreeEmployeesByRole from './queries/FreeEmployeesByRole'
import LocationAvailable from './queries/LocationOnDates'
import TopActors from './queries/TopActors'
import LeastJob from './queries/LeastJob'
import ProductionExpense from './queries/ProductionExpense'
import MusicRelease from './queries/MusicRelease'
import LocationUse from './queries/LocationUse'
import PerformerPartner from './queries/PerformerPartner'
import UpcomingProduction from './queries/UpcomingProduction'
import AllPerformer from './queries/AllPerformer'

// console.log('🚀 Query.jsx FILE LOADED - Version with logging');

export default class Query extends Component {
  constructor(props) {
    super(props)
    console.log('🏗️ Query component CONSTRUCTOR called');
    this.state = {
      selectedQuery: '',
      isSelecting: true,
      queryParams: {},
      queries: {
        // TODO: add queries apis' name and component here
        'employees_by_position': {
          label: 'Find all employees in a position',
          component: EmployeesByPosition,
          apis: '/personnel/by-type'
        },
        'activities_on_dates': {
          label: 'Find amount of activities each types of activities between certain dates',
          component: ActivitiesOnDates,
          apis: '/schedule/activity/counts'
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
        'production_expense': {
          label: 'total expense amount for every production',
          component: ProductionExpense
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
    const selectedValue = e.target.value;
    console.log('🎯 QUERY SELECTED:', selectedValue);
    console.log('Query Label:', this.state.queries[selectedValue]?.label);
    
    this.setState({
      selectedQuery: selectedValue,
      isSelecting: false,
      queryParams: {}
    })
  }

  handleChangeClick = () => {
    this.setState({
      selectedQuery: '',
      isSelecting: true,
      queryParams: {}
    })
  }

  updateQueryParams = (params) => {
    console.log('🔵 updateQueryParams CALLED with:', params);
    
    this.setState({ queryParams: params }, () => {
      // Automatically submit when params change
      const { selectedQuery, queryParams } = this.state;
      
      console.log('=== UPDATE QUERY PARAMS ===');
      console.log('Selected Query:', selectedQuery);
      console.log('Query Params:', queryParams);
      
      // Check if all required fields are filled
      const hasEmptyFields = Object.values(queryParams).some(value => 
        value === '' || value === null || value === undefined
      );

      console.log('Has Empty Fields:', hasEmptyFields);
      console.log('Params Length:', Object.keys(queryParams).length);

      // Only submit if no empty fields and we have params
      if (!hasEmptyFields && Object.keys(queryParams).length > 0) {
        console.log('✅ SUBMITTING QUERY TO BACKEND');
        console.log(`Submitting query: ${selectedQuery} with params: ${JSON.stringify(queryParams)}`);
        this.props.onQuerySubmit(selectedQuery, queryParams);
      } else {
        console.log('❌ NOT SUBMITTING - Empty fields or no params');
        console.log('Not submitting - some fields are empty');
      }
    });
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
              {QueryComponent && <QueryComponent onParamsChange={this.updateQueryParams} />}
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
