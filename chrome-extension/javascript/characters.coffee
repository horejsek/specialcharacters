
Character = (sign='', desc='') ->
    {
        sign: sign
        desc: desc
    }

Characters = ->
    characters = []
    defaultCharacters =
        cs: [
            new Character('–', 'pomlčka')
            new Character('—', 'dlouhá pomlčka')
            new Character('„“', 'uvozovky')
            new Character('…', 'výpustka')
        ]
        en: [
            new Character('–', 'dash')
            new Character('—', 'long dash')
            new Character('“”', 'quotation marks')
            new Character('…', 'ellipsis')
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
            characters.push(new Character(sign, desc))

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
        localStorage['locale'] = getLocaleFromNavigator() if localStorage['locale'] is undefined
        localStorage['locale']

    @restore()

    return