<?php
$conts=json_decode(file_get_contents($argv[1]));
foreach($conts as $a=>$b){$GLOBALS[$a]=$b;}
define("IN_PHPBB",true);
require "/usr/local/The-Prince-Game/forums/common.php";
require "/usr/local/The-Prince-Game/forums/includes/functions_posting.php";
generate_text_for_storage($subject, $uid, $bitfield, $options, false, false, false);
generate_text_for_storage($message, $uid, $bitfield, $options, false, false, false);
$data["message_md5"]=md5($data["message"]);
$data["bbcode_bitfield"]=$bitfield;
$data["bbcode_uid"]=$uid;
$result = $db->sql_query($sql);
$row = $db->sql_fetchrow($result);
$db->sql_freeresult($result);
$user->data = array_merge($user->data, $row);
$auth->acl($user->data);
$user->ip = '0.0.0.0';
var_dump(submit_post($mode,$subject,$username,$topic_type,$poll,$data));
