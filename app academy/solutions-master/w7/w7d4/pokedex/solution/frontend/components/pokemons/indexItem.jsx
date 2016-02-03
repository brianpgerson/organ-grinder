var React = require('react');
var History = require('react-router').History;

module.exports = React.createClass({
  mixins: [History],

  showDetail: function () {
    this.history.pushState(null, '/pokemon/' + this.props.pokemon.id, {});
  },

  render: function () {
    return(
      <li onClick={this.showDetail} className="poke-list-item">
        <p>Name: {this.props.pokemon.name}</p>
        <p>Poke Type: {this.props.pokemon.poke_type}</p>
      </li>
    );
  }
});
