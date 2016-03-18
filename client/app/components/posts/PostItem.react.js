import React from 'react';
import { Link } from 'react-router';
import moment from 'moment';

import markItUp from '../../utils/markItUp';

export default class PostItem extends React.Component {
  static propTypes = {
    post: React.PropTypes.object.isRequired
  }

  tagify(tag) {
    console.log(tag);
    return `#${tag}`;
  }

  render() {
    const { id, title, body, category, created_at, tag_list } = this.props.post;

    return(
      <article>
        <h1>{title}</h1>
        <strong>Posted under {category}</strong><br />
        <div>
          {tag_list.map(tag => {
            return <a href="#">{this.tagify(tag)}</a>
          })}
        </div>
        <em>Written {moment(created_at).fromNow()}</em><br /><br />
        <div dangerouslySetInnerHTML={{ __html: markItUp(body) }} />
      </article>
    );
  }
}
