local ActionBoxDisplay, super = HookSystem.hookScript(ActionBoxDisplay)

function ActionBoxDisplay:init(...)
    super.init(self, ...)

    self.jolly = JollyLib.getJollyConfig("battle", "activate")
    if self.jolly then
        self.health_bar_overlay = Assets.getTexture("ui/health_bar_overlay")
        self.snow_bar_overlay = Assets.getTexture("battle/action_box_snow/" .. tostring(MathUtils.randomInt(1, 4)))
    end
end

function ActionBoxDisplay:draw()
    super.draw(self)

    if self.jolly then
        love.graphics.draw(self.snow_bar_overlay, 0, -40, 0, 2, 2)

        local health = (self.actbox.battler.chara:getHealth() / self.actbox.battler.chara:getStat("health")) * 76
        love.graphics.stencil(function()
            love.graphics.rectangle("fill", 128, 22 - self.actbox.data_offset, math.ceil(health), 9)
        end, "replace", 1)
        love.graphics.setStencilTest("equal", 1)
        Draw.setColor(COLORS.white, 0.65)
        love.graphics.setBlendMode("add")
        for i = 0, math.ceil(health), 8 do
            love.graphics.draw(self.health_bar_overlay, 128 + i, 22 - self.actbox.data_offset)
        end

        love.graphics.setBlendMode("alpha")
        love.graphics.setStencilTest()
    end
end

return ActionBoxDisplay
