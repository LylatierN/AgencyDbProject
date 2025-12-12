import React, { Component } from 'react'
import EmployeesByDepartment from './queries/EmployeesByDepartment'
import ProjectsByBudget from './queries/ProjectsByBudget'
import EmployeesByRole from './queries/EmployeesByRole'
import DepartmentsByLocation from './queries/DepartmentsByLocation'

export default class Query extends Component {
  constructor(props) {
    super(props)
    this.state = {
      selectedQuery: '',
      isSelecting: true,
      
      queries: {
        'employees_by_department': {
          label: 'Find all employees in a department',
          component: EmployeesByDepartment
        },
        'projects_by_budget': {
          label: 'Find projects by budget range',
          component: ProjectsByBudget
        },
        'employees_by_role': {
          label: 'Find employees by role',
          component: EmployeesByRole
        },
        'departments_by_location': {
          label: 'Find departments by location',
          component: DepartmentsByLocation
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
              {QueryComponent && <QueryComponent />}
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
