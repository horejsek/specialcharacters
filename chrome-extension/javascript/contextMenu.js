var ContextMenu;

ContextMenu = new function() {
  var createCharacterContextMenuItem, getPropertiesOfCharacter, linkMenuIdWithCharacter, onClick;
  linkMenuIdWithCharacter = {};
  this.updateCharacterContextMenu = function() {
    return chrome.contextMenus.removeAll(this.createCharacterContextMenu);
  };
  this.createCharacterContextMenu = function() {
    var character, _i, _len, _ref, _results;
    _ref = Characters.getCharacters();
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      character = _ref[_i];
      _results.push(createCharacterContextMenuItem(character));
    }
    return _results;
  };
  createCharacterContextMenuItem = function(character) {
    var id;
    id = chrome.contextMenus.create(getPropertiesOfCharacter(character));
    return linkMenuIdWithCharacter[id] = character;
  };
  getPropertiesOfCharacter = function(character) {
    return {
      title: chrome.i18n.getMessage('contextMenuInsert') + ' ' + character.sign + ' (' + character.desc + ')',
      contexts: ['editable'],
      onclick: onClick
    };
  };
  onClick = function(info, tab) {
    var character;
    character = linkMenuIdWithCharacter[info.menuItemId];
    return Characters.insertCharacterToActiveElement(tab.id, character);
  };
};
