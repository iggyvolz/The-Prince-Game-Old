local self=function(r)
  if r.url:sub(1,-5)=="/forums" then return apache2.DECLINED end --Ignore forums
  r:puts(require "pl.pretty".write(tbl))
  return apache2.DONE
end
return self
