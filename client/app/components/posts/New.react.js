import React from 'react';
import marked from 'marked';

import PostActionCreators from '../../actions/PostActionCreators';
import PostStore from '../../stores/PostStore';

import PostForm from './PostForm.react';
import PostItem from './PostItem.react';
import ErrorNotice from '../shared/ErrorNotice.react';

export default class NewPost extends React.Component {
  constructor() {
    super();
    this.state = {
      errors: {},
      post: {
        title: "",
        body: "",
        category: ""
      }
    };
  }

  componentDidMount() {
    PostStore.addChangeListener(this._onChange);
  }

  componentWillUnmount() {
    PostStore.removeChangeListener(this._onChange);
  }

  render() {
    const { post, errors } = this.state;

    const errorNotice = (Object.keys(errors).length) ?
      <ErrorNotice errors={errors}/> : <div></div>;

    return (
      <section>
        <PostForm post={post}
          submit_text="Update"
          _onSubmit={this._onSubmit}
          _updatePost={this._updatePost} />
        <PostItem post={post} />
      </section>
    );
  }

  _updatePost = (e) => {
    const { value, id, name } = e.target;
    const post = this.state.post;
    !!id ? post[id] = value : post[name] = value;

    this.setState({
      post: post
    });
  }

  _onChange = () => {
    this.setState({
      errors: PostStore.getErrors()
    });
  }

  _onSubmit = (e) => {
    e.preventDefault();
    PostActionCreators.createPost(this.state.post);
  }
}
