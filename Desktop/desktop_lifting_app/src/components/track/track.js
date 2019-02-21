import React from 'react';
import { Button,  ButtonToolbar } from 'reactstrap';
import './ag-grid.css';
import "ag-grid-enterprise";
import 'ag-grid-community/dist/styles/ag-theme-blue.css';
import "react-datepicker/dist/react-datepicker.css";






class track extends React.Component {
  constructor(props) {
        super(props);

        this.state = {}
    }




	render() {
		return (
      <div style={{
        alignItems: 'center',
        padding: "01.0%"
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
                    <Button outline color="primary"  onClick={this.props.onSubmit}>{this.props.buttonName}</Button>
                  </ButtonToolbar>
                  </div>
    );
  }
}

//href="/view"




export default track
