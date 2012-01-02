
var Characters = new function () {
    var characters = [];
    var defaultCharacters = [
        {
            'sign': '–',
            'desc': 'pomlčka',
        },
        {
            'sign': '—',
            'desc': 'dlouhá pomlčka',
        },
        {
            'sign': '„',
            'desc': 'levá dolní uvozovka',
        },
        {
            'sign': '”',
            'desc': 'pravá horní uvozovka',
        },
        {
            'sign': '“',
            'desc': 'levá horní uvozovka',
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

    function restore() {
        if (localStorage['countOfCharacters'] === undefined) {
            saveDefault();
        }

        var countOfCharacters = localStorage['countOfCharacters'];

        characters = [];
        for (var i = 0; i < countOfCharacters; i++) {
            characters.push({
                'sign': localStorage['character.sign['+i+']'],
                'desc': localStorage['character.desc['+i+']']
            });
        }
    }

    function saveDefault() {
        save(defaultCharacters);
    }

    function save(charactersToSave) {
        if (charactersToSave === null) {
            charactersToSave = characters;
        }

        var countOfCharacters = charactersToSave.length;
        localStorage['countOfCharacters'] = countOfCharacters;

        for (var i = 0; i < countOfCharacters; i++) {
            var character = charactersToSave[i];
            localStorage['character.sign['+i+']'] = character.sign;
            localStorage['character.desc['+i+']'] = character.desc;
        }
    }

    restore();
}
