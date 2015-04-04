return function()
  for k in data.principalities do
    data.principalities[k].prior_rebellion_cards=data.principalities[k].rebellion_cards
    data.principalities[k].rebellion_cards=1
  end
end
