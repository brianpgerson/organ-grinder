var React = require('react');
var Key = require('./key');
var TONES = require('../constants/Tones');
var Recorder = require('./Recorder');
var Jukebox = require('./Jukebox');

var Organ = React.createClass({
  render: function() {
    var keyboard = Object.keys(TONES).map(function(tone, index) {
      return (<Key key={index} noteName = {tone} />);
    });

    return (
      <div className="organ group">
        <div>{keyboard}</div>
        <Recorder />
        <Jukebox />
      </div>
    );
  }
});


module.exports = Organ;
