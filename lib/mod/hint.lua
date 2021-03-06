local hint = {
    msgQueue = {}
}

local modes = {
  info = {
    id    = "info",   
    color = {30,30,30}, 
    bg    = {200,200,200}
  },

  debug = {
    id    = "debug",  
    color = {255,255,125}, 
    bg    = {125,125,125}
  },

  warn = {
    id    = "warn",   
    color = {255,0,0}, 
    bg    = {50,50,50}
  },

  err = {
    id    = "err",    
    color = {255,50,50}, 
    bg    = {50,50,50}
  }
}
  
function hint.new(msg, style, timer)
  local self = {}
  self.msg = msg
  self.timer = timer or 5

  self.style = style or "info"
  self.color = modes[self.style].color
  self.bg = modes[self.style].bg
  self.alpha = 255

  hint.msgQueue[#hint.msgQueue+1] = self 

  return self
end

function hint.update(dt)
  for i, msg in ipairs(hint.msgQueue) do
    msg.timer = msg.timer - 1 * dt
    if msg.timer < 2 then
        msg.alpha = msg.alpha - (125 * dt)

        if msg.timer <= 0 then
          table.remove(hint.msgQueue, i)
        end
    end
  end
end


function hint.draw()
  LG.setFont(font14)
  for i, msg in ipairs(hint.msgQueue) do
    local tx, ty = 10, ((i-1)*50)+10
    local tm = msg.msg
    local tw = font14:getWidth(tm) + 50
    
    LG.setColor(0,0,0, msg.alpha)
    LG.rectangle("line", tx, ty, tw, 40)
    LG.setColor(msg.bg, msg.alpha)
    LG.rectangle("fill", tx, ty, tw, 40)

    LG.setColor(msg.color, msg.alpha)
    LG.printf(tm, tx, ty+12, tw, "center")
  end
end

return hint
