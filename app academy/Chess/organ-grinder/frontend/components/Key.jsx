var React = require('react');
var Note = require('../util/Note');
var TONES = require('../constants/Tones');
var KeyStore = require('../stores/KeyStore');

var Key = React.createClass({
  getInitialState: function() {
    return({played: false});
  },
  componentDidMount: function() {
    this.note = new Note(TONES[this.props.noteName]);
    KeyStore.addListener(this.handlePlayNote);
  },
  componentWillUnmount: function() {
    KeyStore.remove(this.handlePlayNote);
  },
  handlePlayNote: function(){
    if (KeyStore.allKeys().indexOf(this.props.noteName) >= 0) {
      this.note.start();
      this.setState({played: true});
      console.log("i'm playing " + this.props.noteName);
    }
    else {
      this.note.stop();
      this.setState({played: false});
    }
  },
  render: function(){
    var status = (this.state.played === true ?
      "key played" : "key");
    return (
      <span className={status}>
        {this.props.noteName}
      </span>
    );
  }
});

module.exports = Key;
