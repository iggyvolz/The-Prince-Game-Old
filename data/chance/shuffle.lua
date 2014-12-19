return function()
    if parent.discardpile == nil then parent.discardpile=parent.cards end -- INITIALIZATION
    parent.drawpile={}
    while #parent.discardpile ~=0 do
        table.insert(parent.drawpile,table.remove(parent.discardpile,math.random(#parent.discardpile)))
    end
    parent.discardpile={}
end