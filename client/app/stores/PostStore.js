import { EventEmitter } from 'events';
import Immutable from 'immutable';

import AppDispatcher from '../dispatcher/AppDispatcher';
import { ActionTypes } from '../constants/Constants';

const CHANGE_EVENT = 'change';

const Post = Immutable.Record({
  abstract: "",
  body: "",
  category: undefined,
  created_at: undefined,
  id: undefined,
  title: "",
  url: undefined
});

class PostStore extends EventEmitter {
  constructor() {
    super();
    this.faith_posts = Immutable.OrderedMap();
    this.tech_posts = Immutable.OrderedMap();
    this.errors = Immutable.List();
    this.post = new Post();
  }

  emitChange() {
    this.emit(CHANGE_EVENT);
  }

  addChangeListener(callback) {
    this.on(CHANGE_EVENT, callback);
  }

  removeChangeListener(callback) {
    this.removeListener(CHANGE_EVENT, callback);
  }

  getPosts(category) {
    return this[`${category.toLowerCase()}_posts`];
  }

  getPost() {
    return this.post;
  }

  setPost(post) {
    this.post = new Post(post);
  }

  getErrors() {
    return this.errors;
  }

  _createTmpPosts = (posts) => {
    let tmp = Immutable.OrderedMap();
    posts.map(post => {
      tmp = tmp.set(post.id, new Post(post))
    });
    return tmp;
  }

  dispatchToken = AppDispatcher.register((payload) => {
    const { action } = payload;

    switch(action.type) {
      case ActionTypes.RECEIVE_FAITH_POSTS:
        const faithTmp = this._createTmpPosts(action.json.posts);
        if (!Immutable.is(this.faith_posts, faithTmp)) {
          this.faith_posts = faithTmp;
        }
        break;

      case ActionTypes.RECEIVE_CREATED_FAITH_POST:
        if (action.json) {
          this.faith_posts.unshift(action.json.post);
          this.errors = [];
        }
        if (action.errors) {
          this.errors = action.errors;
        }
        break;

      case ActionTypes.RECEIVE_TECH_POSTS:
        const techTemp = this._createTmpPosts(action.json.posts);
        if (!Immutable.is(this.tech_posts, techTemp)) {
          this.tech_posts = techTemp;
        }
        break;

      case ActionTypes.RECEIVE_CREATED_TECH_POST:
        if (action.json) {
          this.tech_posts.unshift(action.json.post);
          this.errors = [];
        }
        if (action.errors) {
          this.errors = action.errors;
        }
        break;

      case ActionTypes.RECEIVE_POST:
        if (action.json) {
          this.post = new Post(action.json.post);
          this.errors = [];
        }
        if (action.errors) {
          this.errors = action.errors;
        }
        break;

      default:
        return true;
    }

    this.emitChange();
    return true;
  });
}

export default new PostStore();
