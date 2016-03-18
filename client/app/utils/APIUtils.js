import request from 'superagent';

import ServerActionCreators from '../actions/ServerActionCreators';
import { APIEndpoints } from '../constants/Constants';

function _getErrors(res) {
  let errorMsgs = ["Something went wrong, please try again"];
  let json = JSON.parse(res.text);
  if (!!json) {
    if (json['errors']) {
      errorMsgs = json['errors'];
    } else if (json['error']) {
      errorMsgs = [json['error']];
    }
  }
  return errorMsgs;
}

class APIUtils {
  login(email, password) {
    request.post(APIEndpoints.LOGIN)
      .send({ email: email, password: password, grant_type: 'password' })
      .set('Accept', 'application/json')
      .end(function(error, res) {
        if (res) {
          if (res.error) {
            let errorMsgs = _getErrors(res);
            ServerActionCreators.receiveLogin(null, errorMsgs);
          } else {
            let json = JSON.parse(res.text);
            ServerActionCreators.receiveLogin(json, null);
          }
        }
      });
  }

  contact(message) {
    request.post(APIEndpoints.CONTACT)
      .send({ message: message })
      .set('Accept', 'application/json')
      .end(function(error, res) {
        console.log(res);
        if (res) {
          if (res.error) {
            let errorMsgs = _getErrors(res);
            ServerActionCreators.receiveContactResponse(null, errorMsgs);
          } else {
            let json = JSON.parse(res.text);
            ServerActionCreators.receiveContactResponse(json, null);
          }
        }
      });
  }

  loadPosts(category) {
    category = category.toUpperCase();
    request.get(APIEndpoints.POSTS[category])
      .set('Accept', 'application/json')
      .end(function(error, res) {
        if (res) {
          let json = JSON.parse(res.text);
          ServerActionCreators.receivePosts(json, category);
        }
      });
  }

  loadPost(ref) {
    request.get(`${APIEndpoints.POST}/${ref}`)
      .set('Accept', 'application/json')
      .end(function(error, res) {
        if (res) {
          let json = JSON.parse(res.text);
          ServerActionCreators.receivePost(json);
        }
      });
  }

  createPost(post) {
    request.post(APIEndpoints.POST)
      .set('Accept', 'application/json')
      .set('Authorization', sessionStorage.getItem('accessToken'))
      .send({ post: post })
      .end(function(error, res) {
        if (res) {
          if (res.error) {
            let errorMsgs = _getErrors(res);
            ServerActionCreators.receiveCreatedPost(null, errorMsgs);
          } else {
            let json = JSON.parse(res.text);
            ServerActionCreators.receiveCreatedPost(json, null);
          }
        }
      });
  }

  updatePost(id, post) {
    request.patch(`${APIEndpoints.POST}/${id}`)
      .set('Accept', 'application/json')
      .set('Authorization', sessionStorage.getItem('accessToken'))
      .send({ post: post })
      .end(function(error, res) {
        if (res) {
          if (res.error) {
            let errorMsgs = _getErrors(res);
            ServerActionCreators.receiveUpdatedPost(null, errorMsgs);
          } else {
            let json = JSON.parse(res.text);
            ServerActionCreators.receiveUpdatedPost(json, null);
          }
        }
      });
  }
}

export default new APIUtils();
