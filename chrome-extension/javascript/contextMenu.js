
var ContextMenu = new function () {
    var linkMenuIdWithCharacter = {}

    this.updateCharacterContextMenu = function() {
        chrome.contextMenus.removeAll(this.createCharacterContextMenu);
    }

    this.createCharacterContextMenu = function() {
        var i = 0,
            characters = Characters.getCharacters(),
            countOfCharacters = characters.length;

        for (; i < countOfCharacters; i++) {
            createCharacterContextMenuItem(characters[i]);
        }
    }

    function createCharacterContextMenuItem(character) {
        var id = chrome.contextMenus.create(getPropertiesOfCharacter(character));
        linkMenuIdWithCharacter[id] = character;
    }

    function getPropertiesOfCharacter(character) {
        return {
            'title': chrome.i18n.getMessage('contextMenuInsert') + ' ' + character.sign + ' (' + character.desc + ')',
            'contexts': ['editable'],
            'onclick': onClick
        };
    }

    function onClick(info, tab) {
        var character = linkMenuIdWithCharacter[info.menuItemId];
        Characters.insertCharacterToActiveElement(tab.id, character);
    }
};
