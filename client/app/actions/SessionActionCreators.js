import AppDispatcher from '../dispatcher/AppDispatcher';
import { ActionTypes } from '../constants/Constants';
import APIUtils from '../utils/APIUtils';

class SessionActionCreators {
  login(email, password) {
    AppDispatcher.handleViewAction({
      type: ActionTypes.LOGIN_REQUEST,
      email: email,
      password: password
    });
    APIUtils.login(email, password);
  }

  logout() {
    AppDispatcher.handleViewAction({
      type: ActionTypes.LOGOUT
    });
  }
}

export default new SessionActionCreators();
