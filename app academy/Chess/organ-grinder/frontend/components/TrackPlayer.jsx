var React = require('react');
var TrackActions = require('../actions/TrackActions');

var TrackPlayer = React.createClass({
  play: function(){
    this.props.track.play();
  },
  delete: function() {
    TrackActions.deleteTrack(this.props.track);
  },
  render: function(){
    return(
      <div>
        <span className = 'track'>{this.props.track.name}</span>
        <button onClick={this.play}>Play</button>
        <button onClick={this.delete}>Delete</button>
      </div>
    );
  }
});

module.exports = TrackPlayer;
