var React = require('react');
var TrackPlayer = require('./TrackPlayer');
var TrackStore = require('../stores/TrackStore');

var Jukebox = React.createClass({
  getInitialState: function() {
    return {tracks: []};
  },

  componentDidMount: function() {
    TrackStore.addListener(this.handleNewTrack);
  },
  handleNewTrack: function() {
    this.setState({tracks: TrackStore.allTracks()});
  },
  render: function() {
    var tracks = this.state.tracks.map(function(thisTrack, index) {
      return (<TrackPlayer key={index} track={thisTrack} />);
    });
    return (
      <div className="jukebox">
        {tracks}
      </div>
    );
  }
});

module.exports = Jukebox;
