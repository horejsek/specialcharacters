
var Options = new function () {
    this.countOfCharacters = 0;

    this.init = function () {
        insertListOfCharacters();
    };

    function insertListOfCharacters() {
        var i = 0,
            characters = Characters.getCharacters(),
            frag = document.createDocumentFragment();

        Options.countOfCharacters = characters.length;

        for (; i < Options.countOfCharacters; i++) {
            frag.appendChild(createElmCharacter(characters[i], i));
        }

        charactersElm = document.getElementById('characters');
        charactersElm.innerHTML = '';
        charactersElm.appendChild(frag);
    }

    function createElmCharacter(character, index) {
        var characterRow = document.createElement('tr');
        characterRow.setAttribute('id', 'character-' + index)
        characterRow.appendChild(createCharacterCellSign(character.sign, index));
        characterRow.appendChild(createCharacterCellDesc(character.desc, index));
        characterRow.appendChild(createCharacterCellDelete(index));
        return characterRow;
    }

    function createCharacterCellSign(sign, index) {
        var characterCellSign = document.createElement('td');
        characterCellSign.innerHTML = chrome.i18n.getMessage('optionGeneralCharacter');

        var input = document.createElement('input');
        input.setAttribute('onchange', 'Options.showSavePendings()');
        input.setAttribute('class', 'character-sign');
        input.setAttribute('id', 'character-sign-' + index);
        input.setAttribute('maxlength', 2);
        input.type = 'text';
        input.value = sign;
        characterCellSign.appendChild(input);

        return characterCellSign;
    }

    function createCharacterCellDesc(desc, index) {
        var characterCellDesc = document.createElement('td');
        characterCellDesc.innerHTML = chrome.i18n.getMessage('optionGeneralCharacterDescription');

        var input = document.createElement('input');
        input.setAttribute('onchange', 'Options.showSavePendings()');
        input.setAttribute('id', 'character-desc-' + index);
        input.type = 'text';
        input.value = desc;
        characterCellDesc.appendChild(input);

        return characterCellDesc;
    }

    function createCharacterCellDelete(index) {
        var cell = document.createElement('td');

        var deleteButton = document.createElement('button');
        deleteButton.setAttribute('onclick', 'Options.deleteCharacter(' + index + ')');
        deleteButton.innerHTML = chrome.i18n.getMessage('optionGeneralDeleteCharacterButton');

        cell.appendChild(deleteButton);
        return cell;
    }

    this.save = function () {
        var index = 0,
            characters = Characters.getCharacters();

        var newCharacters = [];

        do {
            var sign = document.getElementById('character-sign-'+index),
                desc = document.getElementById('character-desc-'+index);

            if (sign !== undefined && sign !== null) {
                newCharacters.push(new Character(sign.value, desc.value));
                if (newCharacters.length == Options.countOfCharacters) {
                    break;
                }
            }
            index++;
        } while(true);

        Characters.save(newCharacters);
        this.hideSavePendings();
        ContextMenu.updateCharacterContextMenu();
    };

    this.saveDefault = function () {
        Characters.saveDefault();
        insertListOfCharacters();
        ContextMenu.updateCharacterContextMenu();
    };

    this.showSavePendings = function () {
        document.getElementById('savePendings').style.display = 'block';
    };

    this.hideSavePendings = function () {
        document.getElementById('savePendings').style.display = 'none';
    };

    this.addCharacter = function () {
        newCharacterElm = createElmCharacter(new Character(), Options.countOfCharacters);
        Options.countOfCharacters++;

        charactersElm = document.getElementById('characters');
        charactersElm.appendChild(newCharacterElm);
        this.showSavePendings();
    };

    this.deleteCharacter = function (index) {
        var characters = document.getElementById('characters'),
            characterElm = document.getElementById('character-' + index);

        Options.countOfCharacters--;

        characters.removeChild(characterElm);
        this.showSavePendings();
    }
}
