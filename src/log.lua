return function(l)
  --local md5=require "md5"
  local json=require "json"
  local phpcode="$conts=json_decode(file_get_contents($argv[1]));foreach($conts as $a=>$b){$GLOBALS[$a]=$b;} define(\"IN_PHPBB\",true);require \"/usr/local/The-Prince-Game/forums/common.php\";require \"/usr/local/The-Prince-Game/forums/includes/functions_posting.php\";generate_text_for_storage($subject, $uid, $bitfield, $options, false, false, false);generate_text_for_storage($message, $uid, $bitfield, $options, false, false, false);$data[\"message_md5\"]=md5($data[\"message\"]);$data[\"bbcode_bitfield\"]=$bitfield;$data[\"bbcode_uid\"]=$uid;$result = $db->sql_query($sql);$row = $db->sql_fetchrow($result);$db->sql_freeresult($result);$user->data = array_merge($user->data, $row);$auth->acl($user->data);$user->ip = '0.0.0.0';var_dump(submit_post($mode,$subject,$username,$topic_type,$poll,$data));"
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
  apache2.info1(io.popen("php -r '"..phpcode.."' "..path..num):read("*a"))
  --print(phpcode)
  --print(path..num)
end
