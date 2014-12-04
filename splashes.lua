local splashes={
  ["time"]=0 -- Time since began
}
splashes.__index=splashes
function love.load(t)

end
function love.update(dt)
  self=splashes
  self.time=self.time+dt
  if self.time > 12 then require "game" end
  if self.time > 8 and self.time-dt<8 then -- First time beyond 8.  Would love to use assets.eijingle:isPlaying() here but incompatible with 0.9+
    assets.eijingle:play()
  end
end
function love.draw()
  self=splashes
  if self.time < 4 then
    love.graphics.draw(assets.lua,100,0,0,0.27,0.27)
  elseif self.time < 8 then
    love.graphics.draw(assets.love,135,60)
  elseif self.time < 12 then
    love.graphics.draw(assets.eilogo,-10,175,0,0.25,0.25)
  end
end
function love.mousepressed(x, y, button)
end
function love.mousereleased(x, y, button)

end
function love.focus(f)

end
function love.quit()

end
return splashes
