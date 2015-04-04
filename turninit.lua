return function()
    --TODO check if can init turn
    local data,toreturn,toremove=require "data",{},{}
    for i=1,#data.my_cards do
        local thiscard={["card"]={}}
        thiscard.lose,thiscard.safe,thiscard.card[1],thiscard.card[2],thiscard.card[3],thiscard.card[4]=false,data.rebellion.draw(data.principalities[data.my_cards[i]].rebellion_cards)
        if not thiscard.safe then
            thiscard.dieroll=math.random(1,6)
            if thiscard.dieroll<data.rebellion.num then
                thiscard.lose=true
                table.insert(toremove,i)
            end
        end
        toreturn[data.my_cards[i]]=thiscard
    end
    for i=1,#toremove do
      print(i)
      print(table.remove(data.my_cards,toremove[i]-i+1))
    end
    for i=1,#data.my_cards do
        data.my_money=data.my_money+data.principalities[data.my_cards[i]].tribute
    end
    data.chance.turnends()
    return toreturn
end
