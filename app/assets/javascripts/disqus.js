let namespace = require('./namespace');

namespace('Site', () =>
  class Disqus {
    constructor(identifier, url) {
      this.identifier = identifier;
      this.url = url;
      this.comments = document.getElementById('disqus_thread');
      this.disqusLoaded = false;
      this.disqusShortname = 'samthornton'
      this.initDisqus();
    }

    createEmbedScript() {
      dsq = document.createElement('script');
      dsq.type = 'text/javascript';
      dsq.async = true;
      dsq.src = `//${this.disqusShortname}.disqus.com/embed.js`;
      this.dsq = dsq;
    }

    resetDisqus() {
      const disqusClass = this;
      DISQUS.reset({
        reload: true,
        config: function() {
          this.page.identifier = disqusClass.identifier,
          this.page.url = disqusClass.url
        }
      });
    }

    loadDisqus() {
      if (window.DISQUS) {
        this.resetDisqus();
      } else {
        this.createEmbedScript();
        document.head.appendChild(this.dsq);
      }
      this.disqusLoaded = true;
    }

    tryBookmarkLoad() {
      if (window.location.hash.indexOf('#comments') >= 0) {
        this.loadDisqus();
      }
    }

    initDisqus() {
      this.tryBookmarkLoad();

      if (this.comments) {
        if (!this.disqusLoaded && window.pageYOffset > this.comments.getBoundingClientRect().top + document.body.scrollTop - 1000) {
          this.loadDisqus();
        }

        window.addEventListener('scroll', () => {
          if (!this.disqusLoaded && window.pageYOffset > this.comments.getBoundingClientRect().top + document.body.scrollTop - 1000) {
            this.loadDisqus();
          }
        }, false);
      }
    }
  });
