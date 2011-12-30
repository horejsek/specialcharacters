
var Characters = new function () {
    var characters = [
        {
            'sign': '–',
            'desc': 'pomlčka',
            'hex': '2013'
        },
        {
            'sign': '—',
            'desc': 'dlouhá pomlčka',
            'hex': '2014'
        },
        {
            'sign': '„',
            'desc': 'levá dolní uvozovka',
            'hex': '201e'
        },
        {
            'sign': '”',
            'desc': 'pravá horní uvozovka',
            'hex': '201d'
        },
        {
            'sign': '“',
            'desc': 'levá horní uvozovka',
            'hex': '2020'
        }
    ];

    this.getCharacters = function () {
        return characters.slice();
    };

    this.insertCharacterToActiveElement = function (tabId, character) {
        chrome.tabs.sendRequest(tabId, {
            action: 'insertTextToActiveElement',
            text: character.sign
        });
    };
}
