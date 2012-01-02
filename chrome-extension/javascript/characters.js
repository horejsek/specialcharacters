
var Character = function (sign, desc) {
    return {
        'sign': sign,
        'desc': desc,
    };
};

var Characters = new function () {
    var characters = [];
    var defaultCharacters = [
        new Character('–', 'pomlčka'),
        new Character('—', 'dlouhá pomlčka'),
        new Character('„', 'levá dolní uvozovka'),
        new Character('”', 'pravá horní uvozovka'),
        new Character('“', 'levá horní uvozovka')
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

    this.restore = function () {
        if (localStorage['countOfCharacters'] === undefined) {
            saveDefault();
        }

        var countOfCharacters = localStorage['countOfCharacters'];

        characters = [];
        for (var i = 0; i < countOfCharacters; i++) {
            var sign = localStorage['character.sign['+i+']'],
                desc = localStorage['character.desc['+i+']'];
            characters.push(new Character(sign, desc));
        }
    }

    this.saveDefault = function () {
        this.save(defaultCharacters);
    }

    this.save = function(charactersToSave) {
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

        this.restore();
    }

    this.restore();
}
