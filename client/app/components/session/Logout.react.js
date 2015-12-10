import React from 'react';
import { History } from 'react-router';

import SessionActionCreators from '../../actions/SessionActionCreators';
import SessionStore from '../../stores/SessionStore';

import ErrorNotice from '../shared/ErrorNotice.react';

export default class Logout extends React.Component {
  constructor(props) {
    super(props);
    this.history = props.history;
  }

  componentWillMount() {
    SessionStore.addChangeListener(this._onChange);
    SessionActionCreators.logout();
  }

  componentWillUnmount() {
    SessionStore.removeChangeListener(this._onChange);
  }

  render() {
    return (
      <p>You are now logged out</p>
    );
  }

  _onChange = () => {
    this.history.replaceState(null, '/');
  }
}
