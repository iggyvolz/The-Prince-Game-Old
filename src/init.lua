return function(tbl)
  return function(r)
    local json=require "json"
    if r:wsupgrade() then
      local function copy(obj, seen)
        if type(obj) ~= 'table' then return obj end
        if seen and seen[obj] then return seen[obj] end
        local s = seen or {}
        local res = setmetatable({}, getmetatable(obj))
        s[obj] = res
        for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
        return res
      end
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
      local function scan(_t)
        local t=copy(_t)
        -- Delete protected directories from client sending
        t.src=nil
        return doscan(t)
      end
      local conts=json.encode(scan(tbl))
      r:wswrite(conts)
      tbl.log=tbl.log.."SERVER: "..conts
      local get=r:wsread() or nil
      tbl.log=tbl.log.."CLIENT: "..get
      r:wsclose()
      tbl.src.log(tbl.log)
    else
      r.status=405
      r:puts("405 error - Please use webhooks.")
    end
    return apache2.DONE
  end
end
