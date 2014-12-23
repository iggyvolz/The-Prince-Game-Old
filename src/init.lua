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
      tbl.log=tbl.log.."\n\nFROM IP ADDRESS "..r.useragent_ip
      while true do
        local conts=r:wsread() or nil
        tbl.log=tbl.log.."\n\nCLIENT: "..conts
        if not conts then tbl.log=tbl.log.."\n\nCONNECTION CLOSED BY CLIENT" break end
        local ok,get=pcall(function() return json.decode(conts) or nil end)
        if not ok then tbl.log=tbl.log.."\n\nJSON DECODING FAILED: "..get r:wswrite(json.encode({["action"]=get.action,["err"]={["msg"]="INVALID JSON",["fatal"]=true,["code"]=1}})) break end
        if tbl.src.actions[get.action or ""] then
          local conts,err=tbl.src.actions[get.action](tbl,get.data)
          tbl.log=tbl.log.."\n\nSERVER: "..json.encode(conts)
          if err then tbl.log=tbl.log.."\n\nERROR: "..json.encode(err) end
          r:wswrite(json.encode({["action"]=get.action,["data"]=conts,["err"]=err}))
          if err then if err.fatal then tbl.log=tbl.log.."\n\nFATAL ERROR - CLOSING CONNECTION" break end end
        else
          tbl.log=tbl.log.."\n\nACTION NOT RECOGNIZED: \""..(get.action or "").."\" - CLOSING CONNECTION"
          r:wswrite(json.encode({["action"]=(get.action or ""),["err"]={["msg"]="ACTION NOT FOUND",["fatal"]=true,["code"]=2}}))
          break
        end
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
