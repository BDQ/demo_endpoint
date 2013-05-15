<?php
$message = json_decode(file_get_contents('php://input'));

$response = array(
  'message_id' => $message->message_id
);

header('Content-type: application/json');
echo json_encode($response);
?>
