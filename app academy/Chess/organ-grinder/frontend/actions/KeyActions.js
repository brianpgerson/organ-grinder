var KeysDispatcher = require('../dispatcher/Dispatcher');

var KeyActions = {
  addKey: function(key) {
    KeysDispatcher.dispatch({
      actionType: "ADD_KEY",
      key: key
    });
  },
  setKeys: function(keys) {
    KeysDispatcher.dispatch({
      actionType: "SET_KEY",
      key: keys
    });
  },
  removeKey: function(key) {
    KeysDispatcher.dispatch({
      actionType: 'REMOVE_KEY',
      key: key
    });
  }
};
module.exports = KeyActions;
