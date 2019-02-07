import firebase, { auth, provider } from './firebase.js';

var config = {
    apiKey: "AIzaSyB02S6Ywn2m-QGobXXlNmFT3vxrJYv6uH4",
    authDomain: "liftingprogresstracker.firebaseapp.com",
    databaseURL: "https://liftingprogresstracker.firebaseio.com",
    projectId: "liftingprogresstracker",
    storageBucket: "liftingprogresstracker.appspot.com",
    messagingSenderId: "22311839866"
  };
firebase.initializeApp(config);
export const provider = new firebase.auth.GoogleAuthProvider();
export const auth = firebase.auth();
export default firebase;
