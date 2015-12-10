import React from 'react';
import Immutable from 'immutable';

import PostsItem from './PostsItem.react';

export default class PostsList extends React.Component {
  static propTypes = {
    posts: React.PropTypes.instanceOf(Immutable.OrderedMap).isRequired,
    loggedIn: React.PropTypes.bool,
    _onChange: React.PropTypes.func.isRequired
  }

  render() {
    const { props } = this;

    return(
      <ul>
        {props.posts.valueSeq().map(function(post, index) {
          return <PostsItem
                   post={post}
                   key={`post-${index}`}
                   loggedIn={props.loggedIn}
                   _onChange={props._onChange} />
        })}
      </ul>
    );
  }
}
