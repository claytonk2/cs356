import React from 'react';
import {Link} from 'react-router-dom'
import './App.css';


class App extends React.Component {
	constructor(props) {
        super(props);

        this.state = {
						accountName: "Example User",
						accoutUserName: "user123",
            workouts: []
					}

				}

    componentWillMount() {
        document.title = 'Lifting Progress Tracker'
    }
	render() {
		return (
			<div className="container-fluid" style={{padding:0}}>

				<nav className="navbar navbar-expand-sm bg-primary navbar-dark" style={{padding: '0 5rem'}}>
					<Link className="navbar-brand" to="/home" activeclassname="active">Lifting Progress Tracker</Link>
					<button className="navbar-toggler" type="button" data-toggle="collapse"
							data-target="#collapsibleNavbar">
						<span className="navbar-toggler-icon">
						</span>
					</button>
					<div className="collapse navbar-collapse" id="collapsibleNavbar">
						<ul className="navbar-nav">
							<li className="nav-item">
								<Link className="nav-link" to="/home" activeclassname="active">Home</Link>
							</li>
							<li className="nav-item">
								<Link className="nav-link" to="/view" activeclassname="active">View Workouts</Link>
							</li>
                            <li className="nav-item">
                                <Link className="nav-link" to="/graph" activeclassname="active">Progress Tracker</Link>
                            </li>
							</ul>
							<ul className="navbar-nav ml-auto">
							<span class="navbar-brand mb-0 p">{this.state.accountName}</span>
							<span class="navbar-brand mb-0 p">{this.state.accoutUserName}</span>
              <li className="nav-item">
								<Link className="nav-link" to="/login" activeclassname="active">Sign In</Link>
							</li>
						</ul>
					</div>
				</nav>


			</div>
		);
	}
}

export default App;
