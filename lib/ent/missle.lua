local missle = {}

function missle.inherit(x, y, vx, vy, rot)
	local self = {
		img = LG.newImage('lib/img/missle.png'),
		sfx = love.audio.newSource("lib/sfx/rocket1.wav", "static"),
		x = x,
		y = y, 
		vx = vx,
		vy = vy,
		thrust = 5,
		rot = rot,
		lifeTime = 5,
		collides = true,

		action = {
			thrust = true,
			smoke = true,
			explode = true
		}
	}

	self.sfx:setVolume(.5)

	function self:update(dt)
		self.lifeTime = self.lifeTime - 1 * dt
		if self.lifeTime <= 0 then
			self.isDead = true
			return
		end

		self.vx = self.vx + math.sin(self.rot) * self.thrust * dt
		self.vy = self.vy + math.cos(self.rot) * -self.thrust * dt

		self.x = self.x + self.vx
		self.y = self.y + self.vy
	end

	function self:draw()
		LG.setColor(255,255,255)
		LG.draw(self.img, self.x, self.y, self.rot, .2, .2, self.img:getWidth()/2, self.img:getHeight()/2)
	end

	return self
end
return missle
