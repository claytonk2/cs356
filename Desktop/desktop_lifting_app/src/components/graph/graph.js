import React from 'react';
import "react-datepicker/dist/react-datepicker.css";
import {XYPlot, XAxis, YAxis, VerticalGridLines, HorizontalGridLines, LineSeries, Hint, MarkSeries} from 'react-vis';
import {AgGridReact} from "ag-grid-react";
import "ag-grid-enterprise";
import 'ag-grid-community/dist/styles/ag-theme-blue.css';
import {Button, ButtonToolbar} from "reactstrap";
import firebase from "../firebase";
import "react-vis/dist/style.css";
import moment from 'moment';

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
//
// {this.state.value ? <Hint values={this.state.value} /> : null}
// <LineSeries
//     className="linemark-series-example"
//     data={this.state.data}
//     style={{strokeWidth: '3px'}}
//     lineStyle={{stroke: 'red'}}
//     markStyle={{stroke: 'blue'}}
//     onNearestXY={(datapoint, index) => this.setState({index: index})}/>
    // figure out how to have line show up


	constructor(props){
		super(props);
		this.state={
			startDate: new Date(),
            data: [
                {x: new Date("2019-02-19T07:00:00.000Z"), y: 255},
                {x: new Date("2019-02-20T07:00:00.000Z"), y: 264},
                {x: new Date("2019-02-21T07:00:00.000Z"), y: 265}
            ],
            columnDefs: [
                {headerName: "Exercise", field: "exercise", cellEditor: "agRichSelectCellEditor",
                    cellEditorParams: {
                        values: this.getWorkoutTypes()
                    },editable: true, resizable: true},
                {headerName: "Reps", field: "reps",cellEditor: "agRichSelectCellEditor",
                    cellEditorParams: {
                        values: this.getWorkoutReps()
                    }, editable: true, resizable: true},
                { headerName: "Effort", field: "effort", cellEditor: "agRichSelectCellEditor",
                    cellEditorParams: {
                        values: ["low", "medium", "high", "max", "all"]
                    },
                    editable: true,
                    resizable: true
                }


            ],
            rowData: [
                {exercise: "exercise", reps: "reps", effort: "all"}
            ],
            value: null
		}
	}
    addRowData(childSnapshot, self){
	    console.log(childSnapshot);
	    console.log(self.state.rowData);
	    if (self.state.rowData[0].effort == "all" &&
            self.state.rowData[0].exercise == childSnapshot.val().name &&
            self.state.rowData[0].reps == childSnapshot.val().reps ){
            self.state.data.push({x:new Date(childSnapshot.val().dateId), y: childSnapshot.val().weight})
        }
	    else if (self.state.rowData[0].exercise == childSnapshot.val().name &&
            self.state.rowData[0].reps == childSnapshot.val().reps &&
            self.state.rowData[0].effort == childSnapshot.val().effort){
	        self.state.data.push({x:new Date(childSnapshot.val().dateId), y: childSnapshot.val().weight})
        }

	    console.log(self.state.data);
        self.setState({
            data: self.state.data,
        })
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
	addTypes(child, types, self){
	    if (types.indexOf(child.val().name) <= -1){
	        // console.log(child.val().name);
            types.push(child.val().name)
        }
        // console.log(types);
    }
	getWorkoutTypes(){
        var self = this;
        var types = [];



        var ref1 = firebase.database().ref('users/sBAGIexZ8o7DoBAgCeHf/workoutDate/'); //+ '/workouts/'
        ref1.orderByChild("workouts").on('value', function (snapshot) {

            snapshot.forEach(function(childSnapshot) {

                childSnapshot.forEach(function(childSnapshot1){

                    childSnapshot1.forEach(function (data) {

                        self.addTypes(data, types, self);
                    });
                });
            });
        }, function (errorObject) {
            console.log("The read failed: " + errorObject.code);
        });
        console.log(types);
        return types;
    }

    addReps(child, types, self){
        if (types.indexOf(child.val().reps) <= -1){
            // console.log(child.val().reps);
            types.push(child.val().reps)
        }
        // console.log(types);
    }
    getWorkoutReps(){
        var self = this;
        var types = [];



        var ref1 = firebase.database().ref('users/sBAGIexZ8o7DoBAgCeHf/workoutDate/'); //+ '/workouts/'
        ref1.orderByChild("workouts").on('value', function (snapshot) {

            snapshot.forEach(function(childSnapshot) {

                childSnapshot.forEach(function(childSnapshot1){

                    childSnapshot1.forEach(function (data) {

                        self.addReps(data, types, self);
                    });
                });
            });
        }, function (errorObject) {
            console.log("The read failed: " + errorObject.code);
        });
        console.log(types);
        return types;
    }
//     map((d)=> {
//     return {x: d.year + '/' + d.quarter,
//     y: parseFloat(d.count/1000)}
// });
    onGraph(){
        var self = this;
        self.state.dateKey = "";

        console.log("Import Data\n");
        this.state.data = [];
        this.setState({
           data: []
        });
        console.log(self.state.data);
        var ref1 = firebase.database().ref('users/sBAGIexZ8o7DoBAgCeHf/workoutDate/'); //+ '/workouts/'
        ref1.orderByChild("workouts").on('value', function (snapshot) {
            // console.log(snapshot.val());
            snapshot.forEach(function(childSnapshot) {
                // console.log(childSnapshot.val());
                childSnapshot.forEach(function(childSnapshot1){
                    // console.log(childSnapshot1.val());
                    childSnapshot1.forEach(function (data) {
                        // console.log(data.val())
                        self.addRowData(data, self);
                    });
                });
            });
            var data = self.state.data.sort((a, b) => Date.parse(a.x) - Date.parse(b.x));
            self.setState({
                data: data,
            })
            }, function (errorObject) {
            console.log("The read failed: " + errorObject.code);
        });
    }
    _rememberValue = value => {
        this.setState({value});
    };

	render() {
        const {value} = this.state; //fix this shit
        var titleFormat="D MMM YYYY";
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
                         padding: "0.0%"
                     }}>

                    <p>Select exercise, reps and effort that you graphed from what has been entered.</p>



                </div>
                <div
                    className="ag-theme-blue"
                    style={{
                        alignItems: 'center',
                        padding: "0.0%"
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
                    <ButtonToolbar style={{  padding: "0.5%", alignItems: 'center' }}>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <Button outline color="primary" onClick={this.onGraph.bind(this)} >Graph</Button>
                    </ButtonToolbar>
                </div>
                <div style={{
                    alignItems: 'center',
                    padding: "02.0%"
                }}>
                <XYPlot
                    xType="time"
                    width={1350}
                    height={500}
                    yDomain={[0, 500]}
                    onMouseLeave={() => this.setState({value: false})}
                >
                    <VerticalGridLines />
                    <HorizontalGridLines />
                    <XAxis title="Workout Day" />
                    <YAxis title="Weight in lbs." />
                    <MarkSeries onNearestX={this._rememberValue} data={this.state.data} />
                    
                        <LineSeries
                            data= {this.state.data}
                            className="linemark-series-example"
                            stroke="blue"
                        />
                    {value ? (
                        <Hint
                            value={value}
                            align={{horizontal: Hint.ALIGN.AUTO, vertical: Hint.ALIGN.TOP_EDGE}}
                        >
                            <div className="rv-hint__content">{`(${moment(value.x).format("D MMM YYYY")}, ${value.y})`}</div>
                        </Hint>
                    ) : null}
                </XYPlot>

                </div>
			</div>
    );
  }
}

export default graph
