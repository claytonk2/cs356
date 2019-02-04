import React from 'react';
import { Link } from 'react-router-dom';
import { AgGridReact } from 'ag-grid-react';
import './ag-grid.css';
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

var React1 = require('react');

var buttonStyle = {
  margin: '10px 10px 10px 0'
};

var Button = React1.createClass({
  render: function () {
    return (
      <button
        className="btn btn-default"
        style={buttonStyle}
        onClick={this.props.handleClick}>{this.props.label}</button>
    );
  }
});

class track extends React.Component {
  constructor(props) {
        super(props);

        this.state = {
            columnDefs: [
                {headerName: "Exercise", field: "exercise", editable: true},
                {headerName: "Sets", field: "sets", editable: true},
                {headerName: "Reps", field: "reps", editable: true},
                {headerName: "Weight", field: "weight", editable: true},
                {headerName: "Effort", field: "effort", editable: true}

            ],
            rowData: [
              {exercise: "Bench", sets: 5, reps: 5, weight: 275, effort: "medium"},
              {exercise: "DB Bench", sets: 3, reps: 10, weight: 100, effort: "medium"},
              {exercise: "Fly ", sets: 3, reps: 12, weight: 45, effort: "medium"},
              {exercise: "Row", sets: 3, reps: 10, weight: 225, effort: "medium"}
            ]
        }
        var buttomAdd = document.createElement("Button");
    }
    // componentDidMount() { //https://medium.com/ag-grid/get-started-with-react-grid-in-5-minutes-f6e5fb16afa
    //     fetch('https://api.myjson.com/bins/15psn9')
    //         .then(result => result.json())
    //         .then(rowData => this.setState({rowData}))
    // }



	render() {
		return (
      <div>
			<div className="text-left">
				<p> accountName	 accoutUserName </p>

				<ColoredLine color="blue" />
				<h2>Enter data to be tracked</h2>
			</div>

      <div
                      className="ag-theme-balham"
                      style={{ height: '80%', width: '80%', padding: "50px" }}
                  >
                      <AgGridReact
                          enableSorting={true}
                          columnDefs={this.state.columnDefs}
                          rowData={this.state.rowData}>
                      </AgGridReact>
                  </div>
                  <button
                          className="btn btn-default"
                          style={buttonStyle}
                          onClick={this.props.handleClick}>{this.props.label}</button>
                  </div>
    );
  }
}
track.exports = Button;
export default track
