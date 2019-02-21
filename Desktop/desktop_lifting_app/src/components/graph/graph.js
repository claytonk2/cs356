import React from 'react';
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
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
			startDate: new Date()
		}
	}
    handleChange(date) {
        this.setState({
            startDate: date
        });
    }
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
			</div>
    );
  }
}

export default graph
