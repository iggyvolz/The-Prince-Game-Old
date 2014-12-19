return function(tbl)
    parent.cardturnsleft=parent.cardturnsleft-1
    if parent.cardturnsleft>0 then return end
    if #parent.drawpile==0 then parent.shuffle() end
    table.insert(parent.discardpile,parent.activecard)
    parent.activecard=table.remove(parent.drawpile)
    parent.cardturnsleft=3
end