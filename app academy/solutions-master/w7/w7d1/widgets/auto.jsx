var React = require('react');

var AutoComplete = React.createClass({
  getInitialState: function () {
    return { inputVal: "" };
  },

  handleInput: function (event) {
    this.setState({ inputVal: event.currentTarget.value });
  },

  matches: function () {
    var matches = [];
    if(this.state.inputVal.length === 0){
      return this.props.names;
    }

    this.props.names.forEach(function (name) {
      var sub = name.slice(0, this.state.inputVal.length);
      if(sub.toLowerCase() === this.state.inputVal.toLowerCase()){
        matches.push(name);
      }
    }.bind(this));

    if (matches.length === 0) {
      matches.push("No matches");
    }

    return matches;
  },

  selectName: function (event) {
    var name = event.currentTarget.innerText;
    this.setState({ inputVal: name });
  },

  render: function () {
    var results = this.matches();
    return(
      <div>
        <input onChange={this.handleInput} value={this.state.inputVal} />
        <ul>
          {
            results.map(function (result, i) {
              return <li key={i} onClick={this.selectName}>{result}</li>
            }.bind(this))
          }
        </ul>
      </div>
    );
  }
});

module.exports = AutoComplete;