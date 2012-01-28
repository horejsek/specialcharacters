
goog.provide('sch.Background');

goog.require('sch.ContextMenu');



sch.Background = ->
    sch.Background::init = ->
        (new sch.ContextMenu()).createCharacterContextMenu()

    return
