return function()
  parent.drawpile={}
  local rebellioncount=parent.rebellioncount
  local safecount=parent.safecount
  for i=1,parent.rebellioncount+parent.safecount do
    if false then print(i) end -- Trick luacheck into thinking I use i
    if math.random(rebellioncount+safecount)>rebellioncount then
      safecount=safecount-1
      table.insert(parent.drawpile,true)
    else
      rebellioncount=rebellioncount-1
      table.insert(parent.drawpile,false)
    end
  end
  parent.discardpile={}
end
