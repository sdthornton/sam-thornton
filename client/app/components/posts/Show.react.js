import React from 'react';
import { Link } from 'react-router';
import moment from 'moment';

import PostActionCreators from '../../actions/PostActionCreators';
import PostStore from '../../stores/PostStore';
import SessionStore from '../../stores/SessionStore';

import markItUp from '../../utils/markItUp';
import pureRender from '../../utils/pureRenderDecorator';

import PostItem from './PostItem.react';

@pureRender
export default class Post extends React.Component {
  static propTypes = {
    params: React.PropTypes.object.isRequired
  }

  constructor() {
    super();
    this.state = {
      post: PostStore.getPost(),
      errors: PostStore.getErrors(),
      loggedIn: SessionStore.isLoggedIn()
    }
  }

  componentDidMount() {
    PostStore.addChangeListener(this._onChange);
    PostActionCreators.loadPost(this.props.params.url);
  }

  componentWillUnmount() {
    PostStore.removeChangeListener(this._onChange);
  }

  render() {
    const { post, loggedIn } = this.state;

    const editLink = loggedIn ?
      <Link to={`/posts/${post.id}/edit`}>Edit</Link> : null;

    return(
      <section>
        {editLink}
        <PostItem post={post} />
      </section>
    );
  }

  _onChange = () => {
    this.setState({
      errors: PostStore.getErrors(),
      post: PostStore.getPost()
    });
  }
}
