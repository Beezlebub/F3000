
function hudLoad()

end

function hudMsg(msg, mode, time)
	HINT.new(msg, mode, time)
end

function hudUpdate(dt)
	HINT.update(dt)
end

function hudDrawStatic()
	HINT.draw()
	if _showDebug then
		LG.setColor(180, 180, 180)
		LG.rectangle("fill", 180, 470, 200, 240)

		LG.setColor(0,0,0)

		LG.printf("x= " ..  entities[1].x, 200, 500, 500)
		LG.printf("y= " ..  entities[1].y, 200, 520, 500)
		LG.printf("rot= " ..  entities[1].rot, 200, 540, 500)
		LG.printf("vx= " ..  entities[1].vx, 200, 560, 500)
		LG.printf("vy= " ..  entities[1].vy, 200, 580, 500)
		LG.printf("health= " ..  entities[1].health, 200, 600, 500)
		LG.printf("weapon= " ..  entities[1].weapon.use, 200, 640, 500)
	end
end

function hudDrawDynamic()

end
