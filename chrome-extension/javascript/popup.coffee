
Popup = new ->
    @init = ->
        insertListOfCharacters()

    insertListOfCharacters = ->
        frag = document.createDocumentFragment()
        for character in Characters.getCharacters()
            frag.appendChild createElmCharacter(character)
        document.getElementById('characters').appendChild frag

    createElmCharacter = (character) ->
        elm = document.createElement('p')
        elm.setAttribute('class', 'character')
        elm.setAttribute('onclick', 'Popup.copyToClipboard("'+character.sign+'")')
        elm.appendChild(createElmCharacterSign(character.sign))
        elm.appendChild(createElmCharacterDesc(character.desc))
        elm

    createElmCharacterSign = (sign) ->
        elm = document.createElement('span')
        elm.setAttribute('class', 'character-sign')
        elm.innerHTML = sign
        elm

    createElmCharacterDesc = (desc) ->
        elm = document.createElement('span')
        elm.setAttribute('class', 'character-desc')
        elm.innerHTML = desc
        elm

    @copyToClipboard = (text) ->
        clipboardTextarea = createClipboardTextarea(text)
        document.body.appendChild(clipboardTextarea)
        clipboardTextarea.select()
        document.execCommand('copy')
        document.body.removeChild(clipboardTextarea)
        window.close()

    createClipboardTextarea = (text) ->
        elm = document.createElement('textarea')
        elm.style.position = 'absolute'
        elm.style.left = '-100%'
        elm.value = text
        elm

    return