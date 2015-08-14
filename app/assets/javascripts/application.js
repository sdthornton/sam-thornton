// Use ES6
require('babel/register');

// Global require
require('./**/*', { mode: 'expand' });

// Global methods
window.Site.javascriptReady = true
