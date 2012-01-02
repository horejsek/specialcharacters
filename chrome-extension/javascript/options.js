
var Options = new function () {
    this.init = function () {
        insertListOfCharacters();
    };

    function insertListOfCharacters() {
        var i = 0,
            characters = Characters.getCharacters(),
            countOfCharacters = characters.length,
            frag = document.createDocumentFragment();

        for (; i < countOfCharacters; i++) {
            frag.appendChild(createElmCharacter(characters[i], i));
        }

        charactersElm = document.getElementById('characters');
        charactersElm.innerHTML = '';
        charactersElm.appendChild(frag);
    }

    function createElmCharacter(character, index) {
        var characterRow = document.createElement('tr');
        characterRow.appendChild(createCharacterCellSign(character.sign, index));
        characterRow.appendChild(createCharacterCellDesc(character.desc, index));
        return characterRow;
    }

    function createCharacterCellSign(sign, index) {
        var characterCellSign = document.createElement('td');
        characterCellSign.innerHTML = 'Znak:';

        var input = document.createElement('input');
        input.setAttribute('onchange', 'Options.showSavePendings()');
        input.setAttribute('class', 'character-sign');
        input.setAttribute('id', 'character-sign-' + index);
        input.type = 'text';
        input.value = sign;
        characterCellSign.appendChild(input);

        return characterCellSign;
    }

    function createCharacterCellDesc(desc, index) {
        var characterCellDesc = document.createElement('td');
        characterCellDesc.innerHTML = 'Popis:';

        var input = document.createElement('input');
        input.setAttribute('onchange', 'Options.showSavePendings()');
        input.setAttribute('id', 'character-desc-' + index);
        input.type = 'text';
        input.value = desc;
        characterCellDesc.appendChild(input);

        return characterCellDesc;
    }

    this.save = function () {
        var i = 0,
            characters = Characters.getCharacters(),
            countOfCharacters = characters.length;

        var newCharacters = [];

        for (; i < countOfCharacters; i++) {
            var sign = document.getElementById('character-sign-'+i).value,
                desc = document.getElementById('character-desc-'+i).value;
            newCharacters.push(new Character(sign, desc));
        }

        Characters.save(newCharacters);
        this.hideSavePendings();
    };

    this.saveDefault = function () {
        Characters.saveDefault();
        insertListOfCharacters();
    };

    this.showSavePendings = function () {
        document.getElementById('savePendings').style.display = 'block';
    };

    this.hideSavePendings = function () {
        document.getElementById('savePendings').style.display = 'none';
    };
}
