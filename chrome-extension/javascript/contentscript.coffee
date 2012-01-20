
(->

    insertText = (doc, text) ->
        elm = doc.activeElement

        if elm.tagName == 'IFRAME'
            insertText(elm.contentDocument, text)
        else if elm.value isnt undefined
            insertTextIntoFormElement(elm, text)
        else
            insertTextIntoEditableElement(doc, text)

    insertTextIntoFormElement = (elm, text) ->
        selectionStart = elm.selectionStart
        selectionEnd = elm.selectionEnd

        if text.length == 2
            selectionEnd++
            insertIntoValueOfElementToPosition(elm, selectionStart, text[0])
            insertIntoValueOfElementToPosition(elm, selectionEnd, text[1])
        else
            insertIntoValueOfElementToPosition(elm, selectionEnd, text)

        seekInElemenetToPosistion(elm, selectionEnd + 1)

    insertTextIntoEditableElement = (win, text) ->
        selection = win.getSelection()
        selectionStartNode = selection.anchorNode
        selectionStart = selection.anchorOffset
        selectionEndNode = selection.focusNode
        selectionEnd = selection.focusOffset

        if text.length == 2
            selectionEnd++ if selectionStartNode is selectionEndNode
            selectionStartNode.textContent = insertIntoTextToPosition(selectionStartNode.textContent, selectionStart, text[0])
            selectionEndNode.textContent = insertIntoTextToPosition(selectionEndNode.textContent, selectionEnd, text[1])
        else
            selectionEndNode.textContent = insertIntoTextToPosition(selectionEndNode.textContent, selectionEnd, text)

        selection.setPosition(selectionEndNode, selectionEnd + 1)

    insertIntoValueOfElementToPosition = (elm, position, value) ->
        elm.value = insertIntoTextToPosition(elm.value, position, value)

    insertIntoTextToPosition = (text, position, subtext) ->
        text.substr(0, position) + subtext + text.substr(position, text.length)

    seekInElemenetToPosistion = (elm, position) ->
        elm.setSelectionRange(position, position)

    chrome.extension.onRequest.addListener((request, sender, sendResponse) ->
        insertText(document, request.text) if request.action is 'insertTextToActiveElement'
    )

)()
