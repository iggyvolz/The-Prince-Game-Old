return function(env)
    --TODO check if can init turn
    local data=env.data
    local toreturn={}
    for i=1,#data.my_cards do
        local thiscard={}
        thiscard.lose,thiscard.safe,thiscard.card[1],thiscard.card[2],thiscard.card[3],thiscard.card[4]=false,data.rebellion.draw(data.principalities[data.my_cards[i]].rebellion_cards)
        if not thiscard.safe then
            thiscard.dieroll=math.random(1,6)
            if thiscard.dieroll<data.rebellion_num then
                thiscard.lose=true
                table.unpack(data.my_cards,i)
            end
        end
    end
    return toreturn
end