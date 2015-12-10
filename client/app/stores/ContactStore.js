import { EventEmitter } from 'events';

import AppDispatcher from '../dispatcher/AppDispatcher';
import { ActionTypes } from '../constants/Constants';

const CHANGE_EVENT = 'change';

let _response = {};
let _errors = {};

class ContactStore extends EventEmitter {
  emitChange() {
    this.emit(CHANGE_EVENT);
  }

  addChangeListener(callback) {
    this.on(CHANGE_EVENT, callback);
  }

  removeChangeListener(callback) {
    this.removeListener(CHANGE_EVENT, callback);
  }

  getResponse() {
    return _response;
  }

  getErrors() {
    return _errors;
  }
};

const contactStore = new ContactStore();

contactStore.dispatchToken = AppDispatcher.register(function(payload) {
  const { action } = payload;

  switch(action.type) {

    case ActionTypes.LOGIN_RESPONSE:
      if (action.json) {
        _response = action.json.success;
      }
      if (action.errors) {
        _errors = action.errors;
      }
      break;

    default:
      return true;
  }

  contactStore.emitChange();
  return true;
});

export default contactStore;
