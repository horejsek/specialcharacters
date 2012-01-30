
goog.require('goog.testing.PropertyReplacer')
goog.require('goog.testing.jsunit')

goog.require('sch.Background')
goog.require('sch.ContextMenu')



stubs = ->


setUp = ->
    stubs = new goog.testing.PropertyReplacer()
    return


tearDown = ->
    stubs.reset()
    return


testInit= ->
    contextMenu = new sch.ContextMenu()
    stubs.replace(contextMenu, 'createCharacterContextMenu', createCharacterContextMenuMock)

    background = new sch.Background()
    background.init(contextMenu)
    # Mock returns the number of how many times it is called.
    assertObjectEquals(2, createCharacterContextMenuMock())



createCharacterContextMenuMock = (->
    count = 0
    createCharacterContextMenuMock = ->
        count += 1
)()
