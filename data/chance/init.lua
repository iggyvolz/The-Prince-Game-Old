local self={
    ["cards"] = {
        "a",
        "b",
        "c"
    },
    ["drawpile"] = { -- BOTTOM IS TOP OF PILE
    },
    ["discardpile"]=nil,
    ["activecard"] = nil,
    ["cardturnsleft"] = 3
}
function self.turnends() -- Called when turn ends
    self.cardturnsleft=self.cardturnsleft-1
    if self.cardturnsleft>0 then return end
    if #self.drawpile==0 then self.shuffle() end
    table.insert(self.discardpile,self.activecard)
    self.activecard=table.remove(self.drawpile)
    self.cardturnsleft=3
end
function self.shuffle() -- Shuffles all cards
    if self.discardpile == nil then self.discardpile=self.cards end -- INITIALIZATION
    self.drawpile={}
    while #self.discardpile ~=0 do
        table.insert(self.drawpile,table.remove(self.discardpile,math.random(#self.discardpile)))
    end
    self.discardpile={}
end
return self