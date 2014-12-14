function remap(r)
  if r.uri:sub(1,8)=="/forums/" or r.uri:sub(1,8)=="/forums?" or r.uri=="/forums" then r.filename="/usr/local/The-Prince-Game"..r.uri return apache2.OK end --Ignore forums
  r.filename="/usr/local/The-Prince-Game/go.lua"
  return apache2.OK
end
