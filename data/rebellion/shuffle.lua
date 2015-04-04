return function()
  data.rebellion.drawpile={}
  local rebellioncount=data.rebellion.rebellioncount
  local safecount=data.rebellion.safecount
  for i=1,data.rebellion.rebellioncount+data.rebellion.safecount do
    if false then print(i) end -- Trick luacheck into thinking I use i
    if math.random(rebellioncount+safecount)>rebellioncount then
      safecount=safecount-1
      table.insert(data.rebellion.drawpile,true)
    else
      rebellioncount=rebellioncount-1
      table.insert(data.rebellion.drawpile,false)
    end
  end
  data.rebellion.discardpile={}
end
