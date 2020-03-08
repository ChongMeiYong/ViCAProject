<?php
//error_reporting(0);
include_once ("dbconnect.php");
$selected1 = $_POST['selected1'];
$selected2 = $_POST['selected2'];
$selected3 = $_POST['selected3'];
$selected4 = $_POST['selected4'];
$selected5 = $_POST['selected5'];
$selected6 = $_POST['selected6'];
$selected7 = $_POST['selected7'];
$email = $_POST['email'];

$sqlinsert = "INSERT INTO EVALUATE(selected1, selected2, selected3, selected4, 
             selected5, selected6, selected7, email) VALUES ('$selected1',
             '$selected2','$selected3','$selected4','$selected5','$selected6',
             '$selected7','$email')";
if ($conn->query($sqlinsert) === TRUE) {
    echo "Rate Successful";
} else {
    echo "Please rate for all question!";
}
?>