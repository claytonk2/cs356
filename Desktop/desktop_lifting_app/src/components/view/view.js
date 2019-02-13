import React from 'react';
import { Button,  ButtonToolbar } from 'reactstrap';
import "ag-grid-enterprise";
import 'ag-grid-community/dist/styles/ag-theme-blue.css';
import "react-datepicker/dist/react-datepicker.css";



class view extends React.Component {

// constructor(props) {
// 			super(props);
//
// 			this.state = {
// 					columnDefs: this.props.columnDefs,
// 					rowData: this.props.rowData,
// 					rowSelection: "multiple",
// 					startDate: this.props.startDate
//
// 			}
// 			this.handleChange = this.handleChange.bind(this);
// 	}

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
			padding: "1.0%"
	}}>



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
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<Button outline color="primary" onClick={this.props.onEdit} >Edit Data</Button>
		</ButtonToolbar>;
		</div>
	);
}
}



export default view
