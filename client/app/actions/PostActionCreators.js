import AppDispatcher from '../dispatcher/AppDispatcher';
import { ActionTypes } from '../constants/Constants';
import APIUtils from '../utils/APIUtils';

class PostActionCreators {

  loadPosts(category) {
    AppDispatcher.handleViewAction({
      type: ActionTypes[`LOAD_${category}_POSTS`]
    });
    APIUtils.loadPosts(category);
  }

  loadPost(ref) {
    AppDispatcher.handleViewAction({
      type: ActionTypes.LOAD_POST,
      ref: ref
    });
    APIUtils.loadPost(ref);
  }

  createPost(post) {
    AppDispatcher.handleViewAction({
      type: ActionTypes.CREATE_POST,
      title: post.title,
      body: post.body,
      category: post.category
    });
    APIUtils.createPost(post);
  }

  updatePost(id, post) {
    AppDispatcher.handleViewAction({
      type: ActionTypes.UPDATE_POST,
      id: id,
      title: post.title,
      body: post.body,
      category: post.category
    });
    APIUtils.updatePost(id, post);
  }
}

export default new PostActionCreators();
