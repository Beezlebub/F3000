local smoke = {}

function smoke.inherit(x, y)
	local self = {
		x = x,
		y = y,
		r = 1.5,
		a = 200,
		lifeTime = 10,
		collides = false,

		action = {
			smoke = false
		}
	}

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
		LG.setColor(255,255,255, self.a)
		LG.circle("fill", self.x, self.y, self.r)
	end

	return self
end
return smoke
