var Character, Characters;

Character = function(sign, desc) {
  if (sign == null) sign = '';
  if (desc == null) desc = '';
  return {
    sign: sign,
    desc: desc
  };
};

Characters = new function() {
  var characters, defaultCharacters;
  characters = [];
  defaultCharacters = [new Character('–', 'pomlčka'), new Character('—', 'dlouhá pomlčka'), new Character('„“', 'uvozovky'), new Character('…', 'výpustka')];
  this.getCharacters = function() {
    return characters;
  };
  this.insertCharacterToActiveElement = function(tabId, character) {
    return chrome.tabs.sendRequest(tabId, {
      action: 'insertTextToActiveElement',
      text: character.sign
    });
  };
  this.restore = function() {
    var desc, sign, x, _ref, _results;
    if (localStorage['countOfCharacters'] === void 0) this.saveDefault();
    characters = [];
    _results = [];
    for (x = 0, _ref = localStorage['countOfCharacters']; 0 <= _ref ? x < _ref : x > _ref; 0 <= _ref ? x++ : x--) {
      sign = localStorage['character.sign[' + x + ']'];
      desc = localStorage['character.desc[' + x + ']'];
      _results.push(characters.push(new Character(sign, desc)));
    }
    return _results;
  };
  this.saveDefault = function() {
    return this.save(defaultCharacters);
  };
  this.save = function(charactersToSave) {
    var character, x, _ref;
    if (charactersToSave === null) charactersToSave = characters;
    localStorage['countOfCharacters'] = charactersToSave.length;
    for (x = 0, _ref = charactersToSave.length; 0 <= _ref ? x < _ref : x > _ref; 0 <= _ref ? x++ : x--) {
      character = charactersToSave[x];
      localStorage['character.sign[' + x + ']'] = character.sign;
      localStorage['character.desc[' + x + ']'] = character.desc;
    }
    return this.restore();
  };
  this.restore();
};
