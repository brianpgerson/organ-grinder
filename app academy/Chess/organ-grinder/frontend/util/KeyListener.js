var KeyActions = require('../actions/KeyActions');

var Mapping = {
  49 : "C4",
  50 : "Db4",
  51 : "D4",
  52 : "Eb4",
  53 : "E4",
  54 : "F4",
  55 : "Gb4",
  56 : "G4",
  57 : "Ab4",
  48 : "A4",
  189 : "Bb4",
  187 : "B4"
};

$(function() {
  $(document).on("keydown", function(e) {
    var key = Mapping[e.keyCode.toString()];
    KeyActions.addKey(key);
  });

  $(document).on("keyup", function(e) {
    var key = Mapping[e.keyCode.toString()];
    KeyActions.removeKey(key);
  });
});
