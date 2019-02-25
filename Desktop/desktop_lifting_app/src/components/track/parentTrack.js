import React from 'react';
import track from './track'
import view from "../view/view";
import DatePicker from "react-datepicker/es";
import {AgGridReact} from "ag-grid-react";
import firebase from "../firebase";


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



class parentTrack extends React.Component {
    constructor(props) {
        super(props);
        this.state={
            submit: false,
            edit: false,

            buttonName: "Submit",
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
                {exercise: "exercise", sets: 0, reps: 0, weight: 0, effort: "medium"}
            ],
            rowSelection: "multiple",
            key: "",
            startDate: new Date()

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
    onSubmit(){
        // writeNewEx(this.state.startDate)
        // A post entry.

        var dateData= {
            date: this.state.startDate
        };
        // Get a key for a new Post.
        var newDateKey;
        if(this.state.edit) { //todo figure out why this isnt working
            newDateKey = this.state.key
        }
        else{
            newDateKey = firebase.database().ref().child('workoutDate').push().key;
        }



        // Write the new post's data simultaneously in the posts list and the user's post list.
        var updates = {};
        updates['/workoutDate/' + newDateKey] = dateData;//, newDateKey];
        this.gridApi.forEachNode(node => writeNewWorkout(updates, node, newDateKey,this.state.startDate));

        this.onSubmitTrack();
        firebase.database().ref('users/sBAGIexZ8o7DoBAgCeHf/workoutDate/' + newDateKey +'/workouts/').set(null);

        return firebase.database().ref().update(updates);
    }
    handleChange(date) {
        this.importData(date.toISOString());
        // this.props.onChangeDate(date);
    }

    addRowData(row, self){
        var newItems = [{
            exercise: row.name,
            sets: row.sets,
            reps: row.reps,
            weight: row.weight,
            effort: row.effort
        }];
        self.gridApi.updateRowData({add: newItems});

    }
    importData(date){

        var self = this;
        var dateKey = "";
        this.gridApi.setRowData([]);
        self.setState({
            edit: false
        });
        console.log("Import Data\n");
        var ref = firebase.database().ref('workoutDate/');
        ref.orderByChild('date').equalTo(date).on('value', function (snapshot) {
            console.log(snapshot.key);
            snapshot.forEach(function(data) {
                self.state.dateKey = data.key;


            var ref1 = firebase.database().ref('users/sBAGIexZ8o7DoBAgCeHf/workoutDate/' + self.state.dateKey +'/workouts/');
            ref1.orderByChild("name").on('value', function (snapshot) {
                console.log(snapshot.val());
                self.gridApi.setRowData([]);
                snapshot.forEach(function(childSnapshot) {
                    self.addRowData(childSnapshot.val(), self);
                });
                self.setState({
                    key: self.state.dateKey,
                    edit: true
                });
            }, function (errorObject) {
                console.log("The read failed: " + errorObject.code);
            });
            });
        }, function (errorObject) {
            console.log("The read failed: " + errorObject.code);
        });


        self.setState({
            startDate: date,
            buttonName: "Submit"
        });
        // this.addItems();
    }
    // onChangeDate(date){
    //     this.setState({
    //         startDate: date
    //     });
    // }
    onSubmitTrack(){
        this.setState({
            submit: true
        });
    }
    onEditTrack(){
        this.setState({
            submit: false,
            edit: true,
            buttonName: "Save"
        });
    }
    render() {
        const ComponentToRender = this.state.submit ? view : track;
        return (
            <div style={{
                alignItems: 'center',
                padding: "01.0%"
            }}>
            <div className="text-center">

                <h2>Enter Data to be Tracked</h2>
                <ColoredLine color = "black"></ColoredLine>
            </div>
            <div className="text-center"
        style={{
            padding: "1.0%"
        }}>
                <p>Record Lifting Data for :</p>


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
                onGridReady={this.onGridReady}
                singleClickEdit={true}>
            </AgGridReact>
        </div>
            <ComponentToRender  onSubmit={this.onSubmit.bind(this)}
                                buttonName={this.state.buttonName}
                                onEdit={this.onEditTrack.bind(this)}
                                addItems={this.addItems.bind(this)}
                                onRemoveSelected={this.onRemoveSelected.bind(this)}/>
        </div>
        );
    }
}
export default parentTrack