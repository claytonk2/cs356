// import React from 'react';
// import { Link } from 'react-router-dom';
//
// class login extends React.Component {
// 	constructor(props) {
//     super(props);
//
//     this.state = { error: null };
// 		this.login = this.login.bind(this);
//   }
//
//   // onSubmit = event => {
//   //   this.props.firebase
//   //     .doSignInWithGoogle()
//   //     .then(socialAuthUser => {
//   //       this.setState({ error: null });
//   //       this.props.history.push(ROUTES.HOME);
//   //     })
//   //     .catch(error => {
//   //       this.setState({ error });
//   //     });
// 	//
//   //   event.preventDefault();
//   // };
// 	login() {
// 		auth.signInWithPopup(provider)
// 			.then((result) => {
// 				const user = result.user;
// 				this.setState({
// 					user
// 				});
// 			});
// 	}
//   render() {
//     const { error } = this.state;
//
//     return (
//       <form onSubmit={this.onSubmit}>
//         <button type="submit" onClick={this.login.bind(this)}>Sign In with Google</button>
//
//         {error && <p>{error.message}</p>}
//       </form>
//     );
//   }
// }
//
// export default login
