var Options;

Options = new function() {
  var createCharacterCellDelete, createCharacterCellDesc, createCharacterCellSign, createElmCharacter, insertListOfCharacters, saveCharacters, saveLocale, setLocale;
  this.countOfCharacters = 0;
  this.init = function() {
    setLocale();
    return insertListOfCharacters();
  };
  setLocale = function() {
    var elm;
    elm = document.getElementById('locale');
    elm.value = localStorage['locale'];
    return elm.setAttribute('onchange', 'Options.showSavePendings()');
  };
  insertListOfCharacters = function() {
    var character, characters, charactersElm, frag, x, _len;
    characters = Characters.getCharacters();
    frag = document.createDocumentFragment();
    Options.countOfCharacters = characters.length;
    for (x = 0, _len = characters.length; x < _len; x++) {
      character = characters[x];
      frag.appendChild(createElmCharacter(character, x));
    }
    charactersElm = document.getElementById('characters');
    charactersElm.innerHTML = '';
    return charactersElm.appendChild(frag);
  };
  createElmCharacter = function(character, index) {
    var characterRow;
    characterRow = document.createElement('tr');
    characterRow.setAttribute('id', 'character-' + index);
    characterRow.appendChild(createCharacterCellSign(character.sign, index));
    characterRow.appendChild(createCharacterCellDesc(character.desc, index));
    characterRow.appendChild(createCharacterCellDelete(index));
    return characterRow;
  };
  createCharacterCellSign = function(sign, index) {
    var characterCellSign, input;
    characterCellSign = document.createElement('td');
    characterCellSign.innerHTML = chrome.i18n.getMessage('optionGeneralCharacter');
    input = document.createElement('input');
    input.setAttribute('onchange', 'Options.showSavePendings()');
    input.setAttribute('class', 'character-sign');
    input.setAttribute('id', 'character-sign-' + index);
    input.setAttribute('maxlength', 2);
    input.type = 'text';
    input.value = sign;
    characterCellSign.appendChild(input);
    return characterCellSign;
  };
  createCharacterCellDesc = function(desc, index) {
    var characterCellDesc, input;
    characterCellDesc = document.createElement('td');
    characterCellDesc.innerHTML = chrome.i18n.getMessage('optionGeneralCharacterDescription');
    input = document.createElement('input');
    input.setAttribute('onchange', 'Options.showSavePendings()');
    input.setAttribute('id', 'character-desc-' + index);
    input.type = 'text';
    input.value = desc;
    characterCellDesc.appendChild(input);
    return characterCellDesc;
  };
  createCharacterCellDelete = function(index) {
    var cell, deleteButton;
    cell = document.createElement('td');
    deleteButton = document.createElement('button');
    deleteButton.setAttribute('onclick', 'Options.deleteCharacter(' + index + ')');
    deleteButton.innerHTML = chrome.i18n.getMessage('optionGeneralDeleteCharacterButton');
    cell.appendChild(deleteButton);
    return cell;
  };
  this.save = function() {
    saveLocale();
    saveCharacters();
    ContextMenu.updateCharacterContextMenu();
    return this.hideSavePendings();
  };
  this.saveDefault = function() {
    saveLocale();
    Characters.saveDefault();
    ContextMenu.updateCharacterContextMenu();
    this.init();
    return this.hideSavePendings();
  };
  saveLocale = function() {
    return localStorage['locale'] = document.getElementById('locale').value;
  };
  saveCharacters = function() {
    var desc, index, newCharacters, sign;
    index = 0;
    newCharacters = [];
    while (true) {
      sign = document.getElementById('character-sign-' + index);
      desc = document.getElementById('character-desc-' + index);
      if (sign != null) {
        newCharacters.push(new Character(sign.value, desc.value));
        if (newCharacters.length === Options.countOfCharacters) break;
      }
      index++;
    }
    return Characters.save(newCharacters);
  };
  this.addCharacter = function() {
    var newCharacterElm;
    newCharacterElm = createElmCharacter(new Character(), Options.countOfCharacters++);
    document.getElementById('characters').appendChild(newCharacterElm);
    return this.showSavePendings();
  };
  this.deleteCharacter = function(index) {
    var characterElm;
    Options.countOfCharacters--;
    characterElm = document.getElementById('character-' + index);
    document.getElementById('characters').removeChild(characterElm);
    return this.showSavePendings();
  };
  this.showSavePendings = function() {
    return document.getElementById('savePendings').style.display = 'block';
  };
  this.hideSavePendings = function() {
    return document.getElementById('savePendings').style.display = 'none';
  };
};
