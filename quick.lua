function quick(r)
  r:debug(r.uri)
  if r.uri:sub(1,34)=="https://www.theprincegame.com/api/" then r.headers_out={"HTTP/1.1 301 Moved Permanently","Location: https://theprincegame.com/api/"..r.uri:sub(35)} return apache2.DONE end
  if r.uri:sub(1,26)=="https://theprincegame.com/" and r.uri:sub(1,30) ~= "https://theprincegame.com/api/" then r.headers_out={"HTTP/1.1 301 Moved Permanently","Location: https://www.theprincegame.com/"..r.uri:sub(27)} return apache2.DONE end
  return apache2.DECLINED
end
