return function(x) -- Draws x (int) cards, returns x+1 arguments (overall status (e.g. all cards are true then true else false) then all cards in order)
    local status=true
    local drawn={}
    for i=1,x do
        if #self.drawpile == 0 then self.shuffle() end
        if not self.drawpile[#self.drawpile] and status then status=false end
        table.insert(drawn,table.remove(self.drawpile))
    end
    return status,unpack(drawn)
end