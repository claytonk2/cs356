import React from 'react';
import { Link } from 'react-router-dom';
const ColoredLine = ({ color }) => (
    <hr
        style={{
            color: color,
            backgroundColor: color,
            height: 1
        }}
    />
);

class track extends React.Component {
	render() {
		return (
			<div className="text-left">
				<p> accountName	 accoutUserName </p>

				<ColoredLine color="blue" /> // fix the color and spaceing
				<h2>Enter data to be tracked</h2>
			</div>


    );
  }
}

export default track
