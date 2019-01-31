import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, Route } from 'react-router-dom';
import * as serviceWorker from './serviceWorker';

import App from "./components/App";
import home from "./components/home/home";
import track from "./components/track/track"
import graph from "./components/graph/graph"
import login from "./components/login/login"
import view from "./components/view/view"

import './index.css';
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';

ReactDOM.render(
	<BrowserRouter basename={process.env.PUBLIC_URL}>
		<div>
			<Route path='/' component={App} />
			<Route exact path='/' component={home} />
			<Route exact path='/enter' component={track} />
			<Route exact path='/graph' component={graph} />
			<Route exact path='/login' component={login} />
			<Route exact path='/view' component={view} />
		</div>
	</BrowserRouter>,
	document.getElementById('root')
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: http://bit.ly/CRA-PWA
serviceWorker.unregister();
