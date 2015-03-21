return function()
    if data.chance.discardpile == nil then data.chance.discardpile=data.chance.cards end -- INITIALIZATION
    data.chance.drawpile={}
    while #data.chance.discardpile ~=0 do
        table.insert(data.chance.drawpile,table.remove(data.chance.discardpile,math.random(#data.chance.discardpile)))
    end
    data.chance.discardpile={}
end
