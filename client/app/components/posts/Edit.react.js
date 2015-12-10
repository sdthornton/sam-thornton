import React from 'react';
import update from 'react-addons-update';

import PostActionCreators from '../../actions/PostActionCreators';
import PostStore from '../../stores/PostStore';

import PostForm from './PostForm.react';
import PostItem from './PostItem.react';
import ErrorNotice from '../shared/ErrorNotice.react';

export default class EditPost extends React.Component {
  static propTypes = {
    params: React.PropTypes.object.isRequired
  };

  constructor() {
    super();
    this.state = {
      post: PostStore.getPost(),
      errors: {}
    }
  }

  componentDidMount() {
    PostStore.addChangeListener(this._onChange);
    PostActionCreators.loadPost(this.props.params.id);
  }

  componentWillUnmount() {
    PostStore.removeChangeListener(this._onChange);
  }

  render() {
    const { post, errors } = this.state;

    const errorNotice = (Object.keys(errors).length) ?
      <ErrorNotice errors={errors}/> : <div></div>;

    return(
      <section>
        {errorNotice}
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
      post: PostStore.getPost(),
      errors: PostStore.getErrors()
    });
  }

  _onSubmit = (e) => {
    e.preventDefault()
    const { id } = this.props.params;
    const { post } = this.state;
    PostActionCreators.updatePost(id, post);
  }
}
