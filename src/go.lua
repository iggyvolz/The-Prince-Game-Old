local self=function(r)
  if r.uri:sub(1,8)=="/forums/" or r.uri:sub(1,8)=="/forums?" or r.uri=="/forums" then return apache2.DECLINED end --Ignore forums
  r:puts(require "pl.pretty".write(tbl))
  return apache2.DONE
end
return self
