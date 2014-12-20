return function(l,r)
  --local md5=require "md5"
  local json=require "json"
  local function exists(f)
    local h=io.open(f,"r")
    if h then h:close() return true else return false end
  end
  local path="/var/log/the_prince/"
  local num=1
  while exists(path..num) do
    num=num+1
  end
  local globals={
    ["phpbb_root_path"]="./",
    ["phpEx"]="php",
    ["mode"]="post",
    ["subject"]="Log #"..num,
    ["message"]=l,
    ["username"]="The_Prince_Bot",
    ["uid"]=48,
    ["bitfield"]="",
    ["options"]="",
    ["topic_type"]=0,
    ["poll"]=nil,
    ["data"]={
      ["forum_id"]=7,
      ["topic_title"]="Log #"..num,
      ["icon_id"]=false,
      ["enable_bbcode"]=false,
      ["enable_smilies"]=false,
      ["enable_urls"]=false,
      ["enable_sid"]=false,
      ["message"]=l,
      ["message_md5"]=nil, -- SET FROM md5($data["message"])
      ["bbcode_bitfield"]=nil, -- SET FROM $bitfield
      ["bbcode_uid"]=nil, -- SET FROM $uid
      ["post_edit_locked"]=0,
      ["topic_title"]="Log #"..num,
      ["notify_set"]=false,
      ["notify"]=false,
      ["post_time"]=0,
      ["enable_indexing"]=true,
      ["force_visibility"]=true
    },
    ["sql"]="SELECT * FROM phpbb_users WHERE user_id = 48"
  }
  io.open(path..num, "w"):write(json.encode(globals)):close()
  r:trace1(io.popen("cd /usr/local/The-Prince-Game;php log.php "..path..num.." 2>&1"):read("*a"))
  --print(phpcode)
  --print(path..num)
end
