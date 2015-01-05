function quick()
  if uri:sub(1,34)=="https://www.theprincegame.com/api/" then headers_out={"HTTP/1.1 301 Moved Permanently","Location: https://theprincegame.com/api/"..uri:sub(35)} return apache2.DONE end
  if uri:sub(1,26)=="https://theprincegame.com/" and uri:sub(1,30) ~= "https://theprincegame.com/api/" then headers_out={"HTTP/1.1 301 Moved Permanently","Location: https://www.theprincegame.com/"..uri:sub(27)} return apache2.DONE end
  return apache2.DECLINED
end
