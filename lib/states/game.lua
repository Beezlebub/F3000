Entity = require 'lib.mod.ecs'
require 'lib.mod.hud'

LG = love.graphics
LK = love.keyboard
LM = love.mouse

LG.setPointSize(2)
local stars = {}
for i = 1, 20000 do
	stars[#stars+1] = {
		x = math.random(-10000,10000),
		y = math.random(-10000,10000),
		a = math.random(80,200)
	}
end

entities = {}
--	IN GAME

local state = {}
function state.init()
	local self = {

		click = {
            l = "mouseL",
            r = "mouseR"
        },

		keys = {
			escape 	= "pause",
			tab 	= "toggleDebug",

			w 		= "thrustOn",
			s 		= "reverseOn",
			a 		= "ccwOn",
			d 		= "cwOn",

			[" "] 	= "shootOn",
			["1"] 	= "weapon1",
			["2"]	= "weapon2",
			["3"]	= "weapon3",
			["4"]	= "weapon4",
			["5"]	= "weapon5"
		},

		keysReleased = {
			w 		= "thrustOff",
			s 		= "reverseOff",
			a 		= "ccwOff",
			d 		= "cwOff",
			[" "]	= "shootOff"
		},

		bindings = {
		    pause   	= function() stateActivate("pause") end,
		    toggleDebug = function() _showDebug = not _showDebug end,

		    thrustOn	= function() PLAYER:set("thrust", true) end,
		    thrustOff	= function() PLAYER:set("thrust", false) end,
		    reverseOn	= function() PLAYER:set("reverse", true) end,
		    reverseOff	= function() PLAYER:set("reverse", false) end,

		    ccwOn		= function() PLAYER:set("turnCCW", true) end,
		    ccwOff		= function() PLAYER:set("turnCCW", false) end,
		    cwOn		= function() PLAYER:set("turnCW", true) end,
		    cwOff		= function() PLAYER:set("turnCW", false) end,

		    shootOn		= function() PLAYER:set("shoot", true) end,
		    shootOff	= function() PLAYER:set("shoot", false) end,

		    weapon1	= function() PLAYER:set("weapon", "bullet") end,
		    weapon2	= function() PLAYER:set("weapon", "missle") end
		}
	}

	function self.load()
		hudLoad()
		entities[1] = Entity.new("player", 0, 0)
		PLAYER = entities[1]
	end

	function self.update(dt)
		hudUpdate(dt)
		
		for i = #entities, 1, -1 do									-- check dead
			if entities[i].isDead then
				if entities[i].action.explode then
					entities[#entities+1] = Entity.new("explosion", entities[i].x, entities[i].y)
				end
				table.remove(entities, i)
			else
				entities[i]:update(dt)

				if entities[i].action.smoke then					-- smoke trails
					if entities[i].action.thrust then
						entities[#entities+1] = Entity.new("smoke", entities[i].x, entities[i].y)
					end
				end
			end
		end

		-------------------------------------------------------------- PLAYER ONLY 
		if PLAYER.action.shoot and PLAYER.canShoot then	-- fire weapons
			if PLAYER.weapon.use == "bullet" then
				entities[#entities+1] = Entity.new("bullet", PLAYER.x, PLAYER.y, PLAYER.vx, PLAYER.vy, PLAYER.rot)
				PLAYER:set("canShoot", false)
				PLAYER:set("canShootTimer", .3)

			elseif PLAYER.weapon.use == "missle" then
				entities[#entities+1] = Entity.new("missle", PLAYER.x, PLAYER.y, PLAYER.vx, PLAYER.vy, PLAYER.rot)
				PLAYER:set("canShoot", false)
				PLAYER:set("canShootTimer", 3)
			end
		end
	end

	function self.draw()
		LG.push()
	    LG.translate(-PLAYER.x + LG.getWidth()/2, -PLAYER.y + LG.getHeight()/2)
	
		for i = 1, #stars do
			local x, y, dis = stars[i].x, stars[i].y, 0
			dis = math.abs(PLAYER.x - x) + math.abs(PLAYER.y - y)
			if dis < LG.getWidth() then
				LG.setColor(255,255,255, stars[i].a)
				LG.point(stars[i].x, stars[i].y)
			end
		end
	
		for i = #entities, 1, -1 do
			entities[i]:draw()
		end

		hudDrawDynamic()
	    love.graphics.pop()
		hudDrawStatic()
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

    function self.mousepressed(x, y, b)
        local binding = self.click[b]
        return self.inputHandler( binding )
    end

    return self
end
return state
