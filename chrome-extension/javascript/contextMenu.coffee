
goog.provide('sch.ContextMenu');

sch.ContextMenu = ->
    linkMenuIdWithCharacter = {}
    characters = new sch.Characters()

    @updateCharacterContextMenu = ->
        chrome.contextMenus.removeAll(@createCharacterContextMenu)

    @createCharacterContextMenu = ->
        characters.refresh()
        for character in characters.getCharacters()
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
        characters.insertCharacterToActiveElement(tab.id, character)

    return
