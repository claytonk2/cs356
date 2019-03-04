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
                padding: "0.5%"
            }}>
                <div className="text-center">
                    <img src={ require('./logo.png') } />

                    <ColoredLine color = "black"></ColoredLine>
                <h1>Record lifting data to be tracked over time.</h1>
                    <img src={ require('./track.png') } />
                <h1>Track lifting progress.</h1>
                    <img src={ require('./graph.png') } />
                <h1> View and edit past data.</h1>
                    <img src={ require('./view.png') } />
            </div>
        </div>
    );
  }
}

export default home
