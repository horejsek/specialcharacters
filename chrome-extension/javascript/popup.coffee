
goog.provide('sch.Popup');

goog.require('goog.dom');
goog.require('sch.Characters');

sch.Popup = ->
    self = this

    characters = new sch.Characters()

    @init = ->
        insertListOfCharacters()

    insertListOfCharacters = ->
        frag = document.createDocumentFragment()
        for character in characters.getCharacters()
            frag.appendChild(createElmCharacter(character))
        goog.dom.getElement('characters').appendChild(frag)

    createElmCharacter = (character) ->
        goog.dom.createDom(
            'p',
            {
                class: 'character'
                onclick: -> self.copyToClipboard(character.sign)
            },
            createElmCharacterSign(character.sign),
            createElmCharacterDesc(character.desc),
        )

    createElmCharacterSign = (sign) ->
        goog.dom.createDom('span', 'character-sign', sign)

    createElmCharacterDesc = (desc) ->
        goog.dom.createDom('span', 'character-desc', desc)

    @copyToClipboard = (text) ->
        clipboardTextarea = createClipboardTextarea(text)
        document.body.appendChild(clipboardTextarea)
        clipboardTextarea.select()
        document.execCommand('copy')
        document.body.removeChild(clipboardTextarea)
        window.close()

    createClipboardTextarea = (text) ->
        goog.dom.createDom('textarea', {
            style: 'position: absolute; left: -100%;'
            value: text
        })

    return