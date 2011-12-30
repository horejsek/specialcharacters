
chrome.extension.onRequest.addListener(function(request, sender, sendResponse)
{
    if (request.action == "appendTextToActiveElement") {
       var elm = document.activeElement;
       elm.value = elm.value + request.text;
    }
});
