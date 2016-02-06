local player 		= require 'lib.ent.player'
local bullet 		= require 'lib.ent.bullet'
local missle 		= require 'lib.ent.missle'
local planet 		= require 'lib.ent.planet'
local smoke 		= require 'lib.ent.smoke'
local explosion 	= require 'lib.ent.explosion'

local ecs = {}

function ecs.new(model, x, y, vx, vy, rot)
	local self = {
		model = model,
		isDead = false
	}
	
	if model == "player" then
		self = player.inherit(x, y)

	elseif model == "bullet" then
		self = bullet.inherit(x, y, vx, vy, rot)

	elseif model == "missle" then
		self = missle.inherit(x, y, vx, vy, rot)
		playSFX(self.sfx)
		
	elseif model == "planet" then
		self = planet.inherit(x, y)

	elseif model == "smoke" then
		self = smoke.inherit(x, y)

	elseif model == "explosion" then
		self = explosion.inherit(x, y)
		playSFX(self.sfx)
	end

	if self.action.sound then
		
	end

	return self
end

function ecs.update(dt)
	for i = #entities, 1, -1 do				-- check dead
		if entities[i].isDead then
			if entities[i].action.explode then		-- explosions
				entities[#entities+1] = ecs.new("explosion", entities[i].x, entities[i].y) 
			end

			table.remove(entities, i)
		else
			entities[i]:update(dt)

			if entities[i].action.smoke and entities[i].action.thrust then		-- smoke trails
				entities[#entities+1] = ecs.new("smoke", entities[i].x, entities[i].y)
			end
		end
	end


	if PLAYER.action.shoot and PLAYER.canShoot then	-- fire weapons
		if PLAYER.weapon.use == "bullet" then
			entities[#entities+1] = ecs.new("bullet", PLAYER.x, PLAYER.y, PLAYER.vx, PLAYER.vy, PLAYER.rot)
			PLAYER:set("canShoot", false)
			PLAYER:set("canShootTimer", .3)

		elseif PLAYER.weapon.use == "missle" then
			entities[#entities+1] = ecs.new("missle", PLAYER.x, PLAYER.y, PLAYER.vx, PLAYER.vy, PLAYER.rot)
			PLAYER:set("canShoot", false)
			PLAYER:set("canShootTimer", 3)
		end
	end
end

return ecs
