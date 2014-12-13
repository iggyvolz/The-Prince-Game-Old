local self=function(r)
  r:puts(require "pl.pretty".write(tbl))
end
return self
