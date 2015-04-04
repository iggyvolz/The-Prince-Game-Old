return function()
  for k in data.principalities do
    data.principalities[k].rebellion_cards=data.principalities[k].prior_rebellion_cards
  end
end
