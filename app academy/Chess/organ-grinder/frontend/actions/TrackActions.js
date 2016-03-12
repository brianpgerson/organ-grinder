var KeysDispatcher = require('../dispatcher/Dispatcher');

var TrackActions = {
  addTrack: function(track) {
    KeysDispatcher.dispatch({
      actionType: "ADD_TRACK",
      track: track
    });
  },
  deleteTrack: function(track) {
    KeysDispatcher.dispatch({
      actionType: "DELETE_TRACK",
      track: track
    });
  }
};
module.exports = TrackActions;
