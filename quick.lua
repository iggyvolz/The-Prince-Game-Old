function quick(r)
  if r.hostname=="www.theprincegame.com" and r.uri:sub(1,4)=="/api" then r.headers_out[1]="HTTP/1.1 301 Moved Permanently" r.headers_out[2]="Location: https://theprincegame.com/api/"..r.unparsed_uri return apache2.DONE end
  if r.hostname=="theprincegame.com" and r.uri:sub(1,4)~="/api" then r.headers_out[1]="HTTP/1.1 301 Moved Permanently" r.headers_out[2]="Location: https://www.theprincegame.com"..r.unparsed_uri return apache2.DONE end
  return apache2.DECLINED
end
