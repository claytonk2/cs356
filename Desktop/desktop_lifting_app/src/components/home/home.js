import React from 'react';

const ColoredLine = ({ color }) => (
    <hr
        style={{
            color: color,
            backgroundColor: color,
            height: 1
        }}
    />
);

class home extends React.Component {
	render() {
		return (
            <div style={{
                alignItems: 'center',
                padding: "01.0%"
            }}>
                <div className="text-center">
				<h1>Lifting Progress Tracker</h1>
                    <ColoredLine color = "black"></ColoredLine>
                <p>Record lifting data to be tracked over time.</p>
                <p>Track lifting progress.</p>
                <p> View and edit past data.</p>
            </div>
        </div>
    );
  }
}

export default home
