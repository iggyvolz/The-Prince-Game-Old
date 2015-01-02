local p
local h=io.open("/usr/local/The-Prince-Game/forums/common.php")
if h then h:close() p="tdRp4ZrcQBcRAukCdiYL7HZxDLENXR" end
local e=require "luasql.mysql".mysql()
local c=e:connect("phpbb","root",p)
c:setautocommit(false) -- Explicitly commit
return {["conn"]=c,["env"]=e}
