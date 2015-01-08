return function(tbl,player)
  local tribute=0
  local papal_tribute=0
  local excluded={"england","ottoman_empire","venice","egypt","morocco","papal_states","naples"}
  for i=1,#tbl.data.players[player].states do
    tribute=tribute+tbl.data.principalities[tbl.data.players[player].states[i]].tribute
    if not excluded[tbl.data.players[player].states[i]] then papal_tribute=tribute+(0.1*tbl.data.principalities[tbl.data.players[player].states[i]].tribute) end
  end
  papal_tribute=math.ceil(papal_tribute/100)*100
  tribute=tribute-papal_tribute
  tbl.data.players[player].money=tbl.data.players[player].money+tribute
  local papal_owner
  for i=1,4 do
    for j=1,#tbl.dta.players[i].states do
      if tbl.data.players[i].states[j].name=="papal_states" then papal_owner=i end
    end
  end
  if papal_owner then tbl.data.players[papal_owner].money=tbl.data.players[papal_owner].money+papal_tribute end
  return false
end
