import React from 'react';
import { render } from "react-dom";
import { Link } from 'react-router-dom';
import { AgGridReact } from 'ag-grid-react';
import { Button, ButtonGroup, ButtonToolbar } from 'reactstrap';
import "ag-grid-enterprise";
import 'ag-grid-community/dist/styles/ag-theme-blue.css';
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

import view from "./view.js"
import edit from "./edit.js"


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
            rowData: [
                {exercise: "Bench", sets: 5, reps: 5, weight: 275, effort: "medium"},
                {exercise: "DB Bench", sets: 3, reps: 10, weight: 100, effort: "medium"},
                {exercise: "Fly ", sets: 3, reps: 12, weight: 45, effort: "medium"},
                {exercise: "Row", sets: 3, reps: 10, weight: 225, effort: "medium"}
            ],
            rowSelection: "multiple",
            screen: true,
            dateEnabled: false

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

    }
    onRemoveSelected() {
        var selectedData = this.gridApi.getSelectedRows();
        var res = this.gridApi.updateRowData({ remove: selectedData });

    }
    handleChange(date) {
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

    // componentDidMount() { //https://medium.com/ag-grid/get-started-with-react-grid-in-5-minutes-f6e5fb16afa
    //     fetch('https://api.myjson.com/bins/15psn9')
    //         .then(result => result.json())
    //         .then(rowData => this.setState({rowData}))
    // }



    render() {
        const ComponentToRender = this.state.screen ? view : edit;
        return (
            <div style={{
                alignItems: 'center',
                padding: "1.0%"
            }}>
                <div className="text-center">

                    <h2>View and edit data here</h2>
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
