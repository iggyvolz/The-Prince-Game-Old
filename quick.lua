function quick()
  --if r.hostname=="www.theprincegame.com" and r.uri:sub(1,4)=="/api" then r:puts("<head><meta http-equiv=\"refresh\" content=\"0;url=https://theprincegame.com/api/"..r.unparsed_uri.."\"></head>") return apache2.DONE end
  if r.hostname=="theprincegame.com" and r.uri:sub(1,4)~="/api" then r:puts("<head><meta http-equiv=\"refresh\" content=\"0;url=https://www.theprincegame.com"..r.unparsed_uri.."\"></head>") return apache2.DONE end
  return apache2.DECLINED
end
