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
  var characters, defaultCharacters, getLocale;
  characters = [];
  defaultCharacters = {
    cs: [new Character('–', 'pomlčka'), new Character('—', 'dlouhá pomlčka'), new Character('„“', 'uvozovky'), new Character('…', 'výpustka')],
    en: [new Character('–', 'dash'), new Character('—', 'long dash'), new Character('“”', 'quotation marks'), new Character('…', 'ellipsis')]
  };
  this.getCharacters = function() {
    return characters.slice();
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
    return this.save(defaultCharacters[getLocale()]);
  };
  this.save = function(charactersToSave) {
    var character, x, _len;
    if (charactersToSave === null) charactersToSave = characters;
    localStorage['countOfCharacters'] = charactersToSave.length;
    for (x = 0, _len = charactersToSave.length; x < _len; x++) {
      character = charactersToSave[x];
      localStorage['character.sign[' + x + ']'] = character.sign;
      localStorage['character.desc[' + x + ']'] = character.desc;
    }
    return this.restore();
  };
  getLocale = function() {
    if (localStorage['locale'] === void 0) {
      localStorage['locale'] = getLocaleFromNavigator();
    }
    return localStorage['locale'];
  };
  this.restore();
};
