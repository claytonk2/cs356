import React from 'react';
import { AgGridReact } from 'ag-grid-react';
import "ag-grid-enterprise";
import 'ag-grid-community/dist/styles/ag-theme-blue.css';
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

import view from "./view.js"
import edit from "./edit.js"

import firebase from '../firebase.js'


const ColoredLine = ({ color }) => (
    <hr
        style={{
            color: color,
            backgroundColor: color,
            height: 1
        }}
    />
);

// if(this.state.screen == "view"){https://stackoverflow.com/questions/50068189/switching-between-two-components-in-react
//     return </view>;
// }else{
//     return <edit></edit>;
// }


// var dateKey = ""
// var ref = firebase.database().ref('sBAGIexZ8o7DoBAgCeHf/');
// ref.orderByChild("workoutDate/").equalTo(date).on('value', function (snapshot) {
//     console.log(snapshot.val());
//     dateKey = snapshot.key;
// }, function (errorObject) {
//     console.log("The read failed: " + errorObject.code);
// });
//
// var ref1 = firebase.database().ref('sBAGIexZ8o7DoBAgCeHf/workouts/');
// ref1.orderByChild("dateId").equalTo(dateKey).on('value', function (snapshot) {
//     console.log(snapshot.val());
//     snapshot.forEach(function(childSnapshot) {
//         this.addRowData(childSnapshot.val());
//     });
// }, function (errorObject) {
//     console.log("The read failed: " + errorObject.code);
// });

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
            rowData: props.rowData,
            rowSelection: "multiple",
            screen: true,
            dateEnabled: false,
            startDate: props.startDate,
            key: "this"

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
        this.gridApi.updateRowData({ add: newItems });

    }
    onRemoveSelected() {
        var selectedData = this.gridApi.getSelectedRows();
        this.gridApi.updateRowData({ remove: selectedData });

    }
    handleChange(date) {
        this.importData(date.toISOString());
        this.setState({
            startDate: date
        });

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
        this.setState({
            screen : true,
            dateEnabled: false});
        this.gridColumnApi.getColumn('exercise').getColDef().editable = false;
        this.gridColumnApi.getColumn('sets').getColDef().editable = false;
        this.gridColumnApi.getColumn('reps').getColDef().editable = false;
        this.gridColumnApi.getColumn('weight').getColDef().editable = false;
        this.gridColumnApi.getColumn('effort').getColDef().editable = false;
    }
    addRowData(row){
        var newItems = [{
            exercise: row.name,
            sets: row.sets,
            reps: row.reps,
            weight: row.weight,
            effort: row.effort
        }];
        this.gridApi.updateRowData({add: newItems});

    }
    importData(date){
        // var dateKey = ""
        // var self = this;
        // console.log("Import Data\n");
        // var ref = firebase.database().ref('sBAGIexZ8o7DoBAgCeHf/');
        // ref.orderByChild("workoutDate/").equalTo(date).on('value', function (snapshot) {
        //     console.log(snapshot.val());
        //     snapshot.val().workouts.forEach(function(childSnapshot) {
        //         self.addRowData(childSnapshot.val());
        //     });
        // }, function (errorObject) {
        //     console.log("The read failed: " + errorObject.code);
        // });

        var self = this;
        var dateKey = "";
        console.log("Import Data\n");
        var ref = firebase.database().ref('workoutDate/');
        ref.orderByChild('date').equalTo(date).on('value', function (snapshot) {
            console.log(snapshot.key);
            snapshot.forEach(function(data) {
                self.dateKey = data.key;

            })
        }, function (errorObject) {
            console.log("The read failed: " + errorObject.code);
        });
        self.setState({
            key: self.dateKey
        });
        var ref1 = firebase.database().ref('users/sBAGIexZ8o7DoBAgCeHf/workoutDate/' + dateKey +'/workouts/');
        ref1.orderByChild("name").on('child_added', function (snapshot) {
            console.log(snapshot.val());
            snapshot.val().forEach(function(childSnapshot) {
                self.addRowData(childSnapshot.val());
            });
        }, function (errorObject) {
            console.log("The read failed: " + errorObject.code);
        });
        this.addItems();
    }
    // componentDidMount() { //https://medium.com/ag-grid/get-started-with-react-grid-in-5-minutes-f6e5fb16afa
    //     fetch('https://api.myjson.com/bins/15psn9')
    //         .then(result => result.json())
    //         .then(rowData => this.setState({rowData}))
    // }



    render() {
        console.log("Render\n");
        const ComponentToRender = this.state.screen ? view : edit;
        return (
            <div style={{
                alignItems: 'center',
                padding: "1.0%"
            }}>
                <div className="text-center">

                    <h2>View and Edit Data</h2>
                    <p> {this.state.key}</p>
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
                        placeholderText="Edit Lifting Data for :"
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
