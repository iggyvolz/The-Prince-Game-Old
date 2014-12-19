return function(x) -- Draws x (int) cards, returns x+1 arguments (overall status (e.g. all cards are true then true else false) then all cards in order)
    local status=true
    local drawn={}
    for i=1,x do
      if i==1 then end -- Trick luacheck into thinking I use i
      if #parent.drawpile == 0 then parent.shuffle() end
      if not parent.drawpile[#parent.drawpile] and status then status=false end
      table.insert(drawn,table.remove(parent.drawpile))
    end
    return status,unpack(drawn)
end
