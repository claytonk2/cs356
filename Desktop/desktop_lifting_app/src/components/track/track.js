import React from 'react';
import { render } from "react-dom";
import { Link } from 'react-router-dom';
import { AgGridReact } from 'ag-grid-react';
import { Button, ButtonGroup, ButtonToolbar } from 'reactstrap';
import './ag-grid.css';
import "ag-grid-enterprise";
import 'ag-grid-community/dist/styles/ag-theme-blue.css';
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";



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
                {headerName: "Exercise", field: "exercise", editable: true, resizable: true},
                {headerName: "Sets", field: "sets", editable: true, resizable: true},
                {headerName: "Reps", field: "reps", editable: true, resizable: true},
                {headerName: "Weight", field: "weight", editable: true, resizable: true},
                { headerName: "Effort", field: "effort", cellEditor: "agRichSelectCellEditor",
                cellEditorParams: {
                  values: ["low", "medium", "high", "max"]
                },
                editable: true,
                resizable: true
                }


            ],
            rowData: [
              {exercise: "Bench", sets: 5, reps: 5, weight: 275, effort: "medium"},
              {exercise: "DB Bench", sets: 3, reps: 10, weight: 100, effort: "medium"},
              {exercise: "Fly ", sets: 3, reps: 12, weight: 45, effort: "medium"},
              {exercise: "Row", sets: 3, reps: 10, weight: 225, effort: "medium"}
            ],
            rowSelection: "multiple",
            startDate: new Date()

        }
        this.handleChange = this.handleChange.bind(this);
    }

    onGridReady = params => {
      this.gridApi = params.api;
      this.gridColumnApi = params.columnApi;
      params.api.sizeColumnsToFit();
    };
    addItems() {
      var newItems = [{exercise: "", sets: 0, reps: 0, weight: 0, effort: "medium"}];
      var res = this.gridApi.updateRowData({ add: newItems });
      printResult(res);
    }
    onRemoveSelected() {
      var selectedData = this.gridApi.getSelectedRows();
      var res = this.gridApi.updateRowData({ remove: selectedData });
      printResult(res);
    }
    handleChange(date) {
        this.setState({
          startDate: date
        });
      }

    // componentDidMount() { //https://medium.com/ag-grid/get-started-with-react-grid-in-5-minutes-f6e5fb16afa
    //     fetch('https://api.myjson.com/bins/15psn9')
    //         .then(result => result.json())
    //         .then(rowData => this.setState({rowData}))
    // }



	render() {
		return (
      <div style={{
        alignItems: 'center',
        padding: "2.0%"
    }}>
			<div className="text-center">

				<h2>Enter data to be tracked</h2>
			</div>
      <div className="text-center"
      style={{
        padding: "1.0%"
    }}>

        <h3>Record Lifting Data for :</h3>
        <DatePicker
        selected={this.state.startDate}
        onChange={this.handleChange}
        placeholderText="Record Lifting Data for :"
      />
      </div>
      <div
                      className="ag-theme-blue"

                  >
                      <AgGridReact
                          enableSorting={true}
                          columnDefs={this.state.columnDefs}
                          rowData={this.state.rowData}
                          animateRows={true}
                          rowSelection={this.state.rowSelection}
                          onGridReady={this.onGridReady}>
                      </AgGridReact>
                  </div>
                  <ButtonToolbar style={{  padding: "0.5%" }}>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <Button outline color="primary" onClick={this.addItems.bind(this)}>+ Add More</Button>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <Button outline color="danger" onClick={this.onRemoveSelected.bind(this)}>Delete Selected Row</Button>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <Button outline color="primary" href="/graph">Submit</Button>
                  </ButtonToolbar>;
                  </div>
    );
  }
}

function printResult(res) {
  console.log("---------------------------------------");
  if (res.add) {
    res.add.forEach(function(rowNode) {
      console.log("Added Row Node", rowNode);
    });
  }
  if (res.remove) {
    res.remove.forEach(function(rowNode) {
      console.log("Removed Row Node", rowNode);
    });
  }
  if (res.update) {
    res.update.forEach(function(rowNode) {
      console.log("Updated Row Node", rowNode);
    });
  }
}


export default track
