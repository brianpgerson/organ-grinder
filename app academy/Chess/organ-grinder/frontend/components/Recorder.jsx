var React = require('react');
var Track = require('../util/Track');
var KeyStore = require('../stores/KeyStore');
var TrackActions = require('../actions/TrackActions');

var Recorder = React.createClass({
  getInitialState: function() {
    var theTrack = new Track({name: "new hit!"});
    return {isRecording: false, track: theTrack};
  },
  componentDidMount: function() {
    KeyStore.addListener(this.handleNewNote);
  },
  handleNewNote: function() {
    //new stuff
    if (this.state.isRecording) {
      this.state.track.addNotes(KeyStore.allKeys());
    }
  },
  // NEW STUFF
  record: function(){
    this.setState({isRecording: true});
    this.state.track.startRecording();
  },
  stop: function(){
    this.setState({isRecording: false});
    this.state.track.stopRecording();
  },
  save: function() {
    TrackActions.addTrack(this.state.track);
  },
  changeName: function(e) {
    var newTrack = this.state.track;
    newTrack.name = e.target.value;
    this.setState({track: newTrack});
  },
  render: function(){
    return (
      <div>
        <button onClick={this.record}>Record!</button>
        <button onClick={this.stop}>Stop!</button>
        <button onClick={this.state.track.play.bind(this.state.track)}>Play!</button>
        <button onClick={this.save}>Save!</button>
        <input onChange={this.changeName} value={this.state.track.name} type='text' id='trackName'></input>
      </div>
    );
  }
});

module.exports = Recorder;
