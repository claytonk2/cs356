import React from 'react';
import { Link } from 'react-router-dom';
import { AgGridReact } from 'ag-grid-react';
import 'ag-grid.css';
import 'ag-grid-community/dist/styles/ag-theme-balham.css';

const ColoredLine = ({ color }) => (
    <hr
        style={{
            color: color,
            backgroundColor: color,
            height: 1
        }}
    />
);

class track extends React.Component {
  constructor(props) {
        super(props);

        this.state = {
            columnDefs: [
                {headerName: "Exercise", field: "exercise"},
                {headerName: "Sets", field: "sets"},
                {headerName: "Reps", field: "reps"},
                {headerName: "Weight", field: "weight"},
                {headerName: "Effort", field: "effort"}

            ],
            rowData: [
                {exercise: "Bench", sets: 5, reps: 5, weight: 275, effort: "medium"},
                {exercise: "DB Bench", sets: 3, reps: 10, weight: 100, effort: "medium"},
                {exercise: "Fly ", sets: 3, reps: 12, weight: 45, effort: "medium"},
                {exercise: "Row", sets: 3, reps: 10, weight: 225, effort: "medium"}
            ]
        }
    }
	render() {
		return (
			<div className="text-left">
				<p> accountName	 accoutUserName </p>

				<ColoredLine color="blue" />
				<h2>Enter data to be tracked</h2>
			</div>,

      <div
                      className="ag-theme-balham"
                      style={{ height: '200px', width: '600px' }}
                  >
                      <AgGridReact
                          columnDefs={this.state.columnDefs}
                          rowData={this.state.rowData}>
                      </AgGridReact>
                  </div>
    );
  }
}

export default track
