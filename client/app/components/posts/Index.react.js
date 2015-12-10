import React from 'react';
import { Link } from 'react-router';
import shallowEqual from 'react-pure-render/shallowEqual';
import Immutable from 'immutable';

import APIUtils from '../../utils/APIUtils';
import PostActionCreators from '../../actions/PostActionCreators';
import PostStore from '../../stores/PostStore';
import SessionStore from '../../stores/SessionStore';

import pureRender from '../../utils/pureRenderDecorator';

import PostsList from './PostsList.react';
import ErrorNotice from '../shared/ErrorNotice.react';

@pureRender
export default class Posts extends React.Component {
  static propTypes = {
    category: React.PropTypes.string.isRequired
  }

  constructor(props) {
    super(props);
    this.state = {
      posts: PostStore.getPosts(this.props.category),
      errors: PostStore.getErrors(),
      loggedIn: SessionStore.isLoggedIn()
    }
  }

  componentDidMount() {
    PostStore.addChangeListener(this._onChange);
    PostActionCreators.loadPosts(this.props.category);
  }

  componentWillUnmount() {
    PostStore.removeChangeListener(this._onChange);
  }

  render() {
    const { errors, posts, loggedIn } = this.state;

    const errorNotice = (errors.length > 0) ?
      <ErrorNotice errors={errors} /> : null;

    return(
      <div>
        {errorNotice}
        <PostsList
          posts={posts}
          loggedIn={loggedIn}
          _onChange={this._onChange} />
      </div>
    );
  }

  _onChange = () => {
    this.setState({
      posts: PostStore.getPosts(this.props.category),
      errors: PostStore.getErrors()
    });
  }
}
