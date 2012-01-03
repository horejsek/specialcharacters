
chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
    if (request.action == 'insertTextToActiveElement') {
        var elm = document.activeElement;

        if (elm.value !== undefined) {
            var position = elm.selectionStart;
            elm.value = elm.value.substr(0, position) + request.text + elm.value.substr(position, elm.value.length);
            elm.setSelectionRange(position + 1, position + 1);
        } else {
            // If active element is DIV etc.
            elm.innerHTML = elm.innerHTML + request.text;
        }
    }
});
