
Options = new ->
    @countOfCharacters = 0

    @init = -> insertListOfCharacters()

    insertListOfCharacters = ->
        characters = Characters.getCharacters()
        frag = document.createDocumentFragment()

        Options.countOfCharacters = characters.length

        for character, x in characters
            frag.appendChild(createElmCharacter(character, x))

        charactersElm = document.getElementById('characters')
        charactersElm.innerHTML = ''
        charactersElm.appendChild(frag)

    createElmCharacter = (character, index) ->
        characterRow = document.createElement('tr')
        characterRow.setAttribute('id', 'character-' + index)
        characterRow.appendChild(createCharacterCellSign(character.sign, index))
        characterRow.appendChild(createCharacterCellDesc(character.desc, index))
        characterRow.appendChild(createCharacterCellDelete(index))
        characterRow

    createCharacterCellSign = (sign, index) ->
        characterCellSign = document.createElement('td')
        characterCellSign.innerHTML = chrome.i18n.getMessage('optionGeneralCharacter')

        input = document.createElement('input')
        input.setAttribute('onchange', 'Options.showSavePendings()')
        input.setAttribute('class', 'character-sign')
        input.setAttribute('id', 'character-sign-' + index)
        input.setAttribute('maxlength', 2)
        input.type = 'text'
        input.value = sign
        characterCellSign.appendChild(input)

        characterCellSign

    createCharacterCellDesc = (desc, index) ->
        characterCellDesc = document.createElement('td')
        characterCellDesc.innerHTML = chrome.i18n.getMessage('optionGeneralCharacterDescription')

        input = document.createElement('input')
        input.setAttribute('onchange', 'Options.showSavePendings()')
        input.setAttribute('id', 'character-desc-' + index)
        input.type = 'text'
        input.value = desc
        characterCellDesc.appendChild(input)

        characterCellDesc

    createCharacterCellDelete = (index) ->
        cell = document.createElement('td')

        deleteButton = document.createElement('button')
        deleteButton.setAttribute('onclick', 'Options.deleteCharacter(' + index + ')')
        deleteButton.innerHTML = chrome.i18n.getMessage('optionGeneralDeleteCharacterButton')

        cell.appendChild(deleteButton)
        cell;

    @save = ->
        index = 0
        newCharacters = []

        loop
            sign = document.getElementById('character-sign-'+index)
            desc = document.getElementById('character-desc-'+index)

            if sign?
                newCharacters.push(new Character(sign.value, desc.value))
                break if newCharacters.length is Options.countOfCharacters

            index++

        Characters.save(newCharacters)
        this.hideSavePendings()
        ContextMenu.updateCharacterContextMenu()

    @saveDefault = ->
        Characters.saveDefault()
        this.hideSavePendings()
        ContextMenu.updateCharacterContextMenu()
        insertListOfCharacters()

    @addCharacter = ->
        newCharacterElm = createElmCharacter(new Character(), Options.countOfCharacters++)
        document.getElementById('characters').appendChild(newCharacterElm)
        this.showSavePendings()

    @deleteCharacter = (index) ->
        Options.countOfCharacters--
        characterElm = document.getElementById('character-' + index)
        document.getElementById('characters').removeChild(characterElm)
        this.showSavePendings()

    @showSavePendings = ->
        document.getElementById('savePendings').style.display = 'block'

    @hideSavePendings = ->
        document.getElementById('savePendings').style.display = 'none'

    return
