local Display, super = Class(Event, "workshop_display")

function Display:updateDisplay()
    self.visible = self.powered

    -- Update display sprite
    if self.powered then
        self:setSprite(self.path .. (self.sprite or "none"))
    end
end

function Display:init(data)
    super.init(self, data)

    local properties = data.properties or {}
    self.properties = properties or {}
    self.sound = properties["sound"]
    self.solid = properties["solid"] or true
    self.powered = properties["power"] or properties["powered"]
    self.path = "world/events/workshop/display/"
    self.scale = 2
    ---@type PartyMember
    self.party = nil

    self:setScale(0.5)
    self:updateDisplay()
end

function Display:power(powered)
    self.powered = powered or true
    self:updateDisplay()
end

function Display:onAdd(parent)
    super.onAdd(self, parent)
end

function Display:update()
    super.update(self)
end

function Display:draw()
    super.draw(self)

    if self.powered then
        if self.checkmark then
            love.graphics.draw(Assets.getTexture(self.path .. self.checkmark),49*self.scale,2*self.scale,0,self.scale,self.scale)
        end
        local party = self.party
        if party then
            -- print(self.party.actor or "nah actor")
            local actor = party.actor
            if actor then
                -- print(self.party.actor.path or "nah path actor")
                local path = actor.path .. "/walk/down_1"
                -- print(path)
                local charscale = self.scale / 2
                love.graphics.draw(Assets.getTexture(path),(36-actor.width/2)*self.scale,(36-actor.height/2)*self.scale,0,charscale,charscale)
            end
        end
    end
end

function Display:onInteract(player, dir)
    local cutscene = Game.world:startCutscene(function(c)
        local spowered = (self.powered and "on") or "off"
        c:text("* (The display is turned " .. spowered .. ")")
        if self.powered == false then
            c:text("* (Turn on?)")
            local ch = c:choicer({"Yes", "No"})
            if ch == 2 then return end
            c:text("* (...[wait:5]Nothing happens)")
        end
    end)
end

return Display