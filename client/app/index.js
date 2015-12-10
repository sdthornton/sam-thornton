import 'babel-polyfill';

import React from 'react';
import { render } from 'react-dom';
import { Router, Route, Link } from 'react-router';
import { createHistory } from 'history';

import routes from './config/routes';

index();

function index() {
  const history = createHistory();

  return (
    render(<Router history={history} routes={routes} />,
      document.getElementById('root'))
  );
}
