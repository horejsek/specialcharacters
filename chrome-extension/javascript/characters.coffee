
goog.provide('sch.Character');
goog.provide('sch.Characters');

goog.require('sch.getLocaleFromNavigator');

sch.Character = (sign='', desc='') ->
    {
        sign: sign
        desc: desc
    }

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

    @getCharacters = ->
        characters.slice()

    @insertCharacterToActiveElement = (tabId, character) ->
        chrome.tabs.sendRequest(tabId, {
            action: 'insertTextToActiveElement'
            text: character.sign
        })

    @refresh = -> @restore()

    @restore = ->
        if localStorage['countOfCharacters'] is undefined
            @saveDefault()

        characters = []
        for x in [0...localStorage['countOfCharacters']]
            sign = localStorage['character.sign['+x+']']
            desc = localStorage['character.desc['+x+']']
            characters.push(new sch.Character(sign, desc))

    @saveDefault = ->
        @save(defaultCharacters[getLocale()])

    @save = (charactersToSave) ->
        if charactersToSave is null
            charactersToSave = characters

        localStorage['countOfCharacters'] = charactersToSave.length;

        for character, x in charactersToSave
            localStorage['character.sign['+x+']'] = character.sign;
            localStorage['character.desc['+x+']'] = character.desc;

        @restore()

    getLocale = ->
        localStorage['locale'] = sch.getLocaleFromNavigator() if localStorage['locale'] is undefined
        localStorage['locale']

    @restore()

    return