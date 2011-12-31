
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
            frag.appendChild(createElmCharacter(characters[i]));
        }

        document.getElementById('characters').appendChild(frag);
    }

    function createElmCharacter(character) {
        var characterRow = document.createElement('tr');
        characterRow.appendChild(createCharacterCellSign(character.sign));
        characterRow.appendChild(createCharacterCellDesc(character.desc));
        return characterRow;
    }

    function createCharacterCellSign(sign) {
        var characterCellSign = document.createElement('td');
        characterCellSign.innerHTML = 'Znak:';

        var input = document.createElement('input');
        input.type = 'text';
        input.value = sign;
        characterCellSign.appendChild(input);

        return characterCellSign;
    }

    function createCharacterCellDesc(desc) {
        var characterCellDesc = document.createElement('td');
        characterCellDesc.innerHTML = 'Popis:';

        var input = document.createElement('input');
        input.type = 'text';
        input.value = desc;
        characterCellDesc.appendChild(input);

        return characterCellDesc;
    }
}
