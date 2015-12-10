import { EventEmitter } from 'events';

import AppDispatcher from '../dispatcher/AppDispatcher';
import { ActionTypes } from '../constants/Constants';

const CHANGE_EVENT = 'change';

let _accessToken = sessionStorage.getItem('accessToken');
let _email = sessionStorage.getItem('email');
let _errors = [];

class SessionStore extends EventEmitter {
  emitChange() {
    this.emit(CHANGE_EVENT);
  }

  addChangeListener(callback) {
    this.on(CHANGE_EVENT, callback);
  }

  removeChangeListener(callback) {
    this.removeListener(CHANGE_EVENT, callback);
  }

  isLoggedIn() {
    return !!_accessToken;
  }

  getAccessToken() {
    return _accessToken;
  }

  getEmail() {
    return _email;
  }

  getErrors() {
    return _errors;
  }
};

const sessionStore = new SessionStore();

sessionStore.dispatchToken = AppDispatcher.register(function(payload) {
  const { action } = payload;

  switch(action.type) {

    case ActionTypes.LOGIN_RESPONSE:
      if (action.json && action.json.access_token) {
        _accessToken = action.json.access_token;
        _email = action.json.email;
        // Token will always live in the session, so that the API can grab it with no hassle
        sessionStorage.setItem('accessToken', _accessToken);
        sessionStorage.setItem('email', _email);
      }
      if (action.errors) {
        _errors = action.errors;
      }
      break;

    case ActionTypes.LOGOUT:
      _accessToken = null;
      _email = null;
      sessionStorage.removeItem('accessToken');
      sessionStorage.removeItem('email');
      break;

    default:
      return true;
  }

  sessionStore.emitChange();
  return true;
});

export default sessionStore;
