import React from 'react';

export default class PostForm extends React.Component {
  static propTypes = {
    post: React.PropTypes.object.isRequired,
    submit_text: React.PropTypes.string.isRequired,
    _onSubmit: React.PropTypes.func.isRequired,
    _updatePost: React.PropTypes.func.isRequired
  }

  render() {
    const {
      post,
      submit_text,
      _onSubmit,
      _updatePost } = this.props;
    const { title, body, category } = post;

    return (
      <form onSubmit={_onSubmit}>
        <input type="text" id="title" ref="title" value={title} onChange={_updatePost} />
        <textarea id="body" ref="body" value={body} onChange={_updatePost} />
        <label>
          <input type="radio" name="category" value="faith"
            checked={category === 'faith'}
            onChange={_updatePost} />
          Faith
        </label>
        <label>
          <input type="radio" name="category" value="tech"
            checked={category === 'tech'}
            onChange={_updatePost} />
          Tech
        </label>
        <button type="submit">{submit_text}</button>
      </form>
    );
  }
}
