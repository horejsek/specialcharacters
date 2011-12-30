
var linkMenuIdWithCharacterSign = {}

function createCharacterContextMenu() {
    var i = 0,
        countOfCharacters = characters.length;

    for (; i < countOfCharacters; i++) {
        createCharacterContextMenuItem(characters[i]);
    }
}

function createCharacterContextMenuItem(character) {
    var id = chrome.contextMenus.create({
        "title": character.desc + ' (' + character.sign + ')',
        "contexts": ['editable'],
        "onclick": onClick
    });
    linkMenuIdWithCharacterSign[id] = character.sign;
}

function onClick(info, tab) {
    chrome.tabs.sendRequest(tab.id, {action: "appendTextToActiveElement", text: linkMenuIdWithCharacterSign[info.menuItemId]});
}

createCharacterContextMenu();
