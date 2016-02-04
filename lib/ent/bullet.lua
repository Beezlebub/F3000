local bullet = {}

function bullet.inherit(x, y, vx, vy, rot)
	local self = {
		img = LG.newImage('lib/img/bullet.png'),
		x = x,
		y = y, 
		vx = vx,
		vy = vy,
		rot = rot,
		lifeTime = 10,
		collides = true,

		action = {
			smoke = false,
			thrust = false		
		}
	}

	self.vx = self.vx + math.sin(self.rot) * 500
	self.vy = self.vy + math.cos(self.rot) * -500

	function self:update(dt)
		self.lifeTime = self.lifeTime - 1 * dt
		if self.lifeTime <= 0 then
			self.isDead = true
			return
		end

		self.x = self.x + self.vx * dt
		self.y = self.y + self.vy * dt
	end

	function self:draw()
		LG.setColor(255,255,255)
		LG.draw(self.img, self.x, self.y, self.rot, .2, .2, self.img:getWidth()/2, self.img:getHeight()/2)
	end

	return self
end
return bullet
