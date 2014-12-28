return function(r,tbl,data)
  local function dn() end
  dn(r)
  if not data then tbl.log=tbl.log.."\n\nINVALID CLIENT" return "ERROR",{["fatal"]=true,["code"]=3,["msg"]="INVALID CLIENT"} end
  tbl.client=data
  tbl.log=tbl.log.."\n\nUSING CLIENT "..data
  return "OK",nil
end
