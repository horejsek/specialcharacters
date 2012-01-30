
goog.require('goog.testing.jsunit')

goog.require('sch.Character')
goog.require('sch.Characters')



setUp = ->
    localStorage['locale'] = 'cs'


testCreateInstance = ->
    characters = new sch.Characters()
    assertEquals('cs', characters.getLocale())
    assertNotEquals(0, characters.getCharacters().length)
