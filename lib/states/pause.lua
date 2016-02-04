--  IN MENU
local state = {}

local LG = love.graphics
local LK = love.keyboard
local LM = love.mouse

function state.init()
    local self = {}
    
    self = {

        keys = {
            escape        = "unpause",
            ["return"]    = "unpause"
        },

        keysReleased = {},

        bindings = {
            unpause = function() stateActivate("game") end
        },    

        btnResume = {
            x = LG.getWidth()/2-150,
            y = LG.getHeight()/2-125,
            w = 300,
            h = 75,
            hover = false
        },

        btnOptions = {
            x = LG.getWidth()/2-150,
            y = LG.getHeight()/2-25,
            w = 300,
            h = 75,
            hover = false
        },

        btnExit = {
            x = LG.getWidth()/2-150,
            y = LG.getHeight()/2+75,
            w = 300,
            h = 75,
            hover = false
        },

        img = LG.newImage('lib/img/splashB.png')
    }

    function self.update(dt)
        local mx, my = LM.getPosition()
        if mx < self.btnResume.x + self.btnResume.w and self.btnResume.x < mx and my < self.btnResume.y + self.btnResume.h and self.btnResume.y < my then
            self.btnResume.hover = true
        else
            self.btnResume.hover = false
        end

        if mx < self.btnOptions.x + self.btnOptions.w and self.btnOptions.x < mx and my < self.btnOptions.y + self.btnOptions.h and self.btnOptions.y < my then
            self.btnOptions.hover = true
        else
            self.btnOptions.hover = false
        end

        if mx < self.btnExit.x + self.btnExit.w and self.btnExit.x < mx and my < self.btnExit.y + self.btnExit.h and self.btnExit.y < my then
            self.btnExit.hover = true
        else
            self.btnExit.hover = false
        end
    end

    function self.draw()
        LG.setColor(255,255,255)
        LG.draw(self.img, LG.getWidth()/2, LG.getHeight()/2, 0, 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)

        LG.setColor(80,80,80)
        LG.rectangle("fill", self.btnResume.x, self.btnResume.y, self.btnResume.w, self.btnResume.h)
        LG.rectangle("fill", self.btnOptions.x, self.btnOptions.y, self.btnOptions.w, self.btnOptions.h)
        LG.rectangle("fill", self.btnExit.x, self.btnExit.y, self.btnExit.w, self.btnExit.h)

        LG.setFont(font48)
        LG.setColor(255,255,255)
        LG.printf("Resume", self.btnResume.x, self.btnResume.y+15, self.btnResume.w, "center")
        LG.printf("Options", self.btnOptions.x, self.btnOptions.y+15, self.btnOptions.w, "center")
        LG.printf("Exit", self.btnExit.x, self.btnExit.y+15, self.btnExit.w, "center")

        LG.setColor(255,255,255)
        if self.btnResume.hover then
            LG.rectangle("line", self.btnResume.x, self.btnResume.y, self.btnResume.w, self.btnResume.h)
        end
        if self.btnOptions.hover then
            LG.rectangle("line", self.btnOptions.x, self.btnOptions.y, self.btnOptions.w, self.btnOptions.h)
        end
        if self.btnExit.hover then
            LG.rectangle("line", self.btnExit.x, self.btnExit.y, self.btnExit.w, self.btnExit.h)
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
        if mx < self.btnResume.x + self.btnResume.w and self.btnResume.x < mx and my < self.btnResume.y + self.btnResume.h and self.btnResume.y < my then
            stateActivate("game")
        elseif mx < self.btnOptions.x + self.btnOptions.w and self.btnOptions.x < mx and my < self.btnOptions.y + self.btnOptions.h and self.btnOptions.y < my then
            stateActivate("options")
        elseif mx < self.btnExit.x + self.btnExit.w and self.btnExit.x < mx and my < self.btnExit.y + self.btnExit.h and self.btnExit.y < my then
            stateActivate("menu")
        end
    end

    return self
end

return state
