return function(tbl,country,used_mercenaries)
  if not used_mercenaries then return end
  tbl.data.principalities[country].rebellion_cards=4
  table.insert(tbl.data.principalities[country].hooks.invade_success,function(self)
    tbl.data.principalities[country].rebellion_cards=4
    self=nil
  end)
end