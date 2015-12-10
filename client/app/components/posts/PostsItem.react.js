import React from 'react';
import { Link } from 'react-router';
import moment from 'moment';

import PostStore from '../../stores/PostStore';

export default class PostsItem extends React.Component {
  static propTypes = {
    post: React.PropTypes.object.isRequired,
    loggedIn: React.PropTypes.bool,
    _onChange: React.PropTypes.func.isRequired
  }

  render() {
    const { url, title, abstract, created_at, id } = this.props.post;

    const editLink = this.props.loggedIn ?
      <Link to={`/posts/${id}/edit`}>Edit</Link> : null;

    return(
      <li>
        <Link to={`/posts/${url}`} onClick={this._onClick}>
          {title}
        </Link>
        <div>{abstract}...</div>
        <span> - {moment(created_at).fromNow()}</span>
        {editLink}
      </li>
    );
  }

  _onClick = (e) => {
    PostStore.removeChangeListener(this.props._onChange);
    PostStore.setPost(this.props.post);
  }
}
