
(function () {

    function insertIntoValueOfElementToPosition(elm, position, value) {
        elm.value = elm.value.substr(0, position) + value + elm.value.substr(position, elm.value.length);
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
                elm.innerHTML = elm.innerHTML + request.text;
            }
        }
    });

}())
