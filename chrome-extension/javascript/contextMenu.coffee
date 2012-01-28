
goog.provide('sch.ContextMenu');



sch.ContextMenu = ->
    self = this

    linkMenuIdWithCharacter = {}
    characters = new sch.Characters()

    @createCharacterContextMenu = ->
        characters.refresh()
        linkMenuIdWithCharacter = {}
        for character in characters.getCharacters()
            createCharacterContextMenuItem(character)

    createCharacterContextMenuItem = (character) ->
        id = chrome.contextMenus.create(self.getPropertiesOfCharacter(character, onClick))
        linkMenuIdWithCharacter[id] = character

    onClick = (info, tab) ->
        character = linkMenuIdWithCharacter[info.menuItemId]
        characters.insertCharacterToActiveElement(tab.id, character)

    return



goog.scope ->
    sch.ContextMenu::updateCharacterContextMenu = ->
        chrome.contextMenus.removeAll(@createCharacterContextMenu)

    sch.ContextMenu::getPropertiesOfCharacter = (character, onclickCallback) ->
        {
            title: chrome.i18n.getMessage('contextMenuInsert') + ' ' + character.sign + ' (' + character.desc + ')'
            contexts: ['editable']
            onclick: onclickCallback
        }

    return
