<?php
//error_reporting(0);
include_once ("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$password = sha1($_POST['password']);
$phone = $_POST['phone'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);

$sqlinsert = "INSERT INTO USER(NAME,EMAIL,PASSWORD,PHONE,VERIFY) VALUES ('$name','$email','$password','$phone','1')";
if ($conn->query($sqlinsert) === TRUE) {
    $path = '../profile/'.$email.'.jpg';
    file_put_contents($path, $decoded_string);
    sendEmail($email);
    echo "success";
} else {
    echo "Email Registered! Please try again";
}

function sendEmail($email) {
    $to      = $email; 
    $subject = 'Verification for Login'; 
    $message = 'http://myondb/vicaProject/php/verify.php?email='.$email; 
    $headers = 'From: noreply@vica.com.my' . "\r\n" . 
    'Reply-To: '.$email . "\r\n" . 
    'X-Mailer: PHP/' . phpversion(); 
    mail($to, $subject, $message, $headers); 
}
?>