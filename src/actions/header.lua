return function(tbl,data)
  if not data then tbl.log=tbl.log.."\n\nINVALID CLIENT "..data return "ERROR",{["fatal"]=true,["code"]=3,["msg"]="INVALID CLIENT"} end
  tbl.client=data
  tbl.log=tbl.log.."\n\nUSING CLIENT "..data
  return "OK",nil
end