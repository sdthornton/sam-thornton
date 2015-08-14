let namespace = require('./namespace');

namespace('Site', () =>
  class FontLoader {
    constructor(options = {}) {
      this.md5 = options.md5;
      this.font = options.font;
      this.key = options.key || 'fonts';

      this.preRender().postRender();
    }

    insertFont(value) {
      const style = document.createElement('style');
      style.innerHTML = value;
      document.head.appendChild(style);
    }

    preRender() {
      try {
        const cache = window.localStorage.getItem(this.key);
        if (cache) {
          this.cache = JSON.parse(cache);
          if (this.cache.md5 == this.md5) {
            this.insertFont(this.cache.value);
          } else {
            window.localStorage.removeItem(this.key);
            this.cache = null;
          }
        }
      } catch(error) {}
      return this;
    }

    postRender() {
      if (!this.cache) {
        window.addEventListener('load', () => {
          const request = new XMLHttpRequest();
          request.open('GET', `/assets/${this.font}.${this.format()}.json`, true);
          request.onload = () => {
            if (request.status === 200) {
              try {
                const response = JSON.parse(request.response);
                this.insertFont(response.value);
                window.localStorage.setItem(this.key, request.response);
              } catch(error) {}
            }
          };
          request.send();
        }, false);
      }
      return this;
    }

    format() {
      if (window.FontFace) {
        const fontFace = new FontFace('t', 'url(data:application/font-woff2,) format(woff2)', {});
        fontface.load().catch(() => {});
        if (fontface.status == 'loading') {
          return 'woff2';
        }
      }
      return 'woff';
    }
  });
