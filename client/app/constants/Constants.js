import keyMirror from 'keymirror';

const APIRoot = "http://localhost:3000";

export default {

  APIEndpoints: {
    LOGIN: `${APIRoot}/v1/login`,
    CONTACT: `${APIRoot}/v1/contact`,
    POST: `${APIRoot}/v1/posts`,
    POSTS: {
      FAITH: `${APIRoot}/v1/faith`,
      TECH: `${APIRoot}/v1/tech`
    }
  },

  PayloadSources: keyMirror({
    SERVER_ACTION: null,
    VIEW_ACTION: null
  }),

  ActionTypes: keyMirror({
    // Session
    LOGIN_REQUEST: null,
    LOGIN_RESPONSE: null,

    // Contact
    CONTACT_RESPONSE: null,

    // Routes
    REDIRECT: null,
    LOAD_FAITH_POSTS: null,
    RECEIVE_FAITH_POSTS: null,
    LOAD_TECH_POSTS: null,
    RECEIVE_TECH_POSTS: null,
    LOAD_POST: null,
    RECEIVE_POST: null,
    CREATE_POST: null,
    RECEIVE_CREATED_FAITH_POST: null,
    RECEIVE_CREATED_TECH_POST: null,
    UPDATE_POST: null,
    RECEIVE_UPDATED_FAITH_POST: null,
    RECEIVE_UPDATED_TECH_POST: null
  })

};
