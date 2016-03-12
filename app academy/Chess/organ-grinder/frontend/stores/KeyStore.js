var Store = require('flux/utils').Store;
var KeysDispatcher = require('../dispatcher/Dispatcher');

var _keys = [];

var KeyStore = new Store(KeysDispatcher);
window.keystore = KeyStore;

KeyStore.__onDispatch = function(payload) {
  switch(payload.actionType){
    // TODO why use a constant for this?
    case "ADD_KEY":
      addKey(payload.key);
      break;
    case "REMOVE_KEY":
      removeKey(payload.key);
      break;
    case "SET_KEY":
      setKeys(payload.key);
    }
  };

function setKeys(keys){
  _keys = keys;
  KeyStore.__emitChange();
}

function addKey(key){
  if (_keys.indexOf(key) < 0) {
    _keys.push(key);
  }
  KeyStore.__emitChange();
}

function removeKey(key){
  _keys = _keys.filter(function(storedKey){
    return storedKey !== key;
  });
  KeyStore.__emitChange();
}

KeyStore.allKeys = function (){
  return _keys.slice();
};

module.exports = KeyStore;
