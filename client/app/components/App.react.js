import React from 'react';
import { Link } from 'react-router';
import DocumentTitle from 'react-document-title';

import SessionActionCreators from '../actions/SessionActionCreators';
import SessionStore from '../stores/SessionStore';

function getStateFromStores() {
  return {
    isLoggedIn: SessionStore.isLoggedIn(),
    email: SessionStore.getEmail()
  };
}

export default class App extends React.Component {
  constructor() {
    super();
    this.state = getStateFromStores();
  }

  componentDidMount() {
    SessionStore.addChangeListener(this._onSessionChange);
  }

  componentWillUnmount() {
    SessionStore.removeChangeListener(this._onSessionChange);
  }

  render() {
    const sessionLink = this.state.isLoggedIn ?
      <Link to={'/logout'}>Logout</Link> : null;

    const newPostLink = this.state.isLoggedIn ?
      <Link to={'/posts/new'}>New Post</Link> : null;

    return(
      <DocumentTitle title="Sample App">
        <div>
          <nav>
            <Link to={'/'}>Home</Link>
            <Link to={'/about'}>About</Link>
            <Link to={'/faith'}>Faith</Link>
            <Link to={'/tech'}>Tech</Link>
            <Link to={'/contact'}>Contact</Link>
            {newPostLink}
            {sessionLink}
          </nav>
          {this.props.children}
        </div>
      </DocumentTitle>
    );
  }

  _onSessionChange = () => {
    this.setState(getStateFromStores());
  }
};
