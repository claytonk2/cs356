import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, Route } from 'react-router-dom';
import * as serviceWorker from './serviceWorker';

import App from "./components/App";
import HomePage from "./components/home/home";

import './index.css';
import '../node_modules/bootstrap/dist/css/bootstrap.min.css';

ReactDOM.render(
	<BrowserRouter basename={process.env.PUBLIC_URL}>
		<div>
			<Route path='/' component={App} />
			<Route exact path='/' component={HomePage} />
			//<Route exact path='/about' component={AboutPage} />
		</div>
	</BrowserRouter>,
	document.getElementById('root')
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: http://bit.ly/CRA-PWA
serviceWorker.unregister();
