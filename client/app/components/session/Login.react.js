import React from 'react';
import { History } from 'react-router';

import SessionActionCreators from '../../actions/SessionActionCreators';
import SessionStore from '../../stores/SessionStore';

import ErrorNotice from '../shared/ErrorNotice.react';

export default class Login extends React.Component {
  constructor(props) {
    super(props);
    this.props = props;
    this.state = { errors: [] };
  }

  componentDidMount() {
    SessionStore.addChangeListener(this._onChange);
  }

  componentWillUnmount() {
    SessionStore.removeChangeListener(this._onChange);
  }

  render() {
    const errors = (this.state.errors.length > 0) ?
      <ErrorNotice errors={this.state.errors}/> : <div></div>;

    return (
      <div>
        {errors}
        <form onSubmit={this._onSubmit}>
          <label name="email">Email</label>
          <input type="text" name="email" ref="email" />
          <label name="password">Password</label>
          <input type="password" name="password" ref="password" />
          <button type="submit" className="card--login__submit">Login</button>
        </form>
      </div>
    );
  }

  _onChange = () => {
    const { location, history } = this.props;

    this.setState({
      errors: SessionStore.getErrors()
    }, () => {
      if (SessionStore.isLoggedIn()) {
        if (location.state && location.state.nextState) {
          history.replaceState(null, location.state.nextState);
        } else {
          history.replaceState(null, '/');
        }
      }
    });
  }

  _onSubmit = (e) => {
    e.preventDefault();
    this.setState({ errors: [] });
    const email = this.refs.email.value;
    const password = this.refs.password.value;
    SessionActionCreators.login(email, password);
  }
}
