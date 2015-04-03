return function(data,country,type)
  -- TODO - check if can invade
  if type//1~=type or type<1 or type>4 or (type==3 and data.chance.activecard ~= 8) then
    return false,"Invalid type!"
  end
  for i=1,#data.my_cards do
    if data.my_cards[i]==country then
      return false,"Already owned!"
    end
  end
  if not data.principalities[country] then
    return false,"Invalid country!"
  end
  local unownedprincipalitiesexist=false
  for _,v in pairs(data.principalities) do
    if not v.owner then unownedprincipalitiesexist=true break end
  end
  if data.principalities[country].owner and unownedprincipalitiesexist then
    return false,"Someone already owns this country!"
  end
  local cost=data.principalities[country].invasion*type
  if data.principalities[country].owner then
    local breakout
    for _,v in pairs(data.principalities) do
      if v.owner==data.principalities[country].owner then
        if data.principalities[country]~=v then
          breakout=true
          cost=cost*2
          break
        end
      end
    end
    if not breakout then cost=cost*3 end
  end
  if cost>data.my_money then
    return false,"Not enough money!"
  end
  data.my_money=data.my_money-cost
  if data.chance.cards[data.chance.cards.activecard] and data.chance.cards[data.chance.cards.activecard].invade then
    country,type=data.chance.cards[data.chance.cards.activecard].invade(country,type)
  end
  local dieroll=data.random(1,6)
  local okdierolls={{1},{nil,1,nil,1,nil,1},{1,1,1,1,1}}
  local dieresult=nil
  if data.chance.cards[data.chance.cards.activecard] and data.chance.cards[data.chance.cards.activecard].roll then
    local result=data.chance.cards[data.chance.cards.activecard].roll()
    if result==true then
      dieresult=true
    elseif result==false then -- Allow for
      dieresult=false
    end
  end
  if dieresult==nil then dieresult=okdierolls[type][dieroll] end
  if dieresult then
    if data.chance.cards[data.chance.cards.activecard] and data.chance.cards[data.chance.cards.activecard].invadesuccess then data.chance.cards[data.chance.cards.activecard].invadesuccess(country,type==4) end
    if data.principalities[country].invade_success then data.principalities[country].invadesuccess() end
    data.principalities[country].owner="me"
    table.insert(data.my_cards,country)
    return true,nil,dieroll
  end
  return false,"Bad roll",dieroll
end
