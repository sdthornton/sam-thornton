import AppDispatcher from '../dispatcher/AppDispatcher';
import { ActionTypes } from '../constants/Constants.js';

class ServerActionCreators {
  receiveLogin(json, errors) {
    AppDispatcher.handleServerAction({
      type: ActionTypes.LOGIN_RESPONSE,
      json: json,
      errors: errors
    });
  }

  receiveContactResponse(json, errors) {
    AppDispatcher.handleServerAction({
      type: ActionTypes.CONTACT_RESPONSE,
      json: json,
      errors: errors
    });
  }

  receivePosts(json, category) {
    AppDispatcher.handleServerAction({
      type: ActionTypes[`RECEIVE_${category}_POSTS`],
      json: json
    });
  }

  receivePost(json) {
    AppDispatcher.handleServerAction({
      type: ActionTypes.RECEIVE_POST,
      json: json
    });
  }

  receiveCreatedPost(json, errors) {
    AppDispatcher.handleServerAction({
      type: ActionTypes.RECEIVE_CREATED_POST,
      json: json,
      errors: errors
    });
  }
}

export default new ServerActionCreators();
