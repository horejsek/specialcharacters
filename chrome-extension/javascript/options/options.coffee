
goog.provide('sch.Options');

goog.require('goog.dom');
goog.require('goog.events');
goog.require('sch.Character');
goog.require('sch.Characters');
goog.require('sch.ContextMenu');



sch.Options = ->
    self = this

    @countOfCharacters = 0
    contextMenu = new sch.ContextMenu()
    characters = new sch.Characters()

    @init = ->
        @initListeners()
        @setCollection()
        insertListOfCharacters()

    @initListeners = ->
        that = @
        elm = goog.dom.getElement 'add'
        goog.events.listen elm, goog.events.EventType.CLICK, () -> that.addCharacter()
        elm = goog.dom.getElement 'save'
        goog.events.listen elm, goog.events.EventType.CLICK, () -> that.save()
        elm = goog.dom.getElement 'save-default'
        goog.events.listen elm, goog.events.EventType.CLICK, () -> that.saveDefault()

    insertListOfCharacters = ->
        sch.Options.countOfCharacters = characters.getCharacters().length

        frag = document.createDocumentFragment()
        for character, x in characters.getCharacters()
            frag.appendChild(self.createElmCharacter(character, x))

        charactersElm = goog.dom.getElement('characters')
        charactersElm.innerHTML = ''
        charactersElm.appendChild(frag)

    @saveDefault = ->
        @saveCollection()
        characters.saveDefault()
        contextMenu.updateCharacterContextMenu()
        @setCollection()
        insertListOfCharacters()
        @hideSavePendings()

    @save = ->
        @saveCollection()
        saveCharacters()
        contextMenu.updateCharacterContextMenu()
        @hideSavePendings()

    saveCharacters = ->
        index = 0
        newCharacters = []

        loop
            sign = goog.dom.getElement('character-sign-' + index)
            desc = goog.dom.getElement('character-desc-' + index)

            if sign?
                newCharacters.push(new sch.Character(sign.value, desc.value))
                break if newCharacters.length is sch.Options.countOfCharacters

            index++

        characters.save(newCharacters)

    return



goog.scope ->
    # Load & save collection.

    sch.Options::setCollection = ->
        self = this
        elm = goog.dom.getElement('collection')
        elm.value = localStorage['collection']
        elm.onchange = -> self.showSavePendings()

    sch.Options::saveCollection = ->
        localStorage['collection'] = goog.dom.getElement('collection').value

    # Add & remove character.

    sch.Options::addCharacter = ->
        sch.Options.countOfCharacters++
        newCharacterElm = @createElmCharacter(new sch.Character(), sch.Options.countOfCharacters)
        goog.dom.getElement('characters').appendChild(newCharacterElm)
        @showSavePendings()

    sch.Options::deleteCharacter = (index) ->
        sch.Options.countOfCharacters--
        characterElm = goog.dom.getElement('character-' + index)
        goog.dom.getElement('characters').removeChild(characterElm)
        @showSavePendings()

    # Show & hide pendings.

    sch.Options::showSavePendings = ->
        goog.dom.getElement('savePendings').style.display = 'block'

    sch.Options::hideSavePendings = ->
        goog.dom.getElement('savePendings').style.display = 'none'

    # Create elements.

    sch.Options::createElmCharacter = (character, index) ->
        self = this
        goog.dom.createDom(
            'tr',
            {
                id: 'character-' + index
            },
            @createCharacterCellSign(character.sign, index, -> self.showSavePendings()),
            @createCharacterCellDesc(character.desc, index, -> self.showSavePendings()),
            @createCharacterCellDelete(index, -> self.deleteCharacter(index)),
        )

    sch.Options::createCharacterCellSign = (sign, index, onchangeCallback) ->
        input = goog.dom.createDom(
            'input',
            {
                id: 'character-sign-' + index
                class: 'character-sign'
                type: 'text'
                value: sign
                maxlength: 2
            }
        )
        goog.events.listen input, goog.events.EventType.CHANGE, onchangeCallback
        goog.dom.createDom(
            'td',
            undefined,
            chrome.i18n.getMessage('optionGeneralCharacter'),
            input,
        )

    sch.Options::createCharacterCellDesc = (desc, index, onchangeCallback) ->
        input = goog.dom.createDom(
            'input',
            {
                id: 'character-desc-' + index
                class: 'character-desc'
                type: 'text'
                value: desc
            }
        )
        goog.events.listen input, goog.events.EventType.CHANGE, onchangeCallback
        goog.dom.createDom(
            'td',
            undefined,
            chrome.i18n.getMessage('optionGeneralCharacterDescription'),
            input,
        )

    sch.Options::createCharacterCellDelete = (index, onclickCallback) ->
        button = goog.dom.createDom 'button', {}, chrome.i18n.getMessage 'optionGeneralDeleteCharacterButton'
        goog.events.listen button, goog.events.EventType.CLICK, onclickCallback
        goog.dom.createDom(
            'td',
            undefined,
            button,
        )

    return
