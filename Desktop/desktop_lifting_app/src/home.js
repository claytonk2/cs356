import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';
mport { Helmet } from 'react-helmet'

const TITLE = 'Lifting Progress Tracker'

class home extends React.Component{
  componentDidMount(){
    document.title = "Lifting Progress Tracker"
  }

  render(){
    return(
      <b> document </b>
    )
  }
}

ReactDOM.render(
  <home />,
  document.getElementById('root')
);
