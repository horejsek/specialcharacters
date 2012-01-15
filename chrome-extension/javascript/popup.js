var Popup;

Popup = new function() {
  var createClipboardTextarea, createElmCharacter, createElmCharacterDesc, createElmCharacterSign, insertListOfCharacters;
  this.init = function() {
    return insertListOfCharacters();
  };
  insertListOfCharacters = function() {
    var character, frag, _i, _len, _ref;
    frag = document.createDocumentFragment();
    _ref = Characters.getCharacters();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      character = _ref[_i];
      frag.appendChild(createElmCharacter(character));
    }
    return document.getElementById('characters').appendChild(frag);
  };
  createElmCharacter = function(character) {
    var elm;
    elm = document.createElement('p');
    elm.setAttribute('class', 'character');
    elm.setAttribute('onclick', 'Popup.copyToClipboard("' + character.sign + '")');
    elm.appendChild(createElmCharacterSign(character.sign));
    elm.appendChild(createElmCharacterDesc(character.desc));
    return elm;
  };
  createElmCharacterSign = function(sign) {
    var elm;
    elm = document.createElement('span');
    elm.setAttribute('class', 'character-sign');
    elm.innerHTML = sign;
    return elm;
  };
  createElmCharacterDesc = function(desc) {
    var elm;
    elm = document.createElement('span');
    elm.setAttribute('class', 'character-desc');
    elm.innerHTML = desc;
    return elm;
  };
  this.copyToClipboard = function(text) {
    var clipboardTextarea;
    clipboardTextarea = createClipboardTextarea(text);
    document.body.appendChild(clipboardTextarea);
    clipboardTextarea.select();
    document.execCommand('copy');
    document.body.removeChild(clipboardTextarea);
    return window.close();
  };
  createClipboardTextarea = function(text) {
    var elm;
    elm = document.createElement('textarea');
    elm.style.position = 'absolute';
    elm.style.left = '-100%';
    elm.value = text;
    return elm;
  };
};
