return function(tbl)
  return function(r)
    if r:wsupgrade() then
      local foo=tbl
      r:wswrite(require "pl.pretty".write(foo))
      r:wsclose()
    else
      r.status=405
      r:puts("405 error - Please use webhooks.")
    end
    return apache2.DONE
  end
end
