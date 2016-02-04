--	IN MENU
local state = {}

local LG = love.graphics
local LK = love.keyboard
local LM = love.mouse

function state.init()
    local self = {}
    
    self = { 

        keys = {
            escape        = "toPrev",
            ["return"]    = "toPrev"
        },

        keysReleased = {},

        bindings = {
            toPrev = function() stateActivate("menu") end
        },    

        btnStart = {
            x = LG.getWidth()/2-150,
            y = LG.getHeight()/2-125,
            w = 300,
            h = 100,
            hover = false
        },

        btnOptions = {
            x = LG.getWidth()/2-150,
            y = LG.getHeight()/2+25,
            w = 300,
            h = 100,
            hover = false
        },

        img = LG.newImage('lib/img/splashB.png')
    }

    function self.update(dt)
        local mx, my = LM.getPosition()
        if mx < self.btnStart.x + self.btnStart.w and self.btnStart.x < mx and my < self.btnStart.y + self.btnStart.h and self.btnStart.y < my then
            self.btnStart.hover = true
        else
            self.btnStart.hover = false
        end

        if mx < self.btnOptions.x + self.btnOptions.w and self.btnOptions.x < mx and my < self.btnOptions.y + self.btnOptions.h and self.btnOptions.y < my then
            self.btnOptions.hover = true
        else
            self.btnOptions.hover = false
        end
    end

    function self.draw()
        LG.setColor(255,255,255)
        LG.draw(self.img, LG.getWidth()/2, LG.getHeight()/2, 0, 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)

        LG.setColor(80,80,80)
        LG.rectangle("fill", self.btnStart.x, self.btnStart.y, self.btnStart.w, self.btnStart.h)
        LG.rectangle("fill", self.btnOptions.x, self.btnOptions.y, self.btnOptions.w, self.btnOptions.h)

        LG.setFont(font48)
        LG.setColor(255,255,255)
        LG.printf("Back", self.btnOptions.x, self.btnOptions.y+15, self.btnOptions.w, "center")

        if _playAudio then
            LG.printf("Mute Audio", self.btnStart.x, self.btnStart.y+15, self.btnStart.w, "center")
        else
            LG.printf("Play Audio", self.btnStart.x, self.btnStart.y+15, self.btnStart.w, "center") 
        end

        if self.btnStart.hover then
            LG.rectangle("line", self.btnStart.x, self.btnStart.y, self.btnStart.w, self.btnStart.h)
        end
        if self.btnOptions.hover then
            LG.rectangle("line", self.btnOptions.x, self.btnOptions.y, self.btnOptions.w, self.btnOptions.h)
        end
    end

    function self.activate()
    end

    function self.deactivate()
    end

    function self.inputHandler(input)
        local action = self.bindings[input]
        if action then return action() end
    end

    function self.keypressed(k)
        local binding = self.keys[k]
        return self.inputHandler( binding )
    end

    function self.keyreleased(k)
        local binding = self.keysReleased[k]
        return self.inputHandler( binding )
    end

    function self.mousepressed(mx, my, b)
        if mx < self.btnStart.x + self.btnStart.w and self.btnStart.x < mx and my < self.btnStart.y + self.btnStart.h and self.btnStart.y < my then
            _playAudio = not _playAudio
        elseif mx < self.btnOptions.x + self.btnOptions.w and self.btnOptions.x < mx and my < self.btnOptions.y + self.btnOptions.h and self.btnOptions.y < my then
            stateActivate(prev)
        end
    end

    return self
end

return state
