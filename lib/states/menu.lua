--	IN MENU
local state = {}

local LG = love.graphics
local LK = love.keyboard
local LM = love.mouse

function state.init()
    local self = {}
    
    self = { 

        keys = {
            escape        = "quit",
            ["return"]    = "startGame",     

            up      = "incIndex",
            down    = "decIndex"
        },

        keysReleased = {},

        bindings = {
            startGame = function() stateActivate("game") end,
            quit = function() love.event.quit() end,

            incIndex = function() btnIndex = btnIndex + 1 end,
            decIndex = function() btnIndex = btnIndex - 1 end
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
        LG.printf("Start", self.btnStart.x, self.btnStart.y+15, self.btnStart.w, "center")
        LG.printf("Options", self.btnOptions.x, self.btnOptions.y+15, self.btnOptions.w, "center")

        LG.setColor(255,255,255)
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
            states.game.load()
            stateActivate("game")
            HINT.new("Welcome to Formula 3000!", "info", 10)
            HINT.new("Use [WASD] to control.", "info", 10)
            HINT.new("Use [SPACE] to shoot.", "info", 10)
            HINT.new("Use [TAB] to toggle debug.", "debug", 5)


        elseif mx < self.btnOptions.x + self.btnOptions.w and self.btnOptions.x < mx and my < self.btnOptions.y + self.btnOptions.h and self.btnOptions.y < my then
            stateActivate("options")
        end
    end

    return self
end

return state
