
(function () {

    function insertIntoValueOfElementToPosition(elm, position, value) {
        elm.value = insertIntoText(elm.value, position, value);
    }

    function insertIntoText(text, position, subtext) {
        return text.substr(0, position) + subtext + text.substr(position, text.length);
    }

    function seekInElemenetToPosistion(elm, position) {
        elm.setSelectionRange(position, position);
    }

    chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
        if (request.action == 'insertTextToActiveElement') {
            var elm = document.activeElement;

            if (elm.value !== undefined) {
                var selectionStart = elm.selectionStart,
                    selectionEnd = elm.selectionEnd;

                if (request.text.length == 2) {
                    insertIntoValueOfElementToPosition(elm, selectionStart, request.text[0]);
                    // I inserted one character, therefore selectionEnd + 1.
                    insertIntoValueOfElementToPosition(elm, selectionEnd + 1, request.text[1]);
                } else {
                    insertIntoValueOfElementToPosition(elm, selectionEnd, request.text);
                    // I inserted one character, therefore selectionEnd + 1.
                    seekInElemenetToPosistion(elm, selectionEnd + 1);
                }

            } else {
                // If active element is DIV etc.
                var selection = window.getSelection(),
                    selectionStartNode = selection.anchorNode,
                    selectionStart = selection.anchorOffset,
                    selectionEndNode = selection.focusNode,
                    selectionEnd = selection.focusOffset;

                if (request.text.length == 2) {
                    selectionStartNode.textContent = insertIntoText(selectionStartNode.textContent, selectionStart, request.text[0]);
                    selectionEndNode.textContent = insertIntoText(selectionEndNode.textContent, selectionEnd, request.text[1]);
                } else {
                    selectionEndNode.textContent = insertIntoText(selectionEndNode.textContent, selectionEnd, request.text);
                }
                selection.setPosition(selectionEndNode, selectionEnd + 1);
            }
        }
    });

}())
