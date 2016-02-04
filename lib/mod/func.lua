local func = {}

function func.dis(x1, y1, x2, y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

function func.angle(x1, y1, x2, y2) return math.atan2(y2-y1, x2-x1) end

function func.clamp(low, n, high) return math.min(math.max(low, n), high) end

return func