import AppDispatcher from '../dispatcher/AppDispatcher';
import { ActionTypes } from '../constants/Constants';
import APIUtils from '../utils/APIUtils';

class ContactActionCreators {
  send(message) {
    AppDispatcher.handleViewAction({
      type: ActionTypes.SEND_CONTACT,
      message: message
    });
    APIUtils.contact(message);
  }
}

export default new ContactActionCreators();
