return function(tbl)
  return function(r)
    if r:wsupgrade() then
      local function scan(t)
        for i in pairs(t) do
          if type(t[i])=="table" then
            t[i]=scan(t[i])
          elseif type(t[i])=="function" then
            t[i]=nil
          end
        end
        return t
      end
      r:wswrite(require "pl.pretty".write(scan(tbl)))
      r:wsclose()
    else
      r.status=405
      r:puts("405 error - Please use webhooks.")
    end
    return apache2.DONE
  end
end
