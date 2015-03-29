return function()
    data.chance.cardturnsleft=data.chance.cardturnsleft-1
    if data.chance.cardturnsleft>0 then return end
    if data.chance.cards[data.chance.activecard].discard then
      data.chance.cards.discard()
    end
    if #data.chance.drawpile==0 then data.chance.shuffle() end
    table.insert(data.chance.discardpile,data.chance.activecard)
    data.chance.activecard=table.remove(data.chance.drawpile)
    data.chance.cardturnsleft=3
    if data.chance.cards[data.chance.activecard].draw then
      data.chance.cards.draw()
    end
end
