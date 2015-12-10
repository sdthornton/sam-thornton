import React from 'react';

import ContactActionCreators from '../actions/ContactActionCreators';
import ContactStore from '../stores/ContactStore';

export default class Contact extends React.Component {
  constructor() {
    super();
    this.state = {
      contactResponse: {},
      errors: {}
    }
  }

  componentDidMount() {
    ContactStore.addChangeListener(this._onChange);
  }

  componentWillUnmount() {
    ContactStore.removeChangeListener(this._onChange);
  }

  render() {
    return (
      <form onSubmit={this._onSubmit}>
        <input type="text" id="subject" ref="subject" />
        <input type="submit" value="Send" />
      </form>
    );
  }

  _onChange = () => {
    this.setState({
      post: ContactStore.getResponse(),
      errors: ContactStore.getErrors()
    });
  }

  _onSubmit = (e) => {
    e.preventDefault();
    ContactActionCreators.send({})
  }
}
