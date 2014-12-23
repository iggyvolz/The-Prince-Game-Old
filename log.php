<?php
$n=$argv[1];
$phpbb_root_path="/usr/local/The-Prince-Game/forums/";
$phpEx="php";
$mode="post";
$subject="Log #".$n;
$message=file_get_contents("/var/log/the_prince/$n");
$username="The_Prince_Bot";
$uid=48;
$bitfield="";
$options="";
$topic_type=0;
$poll=null;
$sql="SELECT * FROM phpbb_users WHERE user_id = 48";
$data=["forum_id"=>7,"topic_title"=>"Log #$n","icon_id"=>false,"enable_bbcode"=>false,"enable_smilies"=>false,"enable_urls"=>false,"enable_sig"=>false,"message"=>$message,"message_md5"=>null,
"bbcode_bitfield"=>null,"bbcode_uid"=>null,"post_edit_locked"=>0,"topic_title"=>"Log #$n","notify_set"=>false,"notify"=>false,"post_time"=>0,"enable_indexing"=>false,"force_visibility"=>true];
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
submit_post($mode,$subject,$username,$topic_type,$poll,$data);
$token="gqEC5ltd7fDKdbjFMYC5A9TOxlDJWZAa2Ppwy5uw";
$url = "https://api.hipchat.com/v2/room/1052690/notification?auth_token=$token";
$options = array(
  'auth_token' => $token,
  'color' => 'green',
  'message' => "<h3>$subject</h3>$message",
  'notify' => true,
  'message_format' => 'html'
);
$options = json_encode($options);
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
curl_setopt($ch, CURLOPT_POSTFIELDS, $options);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, array(
  'Content-Type: application/json',
  'Content-Length: ' . strlen($options))
);
$var = curl_exec($ch);
