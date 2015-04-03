return function(player)
  local tribute=0
  local papal_tribute=0
  local excluded={"england","ottoman_empire","venice","egypt","morocco","papal_states","naples"}
  for i=1,#data.players[player].states do
    tribute=tribute+data.principalities[data.players[player].states[i]].tribute
    if not excluded[data.players[player].states[i]] then papal_tribute=tribute+(0.1*data.principalities[data.players[player].states[i]].tribute) end
  end
  papal_tribute=math.ceil(papal_tribute/100)*100
  tribute=tribute-papal_tribute
  data.players[player].money=data.players[player].money+tribute
  local papal_owner
  for i=1,4 do
    for j=1,#data.players[i].states do
      if data.players[i].states[j].name=="papal_states" then papal_owner=i end
    end
  end
  if papal_owner then data.players[papal_owner].money=data.players[papal_owner].money+papal_tribute end
  return false
end
