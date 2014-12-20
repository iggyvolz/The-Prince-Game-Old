return function(tbl,states)
  local tribute=0
  local papal=0
  local excluded={"england","ottoman_empire","venice","egypt","morocco","papal_states","naples"}
  for i,#states do
    tribute=tribute+tbl.data.principalities[states[i]].tribute
    if not excluded[states[i]] then papal=tribute+(0.1*tbl.data.principalities[states[i]].tribute)
  end
  papal=math.ceil(papal/100)*100
  tribute=tribute-papal
end
