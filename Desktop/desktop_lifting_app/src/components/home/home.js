import React from 'react';
import { Link } from 'react-router-dom';

class home extends React.Component {
	render() {
		return (
			<div className="jumbotron text-center">
				<h1>Lifting Progress Tracker</h1>
        <p>Record lifting data to be tracked over time.</p>
        <p>Track lifting progress.</p>
        <p> View and edit past data.</p>
      </div>
    );
  }
}

export default home
