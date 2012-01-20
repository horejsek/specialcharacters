
Character = (sign='', desc='') ->
    {
        sign: sign
        desc: desc
    }

Characters = new ->
    characters = []
    defaultCharacters = [
        new Character('–', 'pomlčka')
        new Character('—', 'dlouhá pomlčka')
        new Character('„“', 'uvozovky')
        new Character('…', 'výpustka')
    ]

    @getCharacters = ->
        characters.slice()

    @insertCharacterToActiveElement = (tabId, character) ->
        chrome.tabs.sendRequest(tabId, {
            action: 'insertTextToActiveElement'
            text: character.sign
        })

    @restore = ->
        if localStorage['countOfCharacters'] is undefined
            this.saveDefault()

        characters = []
        for x in [0...localStorage['countOfCharacters']]
            sign = localStorage['character.sign['+x+']']
            desc = localStorage['character.desc['+x+']']
            characters.push(new Character(sign, desc))

    @saveDefault = ->
        this.save(defaultCharacters)

    @save = (charactersToSave) ->
        if charactersToSave is null
            charactersToSave = characters

        localStorage['countOfCharacters'] = charactersToSave.length;

        for character, x in charactersToSave
            localStorage['character.sign['+x+']'] = character.sign;
            localStorage['character.desc['+x+']'] = character.desc;

        this.restore()

    this.restore()

    return