let namespace = require('./namespace');

namespace('Site', () =>
  class NoHoverOnScroll {
    constructor() {
      this.enableTimer = 0;
      this.bindScrolling();
    }

    bindScrolling() {
      window.addEventListener('scroll', () => this.toggleHoverClass(), false);
    }

    toggleHoverClass() {
      clearTimeout(this.enableTimer);
      this.removeHoverClass()
      this.enableTimer = setTimeout(this.addHoverClass, 250);
    }

    removeHoverClass() {
      document.documentElement.classList.remove('hover');
    }

    addHoverClass() {
      document.documentElement.classList.add('hover');
    }
  });
