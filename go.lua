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
local address,port="127.0.0.1",1897
local udp = socket.udp()
udp:settimeout(30)
udp:setsockname(address, port)
local _,naddress,nport
repeat
  _,naddress,nport=udp:receivefrom()
until _
udp:setpeername(naddress,nport)
math.randomseed(os.time())
repeat
  data=udp:receive()
  print(data)
  local command,param1,param2=table.unpack(explode(" ",data))
  if command=="turninit" then
    udp:send(require "pl.pretty".write(require "turninit"()))
  elseif command=="invade" then
    udp:send(require "pl.pretty".write(table.pack(require "invade"(require "data",param1,tonumber(param2)))))
  end
until false
--[[
while running do
  while not data do
    for i=1,nreceived do if false then print(i) end udp:receivefrom() end
    data, msg_or_ip, port_or_nil = udp:receivefrom()
  end
  print(data)
  local num,command,param1,param2=table.unpack(explode(" ",data))
  if not received[num] then
    received[num]=1
    print(command,param1,param2)
    if command=="turninit" then
      udp:sendto(require "pl.pretty".write(require "turninit"()), msg_or_ip,  port_or_nil)
    elseif command=="invade" then
      udp:sendto(require "pl.pretty".write(table.pack(require "invade"(require "data",param1,tonumber(param2)))), msg_or_ip,  port_or_nil)
    end
  end
  socket.sleep(1)
end
]]
