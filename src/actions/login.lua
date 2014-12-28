return function(r,tbl,data)
  local db,err,statement,row,row2,uid
  if not data then return "ERROR",{["fatal"]=true,["code"]=4,["msg"]="INVALID SID"} end
  local h=io.open("/usr/local/The-Prince-Game/forums/common.php")
  if h then
    h:close()
    db,err=r:dbacquire("mysql", "host=127.0.0.1,user=root,pass=tdRp4ZrcQBcRAukCdiYL7HZxDLENXR,dbname=phpbb")
  else
    db,err=r:dbacquire("mysql", "host=127.0.0.1,user=root,pass=,dbname=phpbb")
  end
  if err then
    return "ERROR",{["fatal"]=true,["code"]=5,["msg"]="COULD NOT CONNECT TO DB"}
  end
  statement,err=db:prepare(r,"SELECT * FROM `phpbb_sessions` WHERE `session_id`=%s")
  if err then
    db:close()
    return "ERROR",{["fatal"]=true,["code"]=6,["msg"]="DB STATEMENT ERROR"}
  end
  statement:select(data)
  row=statement(0)[1]
  if not row then
    db:close()
    return "ERROR",{["fatal"]=true,["code"]=10,["msg"]="INVALD SID"}
  end
  uid=row["session_user_id"]
  if uid==1 or uid==nil then
    db:close()
    return "ERROR",{["fatal"]=true,["code"]=7,["msg"]="CANNOT LOG IN AS ANONYMOUS"}
  end
  statement,err=db:prepare(r,"SELECT * FROM `phpbb_users` WHERE `user_id`=%u")
  if err then
    db:close()
    return "ERROR",{["fatal"]=true,["code"]=8,["msg"]="DB STATEMENT ERROR"}
  end
  statement:select(uid)
  row2=statement(0)[1]
  tbl.username=row2["username"]
  if tbl.bans[tbl.username] then
    db:close()
    return "ERROR",{["fatal"]=true,["code"]=9,["msg"]="USER IS BANNED"}
  end
  tbl.log=tbl.log.."\n\nLOGGED IN AS "..tbl.username.."\n\nSESSION: "..require "pl.pretty".write(row).."\n\nUSER DATA: "..require "pl.pretty".write(row2)
  db:close()
  return "OK",nil
end
