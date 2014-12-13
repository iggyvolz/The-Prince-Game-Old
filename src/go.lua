local self=function(r)
  r:puts(require "pl.pretty".write(tbl))
  return apache2.DONE
end
return self
