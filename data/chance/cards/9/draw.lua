return function(tbl)
  for k in tbl.data.principalities do
    tbl.data.principalities[k].prior_rebellion_cards=tbl.data.principalities[k].rebellion_cards
    tbl.data.principalities[k].rebellion_cards=1
  end
end
