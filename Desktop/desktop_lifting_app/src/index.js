import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, Route } from 'react-router-dom';
import * as serviceWorker from './serviceWorker';

import App from "./components/App";
import home from "./components/home/home";
import track from "./components/track/track"
import edit from "./components/view/edit"
import graph from "./components/graph/graph"
import login from "./components/login/login"
import parentView from "./components/view/parentView"

import './index.css';
import 'bootstrap/dist/css/bootstrap.min.css';




ReactDOM.render(
	<BrowserRouter basename={process.env.PUBLIC_URL}>
		<div>
			<Route path='/' component={App} />
			<Route exact path='/' component={home} />
			<Route exact path='/enter' component={track} />
			<Route exact path='/graph' component={graph} />
			<Route exact path='/login' component={login} />
			<Route exact path='/view' component={parentView} />
			<Route exact path='/edit' component={edit} />
		</div>
	</BrowserRouter>,
	document.getElementById('root')
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: http://bit.ly/CRA-PWA
serviceWorker.register();
