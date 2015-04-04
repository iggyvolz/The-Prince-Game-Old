local function explode(div,str) -- credit: http://richard.warburton.it
  if (div=='') then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end
local socket = require "socket"
local udp = socket.udp()
local running=true
local msg_or_ip,port_or_nil
udp:settimeout(0)
udp:setsockname('127.0.0.1', 1897)
while running do
  while not data do
    data, msg_or_ip, port_or_nil = udp:receivefrom()
  end
  local command,param1,param2=table.unpack(explode(" ",data))
  print(command,param1,param2)
  if command=="turninit" then
    udp:sendto(require "pl.pretty".write(require "turninit"()), msg_or_ip,  port_or_nil)
  elseif command=="invade" then
    udp:sendto(require "pl.pretty".write(table.pack(require "invade"(require "data",param1,tonumber(param2)))), msg_or_ip,  port_or_nil)
  end
end
