local self={
    -- TRUE = safe, FALSE = rebellion
    -- LAST ELEMENTS ARE TOP OF DECK
    ["drawpile"] = {
    },
    ["discardpile"] = {
    },
    ["rebellioncount"] = 3,
    ["safecount"] = 17
}
function self.shuffle() -- Shuffles all cards
    self.drawpile={}
    local rebellioncount=self.rebellioncount
    local safecount=self.safecount
    for i=1,self.rebellioncount+self.safecount do
        if math.random(rebellioncount+safecount)>rebellioncount then
            safecount=safecount-1
            table.insert(self.drawpile,true)
        else
            rebellioncount=rebellioncount-1
            table.insert(self.drawpile,false)
        end
    end
    self.discardpile={}
end
function self.draw(x) -- Draws x (int) cards, returns x+1 arguments (overall status (e.g. all cards are true then true else false) then all cards in order)
    local status=true
    local drawn={}
    for i=1,x do
        if #self.drawpile == 0 then self.shuffle() end
        if not self.drawpile[#self.drawpile] and status then status=false end
        table.insert(drawn,table.remove(self.drawpile))
    end
    return status,unpack(drawn)
end
self.shuffle()
return self