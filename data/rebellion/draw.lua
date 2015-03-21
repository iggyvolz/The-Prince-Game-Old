return function(x) -- Draws x (int) cards, returns x+1 arguments (overall status (e.g. all cards are true then true else false) then all cards in order)
    local status,drawn=true,{}
    for i=1,x do
      if false then print(i) end -- Trick luacheck into thinking I use i
      if #data.rebellion.drawpile == 0 then data.rebellion.shuffle() end
      if not data.rebellion.drawpile[#data.rebellion.drawpile] and status then status=false end
      table.insert(drawn,table.remove(data.rebellion.drawpile))
    end
    return status,(unpack or table.unpack)(drawn)
end
