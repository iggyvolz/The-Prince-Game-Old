return function(country,used_mercenaries)
  if not used_mercenaries then return end
  data.principalities[country].rebellion_cards=4
  table.insert(data.principalities[country].hooks.invade_success,function(n)
    data.principalities[country].rebellion_cards=4
    data.principalities[country].hooks.invade_success[n]=nil
  end)
end