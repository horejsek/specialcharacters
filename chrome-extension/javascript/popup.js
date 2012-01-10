
var Popup = new function () {
    this.init = function () {
        insertListOfCharacters();
    };

    function insertListOfCharacters() {
        var i = 0,
            characters = Characters.getCharacters(),
            countOfCharacters = characters.length,
            frag = document.createDocumentFragment();

        for (; i < countOfCharacters; i++) {
            frag.appendChild(createElmCharacter(characters[i]));
        }

        document.getElementById('characters').appendChild(frag);
    }

    function createElmCharacter(character) {
        var characterParagraph = document.createElement('p');
        characterParagraph.setAttribute('class', 'character');
        characterParagraph.setAttribute('onclick', 'Popup.copyToClipboard("'+character.sign+'")');
        characterParagraph.appendChild(createElmCharacterSign(character.sign));
        characterParagraph.appendChild(createElmCharacterDesc(character.desc));
        return characterParagraph;
    }

    function createElmCharacterSign(sign) {
        var characterSign = document.createElement('span');
        characterSign.setAttribute('class', 'character-sign');
        characterSign.innerHTML = sign;
        return characterSign;
    }

    function createElmCharacterDesc(desc) {
        var characterDesc = document.createElement('span');
        characterDesc.setAttribute('class', 'character-desc');
        characterDesc.innerHTML = desc;
        return characterDesc;
    }

    this.copyToClipboard = function (text) {
        var clipboardTextarea = createClipboardTextarea(text);
        document.body.appendChild(clipboardTextarea);
        clipboardTextarea.select();
        document.execCommand('copy');
        document.body.removeChild(clipboardTextarea);
        window.close();
    };

    function createClipboardTextarea(text) {
        var clipboardTextarea = document.createElement('textarea');
        clipboardTextarea.style.position = "absolute";
        clipboardTextarea.style.left = "-100%";
        clipboardTextarea.value = text;
        return clipboardTextarea;
    }
}
