import SessionStore from '../stores/SessionStore';

import App from '../components/App.react';
import Home from '../components/Home.react';
import About from '../components/About.react';
import Contact from '../components/Contact.react';
import Faith from '../components/Faith.react';
import Tech from '../components/Tech.react';
import ShowPost from '../components/posts/Show.react';
import NewPost from '../components/posts/New.react';
import EditPost from '../components/posts/Edit.react';
import Login from '../components/session/Login.react';
import Logout from '../components/session/Logout.react';
import NoMatch from '../components/NoMatch.react';

function redirectToLogin(nextState, replaceState) {
  if (!SessionStore.isLoggedIn()) {
    replaceState({
      nextState: nextState.location.pathname
    }, '/login');
  }
}

function redirectToDashboard(nextState, replaceState) {
  if (SessionStore.isLoggedIn()) {
    replaceState(null, '/');
  }
}

export default {
  component: App,
  childRoutes: [
    {
      path: '/',
      getComponent: (location, cb) => {
        cb(null, Home);
      }
    },
    {
      path: '/about',
      getComponent: (location, cb) => {
        cb(null, About);
      }
    },
    {
      path: '/faith',
      getComponent: (location, cb) => {
        cb(null, Faith);
      }
    },
    {
      path: '/tech',
      getComponent: (location, cb) => {
        cb(null, Tech);
      }
    },
    {
      path: '/contact',
      getComponent: (location, cb) => {
        cb(null, Contact);
      }
    },
    {
      path: '/logout',
      getComponent: (location, cb) => {
        cb(null, Logout);
      }
    },
    {
      onEnter: redirectToDashboard,
      childRoutes: [
        {
          path: '/login',
          getComponent: (location, cb) => {
            cb(null, Login);
          }
        }
      ]
    },
    {
      onEnter: redirectToLogin,
      childRoutes: [
        {
          path: '/posts/new',
          getComponent: (location, cb) => {
            cb(null, NewPost);
          }
        },
        {
          path: '/posts/:id/edit',
          getComponent: (location, cb) => {
            cb(null, EditPost);
          }
        }
      ]
    },
    {
      path: '/posts/:url',
      getComponent: (location, cb) => {
        cb(null, ShowPost);
      }
    },
    {
      path: '*',
      getComponent: (location, cb) => {
        cb(null, NoMatch);
      }
    }
  ]
}
