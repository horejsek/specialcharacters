
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
            frag.appendChild(self.createElmCharacter(character))
        goog.dom.getElement('characters').appendChild(frag)

    return



goog.scope ->
    # Create elements.

    sch.Popup::createElmCharacter = (character) ->
        self = this
        goog.dom.createDom(
            'p',
            {
                class: 'character'
                onclick: -> self.copyIntoClipboard(character.sign)
            },
            @createElmCharacterSign(character.sign),
            @createElmCharacterDesc(character.desc),
        )

    sch.Popup::createElmCharacterSign = (sign) ->
        goog.dom.createDom('span', 'character-sign', sign)

    sch.Popup::createElmCharacterDesc = (desc) ->
        goog.dom.createDom('span', 'character-desc', desc)

    # Copy into clipboard.

    sch.Popup::copyIntoClipboard = (text) ->
        clipboardTextarea = @createClipboardTextarea(text)
        document.body.appendChild(clipboardTextarea)
        clipboardTextarea.select()
        document.execCommand('copy')
        document.body.removeChild(clipboardTextarea)
        window.close()

    sch.Popup::createClipboardTextarea = (text) ->
        goog.dom.createDom('textarea', {
            style: 'position: absolute; left: -100%;'
            value: text
        })

    return
