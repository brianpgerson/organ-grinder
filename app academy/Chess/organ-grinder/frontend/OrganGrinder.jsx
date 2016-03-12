var KeyStore = require('./stores/KeyStore.js');
var TrackStore = require('./stores/TrackStore.js');
var Note = require('./util/Note');
var TONES = require('./constants/Tones');
var KeyListener = require('./util/KeyListener');
var React = require('react');
var ReactDOM = require('react-dom');
var Organ = require('./components/Organ');

$(function(){
  ReactDOM.render(
    <Organ />,
    document.getElementById('content')
  );
});
