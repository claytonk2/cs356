import React from 'react';
import {Link} from 'react-router-dom'
import './App.css';

class App extends React.Component {
	render() {
		return (
			<div className="container-fluid" style={{padding:0}}>

				<nav className="navbar navbar-expand-sm bg-dark navbar-dark" style={{padding: '0 5rem'}}>
					<Link className="navbar-brand" to="/" activeclassname="active">Lifting Progress Tracker</Link>
					<button className="navbar-toggler" type="button" data-toggle="collapse"
							data-target="#collapsibleNavbar">
						<span className="navbar-toggler-icon">
						</span>
					</button>
					<div className="collapse navbar-collapse" id="collapsibleNavbar">
						<ul className="navbar-nav">
							<li className="nav-item">
								<Link className="nav-link" to="/" activeclassname="active">Home</Link>
							</li>
							<li className="nav-item">
								<Link className="nav-link" to="/enter" activeclassname="active">About</Link>
							</li>
              <li className="nav-item">
								<Link className="nav-link" to="/graph" activeclassname="active">About</Link>
							</li>
              <li className="nav-item">
								<Link className="nav-link" to="/view" activeclassname="active">About</Link>
							</li>
              <li className="nav-item">
								<Link className="nav-link" to="/login" activeclassname="active">About</Link>
							</li>
						</ul>
					</div>
				</nav>


			</div>
		);
	}
}

export default App;
