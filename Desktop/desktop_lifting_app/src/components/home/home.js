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
{/*<h1>Lifting Progress Tracker</h1>*/}
class home extends React.Component {
	render() {
		return (
            <div style={{
                alignItems: 'center',
                padding: "01.0%"
            }}>
                <div className="text-center">
                    <img src={ require('./logo.png') } />

                    <ColoredLine color = "black"></ColoredLine>
                <p>Record lifting data to be tracked over time.</p>
                    <img src={ require('./track.png') } />
                <p>Track lifting progress.</p>
                    <img src={ require('./graph.png') } />
                <p> View and edit past data.</p>
                    <img src={ require('./view.png') } />
            </div>
        </div>
    );
  }
}

export default home
