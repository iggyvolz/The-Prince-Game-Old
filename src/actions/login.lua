return function(tbl,data)
  local db=tbl.db.conn
  local c,err,row,uid,row2
  if not data then return "ERROR",{["fatal"]=true,["code"]=4,["msg"]="INVALID SID"} end
  c,err=db:execute("SELECT * FROM `phpbb_sessions` WHERE `session_id`=\""..db:escape(data).."\"")
  if err then
    db:close()
    tbl.db.env:close()
    tbl.log=tbl.log.."\n\nDB ERROR: "..require "pl.pretty".write(err)
    return "ERROR",{["fatal"]=true,["code"]=6,["msg"]="DB STATEMENT ERROR"}
  end
  row=table.pack(c:fetch({},"a"))[1]
  if not row then
    db:close()
    tbl.db.env:close()
    tbl.log=tbl.log.."\n\nSID NOT FOUND"
    return "ERROR",{["fatal"]=true,["code"]=7,["msg"]="INVALID SID"}
  end
  uid=row.session_user_id
  if uid==1 or uid==nil then
    db:close()
    tbl.db.env:close()
    tbl.log=tbl.log.."\n\nANONYMOUS LOGIN ATTEMPTED"
    return "ERROR",{["fatal"]=true,["code"]=8,["msg"]="INVALID SID"}
  end
  c,err=db:execute("SELECT * FROM `phpbb_users` WHERE `user_id`="..db:escape(uid))
  if err then
    db:close()
    tbl.db.env:close()
    tbl.log=tbl.log.."\n\nINVALID UID"
    return "ERROR",{["fatal"]=true,["code"]=9,["msg"]="DB STATEMENT ERROR"}
  end
  row2=c:fetch({},"a")
  tbl.username=row2.username
  local function banned(u)
    for _,v in ipairs(tbl.bans) do
      if v == u then
        return true
      end
    end
  return false
  end
  if banned(tbl.username) then
    db:close()
    tbl.db.env:close()
    tbl.log=tbl.log.."\n\nUSER BANNED"
    return "ERROR",{["fatal"]=true,["code"]=10,["msg"]="USER IS BANNED"}
  end
  tbl.log=tbl.log.."\n\nLOGGED IN AS "..tbl.username.."\n\nSESSION: "..require "pl.pretty".write(row).."\n\nUSER DATA: "..require "pl.pretty".write(row2)
  db:close()
  return "OK",nil
end
