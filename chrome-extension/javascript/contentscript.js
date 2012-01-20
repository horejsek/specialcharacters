
(function() {
  var insertIntoTextToPosition, insertIntoValueOfElementToPosition, insertText, insertTextIntoEditableElement, insertTextIntoFormElement, seekInElemenetToPosistion;
  insertText = function(doc, text) {
    var elm;
    elm = doc.activeElement;
    if (elm.tagName === 'IFRAME') {
      return insertText(elm.contentDocument, text);
    } else if (elm.value !== void 0) {
      return insertTextIntoFormElement(elm, text);
    } else {
      return insertTextIntoEditableElement(doc, text);
    }
  };
  insertTextIntoFormElement = function(elm, text) {
    var selectionEnd, selectionStart;
    selectionStart = elm.selectionStart;
    selectionEnd = elm.selectionEnd;
    if (text.length === 2) {
      insertIntoValueOfElementToPosition(elm, selectionStart, text[0]);
      insertIntoValueOfElementToPosition(elm, selectionEnd, text[1]);
    } else {
      insertIntoValueOfElementToPosition(elm, selectionEnd, text);
    }
    return seekInElemenetToPosistion(elm, selectionEnd + 1);
  };
  insertTextIntoEditableElement = function(win, text) {
    var selection, selectionEnd, selectionEndNode, selectionStart, selectionStartNode;
    selection = win.getSelection();
    selectionStartNode = selection.anchorNode;
    selectionStart = selection.anchorOffset;
    selectionEndNode = selection.focusNode;
    selectionEnd = selection.focusOffset;
    if (text.length === 2) {
      if (selectionStartNode === selectionEndNode) selectionEnd++;
      selectionStartNode.textContent = insertIntoTextToPosition(selectionStartNode.textContent, selectionStart, text[0]);
      selectionEndNode.textContent = insertIntoTextToPosition(selectionEndNode.textContent, selectionEnd, text[1]);
    } else {
      selectionEndNode.textContent = insertIntoTextToPosition(selectionEndNode.textContent, selectionEnd, text);
    }
    return selection.setPosition(selectionEndNode, selectionEnd + 1);
  };
  insertIntoValueOfElementToPosition = function(elm, position, value) {
    return elm.value = insertIntoTextToPosition(elm.value, position, value);
  };
  insertIntoTextToPosition = function(text, position, subtext) {
    return text.substr(0, position) + subtext + text.substr(position, text.length);
  };
  seekInElemenetToPosistion = function(elm, position) {
    return elm.setSelectionRange(position, position);
  };
  return chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
    if (request.action === 'insertTextToActiveElement') {
      return insertText(document, request.text);
    }
  });
})();
