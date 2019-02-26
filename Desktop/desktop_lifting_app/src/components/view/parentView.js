import React from 'react';
import { AgGridReact } from 'ag-grid-react';
import "ag-grid-enterprise";
import 'ag-grid-community/dist/styles/ag-theme-blue.css';
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

import view from "./view.js"
import edit from "./edit.js"

import firebase from '../firebase.js'
import {Button, ButtonToolbar} from "reactstrap";


const ColoredLine = ({ color }) => (
    <hr
        style={{
            color: color,
            backgroundColor: color,
            height: 1
        }}
    />
);
function writeNewWorkout(updates, node, newDateKey, date){

    var postData = {
        name: node.data.exercise,
        sets: node.data.sets,
        reps: node.data.reps,
        weight: node.data.weight,
        effort: node.data.effort,
        dateId: date
    };
    var newPostKey = firebase.database().ref().child('workouts').push().key;// try without the post key??
    // var userId = firebase.auth().currentUser.uid; userId
    updates['/workouts/' + newPostKey] = postData;
    updates['/users/sBAGIexZ8o7DoBAgCeHf/workoutDate/' + newDateKey + '/workouts/' + newPostKey] = postData;
    return updates
}


class parentView extends React.Component {

    constructor(props) {
        super(props);

        this.state = {
            columnDefs: [
                {headerName: "Exercise", field: "exercise", resizable: true},
                {headerName: "Sets", field: "sets", resizable: true},
                {headerName: "Reps", field: "reps", resizable: true},
                {headerName: "Weight", field: "weight", resizable: true},
                { headerName: "Effort", field: "effort", cellEditor: "agRichSelectCellEditor",
                    cellEditorParams: {
                        values: ["low", "medium", "high", "max"]
                    },
                    resizable: true
                }


            ],
            rowData: [],
            rowSelection: "multiple",
            screen: true,
            dateEnabled: false,
            key: "this"

        };
        this.handleChange = this.handleChange.bind(this);
    }

    onGridReady = params => {
        this.gridApi = params.api;
        this.gridColumnApi = params.columnApi;
        params.api.sizeColumnsToFit();
    };
    addItems() {
        var newItems = [{exercise: "", sets: 0, reps: 0, weight: 0, effort: "medium"}];
        this.gridApi.updateRowData({ add: newItems });

    }
    onRemoveSelected() {
        var selectedData = this.gridApi.getSelectedRows();
        this.gridApi.updateRowData({ remove: selectedData });

    }
    handleChange(date) {
        this.importData(date.toISOString());


    }
    onEditButton(){
        this.setState({
            screen : false,
            dateEnabled: true});
        this.gridColumnApi.getColumn('exercise').getColDef().editable = true;
        this.gridColumnApi.getColumn('sets').getColDef().editable = true;
        this.gridColumnApi.getColumn('reps').getColDef().editable = true;
        this.gridColumnApi.getColumn('weight').getColDef().editable = true;
        this.gridColumnApi.getColumn('effort').getColDef().editable = true;


    }
    toView(){
        this.onSubmit();
        this.setState({
            screen : true,
            dateEnabled: false});
        this.gridColumnApi.getColumn('exercise').getColDef().editable = false;
        this.gridColumnApi.getColumn('sets').getColDef().editable = false;
        this.gridColumnApi.getColumn('reps').getColDef().editable = false;
        this.gridColumnApi.getColumn('weight').getColDef().editable = false;
        this.gridColumnApi.getColumn('effort').getColDef().editable = false;
    }
    addRowData(row, self){
        var newItems = [{
            exercise: row.val().name,
            sets: row.val().sets,
            reps: row.val().reps,
            weight: row.val().weight,
            effort: row.val().effort,
            key: row.key
        }];
        this.gridApi.updateRowData({add: newItems});

    }
    importData(date){

        var self = this;
        self.state.dateKey = "";

        console.log("Import Data\n");
        var ref = firebase.database().ref('workoutDate/');
        ref.orderByChild('date').equalTo(date).on('value', function (snapshot) {

            snapshot.forEach(function(data) {
                console.log(data.key);
                self.state.dateKey = data.key;

            });
            var ref1 = firebase.database().ref('users/sBAGIexZ8o7DoBAgCeHf/workoutDate/' + self.state.dateKey +'/workouts/');
            ref1.orderByChild("name").on('value', function (snapshot) {
                console.log(snapshot.val());
                self.gridApi.setRowData([]);
                snapshot.forEach(function(childSnapshot) {
                    self.addRowData(childSnapshot, self);
                });
                self.setState({
                    startDate: date,
                    key: self.state.dateKey
                });

            }, function (errorObject) {
                console.log("The read failed: " + errorObject.code);
            });
        }, function (errorObject) {
            console.log("The read failed: " + errorObject.code);
        });



        // this.addItems();
    }

    onSubmitTrack(){
        this.setState({
            submit: true
        });
    }
    onSubmit(){
        // writeNewEx(this.state.startDate)
        // A post entry.

        // Get a key for a new Post.
        var newDateKey = this.state.key;



        // Write the new post's data simultaneously in the posts list and the user's post list.
        var updates = {};
        // updates['/workoutDate/' + newDateKey] = dateData;//, newDateKey];
        this.gridApi.forEachNode(node => writeNewWorkout(updates, node, newDateKey,this.state.startDate));

        this.onSubmitTrack();
        firebase.database().ref('users/sBAGIexZ8o7DoBAgCeHf/workoutDate/' + newDateKey +'/workouts/').set(null);
        return firebase.database().ref().update(updates);
    }

    render() {
        console.log("Render\n");
        const ComponentToRender = this.state.screen ? view : edit;

        return (
            <div style={{
                alignItems: 'center',
                padding: "1.0%"
            }}>
                <div className="text-center">
                    <ButtonToolbar >
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
                        &nbsp;&nbsp;
                        <h2>View and Edit Data</h2>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <Button color="primary" href="/enter">New Workout</Button>
                    </ButtonToolbar>
                </div>
                <ColoredLine color = "black"></ColoredLine>

                <div className="text-center"
                     style={{
                         padding: "1.0%"
                     }}>
                    <DatePicker
                        selected={this.state.startDate}
                        onChange={this.handleChange}

                        readOnly={this.state.dateEnabled}
                        placeholderText="View Lifting Data for :"
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
                        onGridReady={this.onGridReady}
                        singleClickEdit={true}>
                    </AgGridReact>
                </div>


            <ComponentToRender onEdit={ this.onEditButton.bind(this)}
                               addItems={this.addItems.bind(this)}
                               onRemoveSelected={this.onRemoveSelected.bind(this)}
                               toView={this.toView.bind(this)}/>
            </div>);
    }
}


export default parentView
