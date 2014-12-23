return function(l)
    local path="/var/log/the_prince/"
    local num=1
    local function exists(f)
      local h=io.open(f,"r")
      if h then h:close() return true else return false end
    end
    while exists(path..num) do
      num=num+1
    end
    io.open(path..num, "w"):write(l):close()
    local h=io.open("/usr/local/The-Prince-Game/forums/common.php")
    if h then h:close() io.popen("php /usr/local/The-Prince-Game/log.php "..num) end
end
