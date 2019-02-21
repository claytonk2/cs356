import React from 'react';
import { Button, ButtonToolbar } from 'reactstrap';
import "ag-grid-enterprise";
import 'ag-grid-community/dist/styles/ag-theme-blue.css';
import "react-datepicker/dist/react-datepicker.css";


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
		</ButtonToolbar>
		</div>
	);
}
}



export default edit
