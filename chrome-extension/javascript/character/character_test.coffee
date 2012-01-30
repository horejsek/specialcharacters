
goog.require('goog.testing.jsunit')

goog.require('sch.Character')



testCreateDefaultCharacter = ->
    assertObjectEquals({sign: '', desc: ''}, new sch.Character())


testCreateCharacter = ->
    character = new sch.Character('$', 'dollar')
    assertObjectEquals({sign: '$', desc: 'dollar'}, character)
