
goog.require('goog.testing.jsunit')

goog.require('sch.Character')
goog.require('sch.Characters')



setUp = ->
    localStorage['locale'] = 'cs'
    localStorage['countOfCharacters'] = 0
    localStorage.removeItem('countOfCharacters')


testCreateCsInstance = ->
    localStorage['locale'] = 'cs'
    characters = new sch.Characters()
    assertEquals('cs', characters.getLocale())
    assertNotEquals(0, characters.getCharacters().length)


testCreateEnInstance = ->
    localStorage['locale'] = 'en'
    characters = new sch.Characters()
    assertEquals('en', characters.getLocale())
    assertNotEquals(0, characters.getCharacters().length)


testCreateInstanceWithUnknownInstance = ->
    localStorage['locale'] = 'unknown'
    characters = new sch.Characters()
    assertEquals(0, characters.getCharacters().length)


testProtectCharactersData = ->
    characters = new sch.Characters()
    charactersArray = characters.getCharacters()
    charactersArray.push(new sch.Character('a', 'bb'))
    assertNotEquals(charactersArray.length, characters.getCharacters().length)


testSave = ->
