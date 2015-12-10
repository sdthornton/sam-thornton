import { PayloadSources } from '../constants/Constants';
import { Dispatcher } from 'flux';

class AppDispatcher extends Dispatcher {
  handleServerAction(action) {
    const payload = {
      source: PayloadSources.SERVER_ACTION,
      action: action
    };
    this.dispatch(payload);
  }

  handleViewAction(action) {
    const payload = {
      source: PayloadSources.VIEW_ACTION,
      action: action
    };
    this.dispatch(payload);
  }
}

export default new AppDispatcher();
