var ApiActions = require('../actions/pokemonActions.js');
module.exports = {
  fetchAllPokemons: function () {
    $.ajax({
      url: "api/pokemon",
      success: function (pokemons) {
        ApiActions.receiveAllPokemons(pokemons);
      }
    })
  },

  fetchSinglePokemon: function (id) {
    $.ajax({
      url: "api/pokemon/" + id,
      success: function (pokemon) {
        ApiActions.receiveSinglePokemon(pokemon);
      }
    })
  },

  createPokemon: function (pokemon, callback) {
    $.ajax({
      url: "api/pokemon",
      method: "POST",
      data: {pokemon: pokemon},
      success: function (pokemon) {
        ApiActions.receiveSinglePokemon(pokemon);
        callback && callback(pokemon.id);
      }
    })
  }
}

