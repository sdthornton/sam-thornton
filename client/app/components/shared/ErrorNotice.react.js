import React from 'react';

export default class ErrorNotice extends React.Component {
  render() {
    const { errors } = this.props;

    return (
      <ul>
        {errors.map(function(error, index) {
          return <li key={`error-${index}`}>{error}</li>;
        })}
      </ul>
    );
  }
}
