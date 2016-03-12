var Store = require('flux/utils').Store;
var KeysDispatcher = require('../dispatcher/Dispatcher');

var _tracks = [];

var TrackStore = new Store(KeysDispatcher);

TrackStore.__onDispatch = function(payload) {
  switch(payload.actionType) {
    case "ADD_TRACK":
      _tracks.push(payload.track);
      this.__emitChange();
      break;
    case "DELETE_TRACK":
      removeTrack(payload.track);

      break;
  }
};

function removeTrack(track){
  _tracks = _tracks.filter(function(storedTrack){
    return storedTrack !== track;
  });
  TrackStore.__emitChange();
}

TrackStore.allTracks = function (){
  return _tracks.slice();
};

module.exports = TrackStore;
