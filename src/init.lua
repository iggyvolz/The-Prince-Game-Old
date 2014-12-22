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
      r:wswrite(json.encode({["action"]="INIT",["data"]=scan(tbl)}))
      local get=json.decode(r:wsread()) or nil
      while get do
        if tbl.src.actions[get.action] then
          local conts,err=tbl.src.actions[get.action].run(get.data)
          tbl.log=tbl.log.."\n\nSERVER: "..json.encode(conts)
          if err then tbl.log=tbl.log.."\n\nERROR: "..json.encode(err) end
          r:wswrite(json.encode({["action"]=get.action,["data"]=conts,["err"]=err}))
          if err then if err.fatal then tbl.log=tbl.log.."\n\nFATAL ERROR - CLOSING CONNECTION" end end
        else
          tbl.log=tbl.log.."\n\nACTION NOT RECOGNIZED: \""..get.action.."\" - CLOSING CONNECTION"
        end
        get=json.decode(r:wsread()) or nil
      end
      r:wsclose()
      tbl.src.log(tbl.log)
    else
      r.status=405
      r:puts("405 error - Please use webhooks.")
    end
    return apache2.DONE
  end
end
