import marked from 'marked';

import '../stylesheets/code.css';

marked.setOptions({
  highlight: function(code, lang) {
    return require('highlight.js').highlightAuto(code).value;
  }
});

export default function markItUp(text) {
  return marked(text, { sanitize: true });
}
