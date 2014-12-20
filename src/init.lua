local json=require "json"
return function(tbl)
  return function(r)
    if r:wsupgrade() then
      local function doscan(t)
        for i in pairs(t) do
          if type(t[i])=="table" then
            t[i]=doscan(t[i])
          elseif type(t[i])=="function" then
            t[i]=nil
          end
        end
        return t
      end
      local function scan(t)
        -- Delete protected directories from client sending
        t.src=nil
        return doscan(t)
      end
      r:wswrite(json.encode(scan(tbl)))
      r:wsclose()
    else
      r.status=405
      r:puts("405 error - Please use webhooks.")
    end
    return apache2.DONE
  end
end
