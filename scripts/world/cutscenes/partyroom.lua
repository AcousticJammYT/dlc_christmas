return {
    party = function(cutscene, event)
        cutscene:after(function()
           Game.world:openMenu(DarkCharacterMenu())    
           Game.world.menu.ready = true
        end)
    end,
}