
ContextMenu = new ->
    linkMenuIdWithCharacter = {}

    @updateCharacterContextMenu = ->
        chrome.contextMenus.removeAll(this.createCharacterContextMenu)

    @createCharacterContextMenu = ->
        for character in Characters.getCharacters()
            createCharacterContextMenuItem(character)

    createCharacterContextMenuItem = (character) ->
        id = chrome.contextMenus.create(getPropertiesOfCharacter(character))
        linkMenuIdWithCharacter[id] = character

    getPropertiesOfCharacter = (character) ->
        {
            title: chrome.i18n.getMessage('contextMenuInsert') + ' ' + character.sign + ' (' + character.desc + ')'
            contexts: ['editable']
            onclick: onClick
        }

    onClick = (info, tab) ->
        character = linkMenuIdWithCharacter[info.menuItemId]
        Characters.insertCharacterToActiveElement(tab.id, character)

    return

