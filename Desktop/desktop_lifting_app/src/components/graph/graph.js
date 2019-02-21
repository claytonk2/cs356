import React from 'react';
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import {XYPlot, XAxis, YAxis, VerticalGridLines, HorizontalGridLines, LineSeries} from 'react-vis';
import {AgGridReact} from "ag-grid-react";
import "ag-grid-enterprise";
import 'ag-grid-community/dist/styles/ag-theme-blue.css';
// import "react-vis/dist/style";

const ColoredLine = ({ color }) => (
    <hr
        style={{
            color: color,
            backgroundColor: color,
            height: 1
        }}
    />
);
class graph extends React.Component {
	constructor(props){
		super(props);
		this.state={
			startDate: new Date(),
            data: [
                {x: '2/20/2019', y: 255},
                {x: '2/21/2019', y: 264},
                {x: '2/22/2019', y: 265}
            ],
            columnDefs: [
                {headerName: "Exercise", field: "exercise", editable: true, resizable: true},
                {headerName: "Sets", field: "sets", editable: true, resizable: true},
                {headerName: "Reps", field: "reps", editable: true, resizable: true},
                { headerName: "Effort", field: "effort", cellEditor: "agRichSelectCellEditor",
                    cellEditorParams: {
                        values: ["low", "medium", "high", "max"]
                    },
                    editable: true,
                    resizable: true
                }


            ],
            rowData: [
                {exercise: "exercise", sets: 0, reps: 0, weight: 0, effort: "medium"}
            ]
		}
	}
    handleChange(date) {
        this.setState({
            startDate: date
        });
    }
    onGridReady = params => {
        this.gridApi = params.api;
        this.gridColumnApi = params.columnApi;
        params.api.sizeColumnsToFit();
    };
//     map((d)=> {
//     return {x: d.year + '/' + d.quarter,
//     y: parseFloat(d.count/1000)}
// });
	render() {
		return (
            <div style={{
                alignItems: 'center',
                padding: "01.0%"
            }}>
                <div className="text-center">

                    <h2>Graph Data Here</h2>
                    <ColoredLine color = "black"></ColoredLine>
                </div>
                <div className="text-center"
                     style={{
                         padding: "1.0%"
                     }}>


                    <DatePicker
                        selected={this.state.startDate}
                        onChange={this.handleChange.bind(this)}
                        placeholderText="Record Lifting Data for :"
                    />

                </div>
                <div
                    className="ag-theme-blue"
                    style={{
                        alignItems: 'center',
                        padding: "01.0%"
                    }}
                >
                    <AgGridReact
                        enableSorting={false}
                        columnDefs={this.state.columnDefs}
                        rowData={this.state.rowData}
                        animateRows={true}
                        rowSelection={this.state.rowSelection}
                        onGridReady={this.onGridReady}
                        singleClickEdit={true}>
                    </AgGridReact>
                </div>
                <div style={{
                    alignItems: 'center',
                    padding: "01.0%"
                }}>
                <XYPlot
                    xType="time"
                    width={1000}
                    height={500}
                >
                    <VerticalGridLines />
                    <HorizontalGridLines />
                    <XAxis title="Workout Day" />
                    <YAxis title="Weight in lbs." />
                    <LineSeries
                        data={this.state.data}
                        style={{stroke: 'blue', strokeWidth: 3}}/>
                </XYPlot>
                </div>
			</div>
    );
  }
}

export default graph
