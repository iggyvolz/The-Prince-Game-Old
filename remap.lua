function remap(r)
  if r.uri:sub(1,8)=="/forums/" or r.uri:sub(1,8)=="/forums?" or r.uri=="/forums" then r.filename="/usr/local/The-Prince-Game"..r.uri return apache2.OK end --Ignore forums
  if r.uri=="/" or r.uri:sub(1,2)=="/?" then r.filename="/usr/local/The-Prince-Game/index.html" return apache2.OK end
  r.filename="/usr/local/The-Prince-Game/go.lua"
  return apache2.OK
end
