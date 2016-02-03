var React = require('react');
var PokemonStore = require('../../stores/pokemon.js');
var ApiUtil = require('../../util/apiUtil.js');
var ToysIndex = require('../toys/index.jsx');

module.exports = React.createClass({
  getStateFromStore: function () {
    return { pokemon: PokemonStore.find(parseInt(this.props.params.pokemonId)) };
  },

  _onChange: function () {
    this.setState(this.getStateFromStore());
  },

  getInitialState: function () {
    return this.getStateFromStore();
  },

  componentWillReceiveProps: function (newProps) {
    ApiUtil.fetchSinglePokemon(parseInt(newProps.params.pokemonId));
  },

  componentDidMount: function () {
    this.pokemonListener = PokemonStore.addListener(this._onChange);
    ApiUtil.fetchSinglePokemon(parseInt(this.props.params.pokemonId));
  },

  componentWillUnmount: function () {
    this.pokemonListener.remove();
  },

  render: function () {
    if(this.state.pokemon === undefined) { return <div></div>; }

    return(
      <div>
        <div className="pokemon-detail-pane">
          <div className="detail">
            <img src={this.state.pokemon.image_url} />
            {['name', 'attack', 'defense', 'poke_type', 'moves'].map(function (attr) {
              return <p key={attr}>{attr}: {this.state.pokemon[attr]}</p>;
            }.bind(this))}
          </div>

          <h2>Toys: </h2>
          <ToysIndex toys={this.state.pokemon.toys} />
        </div>

        {this.props.children}

      </div>
    );
  }
});
