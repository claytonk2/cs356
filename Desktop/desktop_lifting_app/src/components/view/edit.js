import React from 'react';
import { render } from "react-dom";
import { Link } from 'react-router-dom';
import { AgGridReact } from 'ag-grid-react';
import { Button, ButtonGroup, ButtonToolbar } from 'reactstrap';
import "ag-grid-enterprise";
import 'ag-grid-community/dist/styles/ag-theme-blue.css';
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import View from "./view";

const ColoredLine = ({ color }) => (
    <hr
        style={{
            color: color,
            backgroundColor: color,
            height: 1
        }}
    />
);

class edit extends React.Component {



	// componentDidMount() { //https://medium.com/ag-grid/get-started-with-react-grid-in-5-minutes-f6e5fb16afa
	//     fetch('https://api.myjson.com/bins/15psn9')
	//         .then(result => result.json())
	//         .then(rowData => this.setState({rowData}))
	// }



render() {
	return (
		<div style={{
			alignItems: 'center',
			padding: "1.0%"
	}}>

		<ButtonToolbar style={{  padding: "0.5%" }}>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<Button outline color="primary" onClick={this.props.addItems}>+ Add More</Button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<Button outline color="danger" onClick={this.props.onRemoveSelected}>Delete Selected Row</Button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<Button outline color="primary" onClick={this.props.toView}>Save</Button>
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
export default edit
