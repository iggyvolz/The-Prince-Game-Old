return function(tbl,country,used_mercenaries)
  if used_mercenaries then tbl.data.principalities[country].rebellion_cards=4 end
end

-- TODO remove limit when country lost or invaded.
