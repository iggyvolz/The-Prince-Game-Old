local function s(t)
  local d={["s"]=0,["p"]="AM",["m"]=0,["y"]=0,["h"]=0,["i"]=0}
  d.year=2015
  t=t-1420088400
  d.d=math.floor(t/86400)
  d.s=t-d.d*86400

  for x,i in pairs({31,28,31,30,31,30,31,31,30,31,30,31}) do
    d.d=d.d+(x*0)
    if d.d<i then
      break
    else
      d.d=d.d-i
      d.m=d.m+1
    end
  end
  d.m=d.m+1
  d.d=d.d+1
  if d.s>43199 then
    d.s=d.s-43200
    d.p="PM"
  end
  d.i=math.floor(d.s/60)
  d.s=d.s-d.i*60
  d.h=math.floor(d.i/60)
  d.i=d.i-d.h*60
  return d.m.."/"..d.d.."/"..d.y.." "..d.h..":"..d.i..":"..d.s.." "..d.p.." EASTERN TIME"
end
return "LOG BEGINS AT "..s(os.time())
