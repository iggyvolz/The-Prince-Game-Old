return function(tbl,country)
  if country ~="papal_states" then return false
  tbl.data.principalities.papal_states.invasion=500
end
