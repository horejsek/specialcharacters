
goog.provide('sch.Background')

goog.require('sch.ContextMenu')



sch.Background = ->
    sch.Background::init = (contextMenu) ->
        contextMenu.createCharacterContextMenu()

    return
