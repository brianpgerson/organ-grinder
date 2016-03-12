var KeyActions = require('../actions/KeyActions');

function Track(attrHash){
  this.name = attrHash.name;
  this.roll = attrHash.roll || [];
}

Track.prototype.startRecording = function () {
  this.roll = [];
  this.currentTime = Date.now();
};

Track.prototype.addNotes = function(notesPlayed) {

  var timeDiff = Date.now() - this.currentTime;
  this.roll.push({timeSlice: timeDiff, notes: notesPlayed});
};

Track.prototype.stopRecording = function() {
  this.addNotes([]);
};

Track.prototype.play = function () {
  if (this.interval) { return; }
  var playBackStartTime = Date.now();
  var currentNote = 0;

  this.interval = setInterval(function(){
    if (currentNote < this.roll.length) {
      KeyActions.setKeys(this.roll[currentNote].notes);
      if (Date.now() - playBackStartTime > this.roll[currentNote].timeSlice) {
        currentNote++;
      }
    }
    else {
      clearInterval(this.interval);
      this.interval = null;
    }
  }.bind(this), 1);
};
module.exports = Track;
