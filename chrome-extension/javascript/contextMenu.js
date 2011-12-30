
var linkMenuIdWithCharacter = {}

function createCharacterContextMenu() {
    var i = 0,
        characters = Characters.getCharacters(),
        countOfCharacters = characters.length;

    for (; i < countOfCharacters; i++) {
        createCharacterContextMenuItem(characters[i]);
    }
}

function createCharacterContextMenuItem(character) {
    var id = chrome.contextMenus.create({
        'title': 'Vložit: ' + character.sign + ' (' + character.desc + ')',
        'contexts': ['editable'],
        'onclick': onClick
    });
    linkMenuIdWithCharacter[id] = character;
}

function onClick(info, tab) {
    var character = linkMenuIdWithCharacter[info.menuItemId];
    Characters.insertCharacterToActiveElement(tab.id, character);
}

createCharacterContextMenu();
