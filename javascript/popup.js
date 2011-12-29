
var Popup = new function () {
    var characters = [
        {
            'sign': '–',
            'desc': 'pomlčka',
            'code': '2013'
        },
        {
            'sign': '—',
            'desc': 'dlouhá pomlčka',
            'code': '2014'
        },
        {
            'sign': '„',
            'desc': 'levá dolní uvozovka',
            'code': '201e'
        },
        {
            'sign': '”',
            'desc': 'pravá horní uvozovka',
            'code': '201d'
        },
        {
            'sign': '“',
            'desc': 'levá horní uvozovka',
            'code': '201c'
        }
    ];

    this.init = function () {
        insertListOfCharacters();
    };

    var insertListOfCharacters = function () {
        var i = 0,
            countOfCharacters = characters.length,
            frag = document.createDocumentFragment();

        for (; i < countOfCharacters; i++) {
            frag.appendChild(createElmCharacter(characters[i]));
        }

        document.getElementById('characters').appendChild(frag);
    };

    var createElmCharacter = function (character) {
        var characterParagraph = document.createElement('p');
        characterParagraph.setAttribute('class', 'character');
        characterParagraph.setAttribute('onclick', 'Popup.copyToClipboard("'+character.sign+'")');
        characterParagraph.appendChild(createElmCharacterSign(character.sign));
        characterParagraph.appendChild(createElmCharacterDesc(character.desc));
        characterParagraph.appendChild(createElmCharacterCode(character.code));
        return characterParagraph;
    };

    var createElmCharacterSign = function (sign) {
        var characterSign = document.createElement('span');
        characterSign.setAttribute('class', 'character-sign');
        characterSign.innerHTML = sign;
        return characterSign;
    };

    var createElmCharacterDesc = function (desc) {
        var characterDesc = document.createElement('span');
        characterDesc.setAttribute('class', 'character-desc');
        characterDesc.innerHTML = desc;
        return characterDesc;
    };

    var createElmCharacterCode = function (code) {
        var characterCode = document.createElement('span');
        characterCode.setAttribute('class', 'character-code');
        characterCode.innerHTML = code;
        return characterCode;
    };

    this.copyToClipboard = function (text) {
        var clipboardTextarea = createClipboardTextarea(text);
        document.body.appendChild(clipboardTextarea);
        clipboardTextarea.select();
        document.execCommand('copy');
        document.body.removeChild(clipboardTextarea);
        window.close();
    };

    var createClipboardTextarea = function (text) {
        var clipboardTextarea = document.createElement('textarea');
        clipboardTextarea.style.position = "absolute";
        clipboardTextarea.style.left = "-100%";
        clipboardTextarea.value = text;
        return clipboardTextarea;
    };
}

