<?php
$msg=json_decode(file_get_contents("php://input"))->item->message->message;
$data="<p>@banish (user) - bans (user)</p>@unbanish (user) - unbans (user)</p><p>@banlist [quotes] - displays banlist, or banlist with quotes if quotes included in message</p><p>@isbanished (user) - returns if user is banned or not</p>";
define("ROOM_NAME","The Prince");
define("ROOM_ID",1052690);
define("TOKEN","6fEaJ9afkF23XndQnWE4thaOAAUZldKF0hw7LaiR");
list($rid,$token)=[ROOM_ID,TOKEN];
$url = "https://api.hipchat.com/v2/room/$rid/notification?auth_token=$token";
$options = array(
  'auth_token' => $token,
  'color' => 'green',
  'message' => "$data",
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
?>
