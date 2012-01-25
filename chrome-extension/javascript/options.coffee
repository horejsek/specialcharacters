
goog.require('goog.dom');

Options = ->
    self = this

    @countOfCharacters = 0
    contextMenu = new ContextMenu()
    characters = new Characters()

    @init = ->
        setLocale()
        insertListOfCharacters()

    setLocale = ->
        elm = goog.dom.getElement('locale')
        elm.value = localStorage['locale']
        elm.onchange = -> self.showSavePendings()

    insertListOfCharacters = ->
        Options.countOfCharacters = characters.getCharacters().length

        frag = document.createDocumentFragment()
        for character, x in characters.getCharacters()
            frag.appendChild(createElmCharacter(character, x))

        charactersElm = goog.dom.getElement('characters')
        charactersElm.innerHTML = ''
        charactersElm.appendChild(frag)

    createElmCharacter = (character, index) ->
        goog.dom.createDom(
            'tr',
            {
                id: 'character-' + index
            },
            createCharacterCellSign(character.sign, index),
            createCharacterCellDesc(character.desc, index),
            createCharacterCellDelete(index),
        )

    createCharacterCellSign = (sign, index) ->
        input = goog.dom.createDom(
            'input',
            {
                id: 'character-sign-' + index
                class: 'character-sign'
                onchange: -> self.showSavePendings()
                type: 'text'
                value: sign
                maxlength: 2
            }
        )
        goog.dom.createDom(
            'td',
            undefined,
            chrome.i18n.getMessage('optionGeneralCharacter'),
            input,
        )

    createCharacterCellDesc = (desc, index) ->
        input = goog.dom.createDom(
            'input',
            {
                id: 'character-desc-' + index
                class: 'character-desc'
                onchange: -> self.showSavePendings()
                type: 'text'
                value: desc
            }
        )
        goog.dom.createDom(
            'td',
            undefined,
            chrome.i18n.getMessage('optionGeneralCharacterDescription'),
            input,
        )

    createCharacterCellDelete = (index) ->
        button = goog.dom.createDom(
            'button',
            {
                onclick: -> self.deleteCharacter(index)
            },
            chrome.i18n.getMessage('optionGeneralDeleteCharacterButton'),
        )
        goog.dom.createDom(
            'td',
            undefined,
            button,
        )

    @save = ->
        saveLocale()
        saveCharacters()
        contextMenu.updateCharacterContextMenu()
        @hideSavePendings()

    @saveDefault = ->
        saveLocale()
        characters.saveDefault()
        contextMenu.updateCharacterContextMenu()
        @init()
        @hideSavePendings()

    saveLocale = ->
        localStorage['locale'] = goog.dom.getElement('locale').value

    saveCharacters = ->
        index = 0
        newCharacters = []

        loop
            sign = goog.dom.getElement('character-sign-' + index)
            desc = goog.dom.getElement('character-desc-' + index)

            if sign?
                newCharacters.push(new Character(sign.value, desc.value))
                break if newCharacters.length is Options.countOfCharacters

            index++

        characters.save(newCharacters)

    @addCharacter = ->
        newCharacterElm = createElmCharacter(new Character(), Options.countOfCharacters++)
        goog.dom.getElement('characters').appendChild(newCharacterElm)
        @showSavePendings()

    @deleteCharacter = (index) ->
        Options.countOfCharacters--
        characterElm = goog.dom.getElement('character-' + index)
        goog.dom.getElement('characters').removeChild(characterElm)
        @showSavePendings()

    @showSavePendings = ->
        goog.dom.getElement('savePendings').style.display = 'block'

    @hideSavePendings = ->
        goog.dom.getElement('savePendings').style.display = 'none'

    return
