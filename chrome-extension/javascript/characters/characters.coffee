
goog.provide('sch.Characters')

goog.require('sch.getLocaleFromNavigator')
goog.require('sch.Character')



sch.Characters = ->
    characters = []
    defaultCharacters =
        cs: [
            new sch.Character('–', 'pomlčka')
            new sch.Character('—', 'dlouhá pomlčka')
            new sch.Character('„“', 'uvozovky')
            new sch.Character('…', 'výpustka')
        ]
        en: [
            new sch.Character('–', 'dash')
            new sch.Character('—', 'long dash')
            new sch.Character('“”', 'quotation marks')
            new sch.Character('…', 'ellipsis')
        ]
        smiles: [
            new sch.Character('☺', chrome.i18n.getMessage('characterWhiteSmilingFace'))
            new sch.Character('☻', chrome.i18n.getMessage('characterBlackSmilingFace'))
            new sch.Character('☹', chrome.i18n.getMessage('characterFrowningFace'))
        ]
        cards: [
            new sch.Character('♠', chrome.i18n.getMessage('characterSpade'))
            new sch.Character('♣', chrome.i18n.getMessage('characterClub'))
            new sch.Character('♥', chrome.i18n.getMessage('characterHeart'))
            new sch.Character('♦', chrome.i18n.getMessage('characterDiamond'))
        ]
        arrows: [
            new sch.Character('←', chrome.i18n.getMessage('characterLeftwardsArrow'))
            new sch.Character('→', chrome.i18n.getMessage('characterRightwardsArrow'))
            new sch.Character('↑', chrome.i18n.getMessage('characterUpwardsArrow'))
            new sch.Character('↓', chrome.i18n.getMessage('characterDownwardsArrow'))
            new sch.Character('↔', chrome.i18n.getMessage('characterLeftRightArrow'))
            new sch.Character('↕', chrome.i18n.getMessage('characterUpDownArrow'))
            new sch.Character('↖', chrome.i18n.getMessage('characterNorthWestArrow'))
            new sch.Character('↗', chrome.i18n.getMessage('characterNorthEastArrow'))
            new sch.Character('↘', chrome.i18n.getMessage('characterSouthEastArrow'))
            new sch.Character('↙', chrome.i18n.getMessage('characterSouthWestArrow'))
        ]

    @getCharacters = ->
        characters.slice()

    @restore = ->
        if localStorage['countOfCharacters'] is undefined or localStorage['countOfCharacters'] is null
            @saveDefault()

        characters = []
        for x in [0...localStorage['countOfCharacters']]
            sign = localStorage['character.sign['+x+']']
            desc = localStorage['character.desc['+x+']']
            characters.push(new sch.Character(sign, desc))

    @saveDefault = ->
        @save(defaultCharacters[@getCollection()] || [])

    @save = (charactersToSave) ->
        if charactersToSave is null
            charactersToSave = characters

        localStorage['countOfCharacters'] = charactersToSave.length;

        for character, x in characters
            localStorage.removeItem('character.sign['+x+']')
            localStorage.removeItem('character.desc['+x+']')

        for character, x in charactersToSave
            localStorage['character.sign['+x+']'] = character.sign
            localStorage['character.desc['+x+']'] = character.desc

        @restore()

    @restore()

    return



goog.scope ->
    sch.Characters::insertCharacterToActiveElement = (tabId, character) ->
        chrome.tabs.sendRequest(tabId, {
            action: 'insertTextToActiveElement'
            text: character.sign
        })

    sch.Characters::refresh = -> @restore()

    sch.Characters::getCollection = ->
        localStorage['collection'] = sch.getLocaleFromNavigator() if localStorage['collection'] is undefined
        localStorage['collection']

    return
