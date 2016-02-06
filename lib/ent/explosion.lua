local explosion = {}

function explosion.inherit(x, y)
	local self = {
		--img = LG.newImage('lib/img/missle.png'),
		sfx = love.audio.newSource("lib/sfx/explosion1.wav", "static"),
		x = x,
		y = y, 
		r = 3,
		a = 200,
		thrust = 5,
		rot = rot,
		lifeTime = 8,
		collides = false,

		action = {
			thrust = false,
			smoke = true
		}
	}

	self.sfx:setVolume(.5)

	function self:update(dt)
		self.lifeTime = self.lifeTime - 1 * dt
		if self.lifeTime <= 0 then
			self.isDead = true
			return
		end

		self.r = self.r + 1 * dt
		self.a = self.a - 25 * dt
		if self.a < 0 then self.a = 0 end
	end

	function self:draw()
		LG.setColor(255,80,80, self.a+50)
		LG.circle("fill", self.x, self.y, self.r)
		LG.circle("fill", self.x+3, self.y+4, self.r)
		LG.circle("fill", self.x+4, self.y-3, self.r)
		LG.circle("fill", self.x-3, self.y+4, self.r)
		LG.circle("fill", self.x-4, self.y-3, self.r)

		LG.setColor(255,255,255, self.a)
		LG.circle("fill", self.x, self.y, self.r)
		LG.circle("fill", self.x+4, self.y+3, self.r)
		LG.circle("fill", self.x+3, self.y-4, self.r)
		LG.circle("fill", self.x-4, self.y+3, self.r)
		LG.circle("fill", self.x-3, self.y-4, self.r)
	end

	return self
end

return explosion
