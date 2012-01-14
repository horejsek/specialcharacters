
(function () {

    function insertText(doc, text) {
        var elm = doc.activeElement;

        if (elm.tagName == 'IFRAME') {
            insertText(elm.contentDocument, text);
        } else if (elm.value !== undefined) {
            insertTextIntoFormElement(elm, text);
        } else {
            insertTextIntoEditableElement(doc, text);
        }
    }

    function insertTextIntoFormElement(elm, text) {
        var selectionStart = elm.selectionStart,
            selectionEnd = elm.selectionEnd;

        if (text.length == 2) {
            selectionEnd++;
            insertIntoValueOfElementToPosition(elm, selectionStart, text[0]);
            insertIntoValueOfElementToPosition(elm, selectionEnd, text[1]);
        } else {
            insertIntoValueOfElementToPosition(elm, selectionEnd, text);
        }
        seekInElemenetToPosistion(elm, selectionEnd + 1);
    }

    function insertTextIntoEditableElement(win, text) {
        var selection = win.getSelection(),
            selectionStartNode = selection.anchorNode,
            selectionStart = selection.anchorOffset,
            selectionEndNode = selection.focusNode,
            selectionEnd = selection.focusOffset;

        if (text.length == 2) {
            if (selectionStartNode == selectionEndNode) {
                selectionEnd++;
            }
            selectionStartNode.textContent = insertIntoTextToPosition(selectionStartNode.textContent, selectionStart, text[0]);
            selectionEndNode.textContent = insertIntoTextToPosition(selectionEndNode.textContent, selectionEnd, text[1]);
        } else {
            selectionEndNode.textContent = insertIntoTextToPosition(selectionEndNode.textContent, selectionEnd, text);
        }
        selection.setPosition(selectionEndNode, selectionEnd + 1);
    }

    function insertIntoValueOfElementToPosition(elm, position, value) {
        elm.value = insertIntoTextToPosition(elm.value, position, value);
    }

    function insertIntoTextToPosition(text, position, subtext) {
        return text.substr(0, position) + subtext + text.substr(position, text.length);
    }

    function seekInElemenetToPosistion(elm, position) {
        elm.setSelectionRange(position, position);
    }

    chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
        if (request.action == 'insertTextToActiveElement') {
            insertText(document, request.text);
        }
    });

}())
