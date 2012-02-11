
goog.require('goog.testing.jsunit')

goog.require('sch.Character')
goog.require('sch.Characters')



setUp = ->
    goog.global.chrome = chromeMock
    localStorage['collection'] = 'cs'
    localStorage['countOfCharacters'] = 0
    localStorage.removeItem('countOfCharacters')


testCreateCsInstance = ->
    localStorage['collection'] = 'cs'
    characters = new sch.Characters()
    assertEquals('cs', characters.getCollection())
    assertNotEquals(0, characters.getCharacters().length)


testCreateEnInstance = ->
    localStorage['collection'] = 'en'
    characters = new sch.Characters()
    assertEquals('en', characters.getCollection())
    assertNotEquals(0, characters.getCharacters().length)


testCreateInstanceWithUnknownInstance = ->
    localStorage['collection'] = 'unknown'
    characters = new sch.Characters()
    assertEquals(0, characters.getCharacters().length)


testProtectCharactersData = ->
    characters = new sch.Characters()
    charactersArray = characters.getCharacters()
    charactersArray.push(new sch.Character('a', 'bb'))
    assertNotEquals(charactersArray.length, characters.getCharacters().length)


testSave = ->


chromeMock =
    i18n:
        getMessage: (key) ->
            return key
