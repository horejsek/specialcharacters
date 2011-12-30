
chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
    if (request.action == 'appendTextToActiveElement') {
        var elm = document.activeElement;
        elm.value = elm.value + request.text;

    } else if (request.action == 'insertTextToActiveElement') {
        var elm = document.activeElement,
            position = elm.selectionStart;

        elm.value = elm.value.substr(0, position) + request.text + elm.value.substr(position, elm.value.length);
        elm.setSelectionRange(position + 1, position + 1);
    }
});
