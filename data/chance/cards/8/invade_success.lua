return function(country,used_mercenaries)
  if not used_mercenaries then return end
  data.principalities[country].rebellion_cards=4
  data.principalities[country].invade_success=function()
    data.principalities[country].rebellion_cards=2
    data.principalities[country].invade_success=nil
  end
end
