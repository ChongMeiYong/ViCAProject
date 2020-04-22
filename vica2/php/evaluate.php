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
$courseid = $_POST['courseid'];
$coursename = $_POST['coursename'];
$errors   = array();

$sql = "SELECT * FROM EVALUATE WHERE courseid = '$courseid' AND email = '$email' LIMIT 1";
$result = $conn->query($sql);
$evaluate = mysqli_fetch_assoc($result);

if($evaluate) {
    if( ($evaluate['courseid'] === $courseid) AND ($evaluate['email'] === $email)){
    array_push($errors, "Sorry, this course has been rated. Please rate for other course.");
    }
}

if(count($errors) == 0) {
    $query = "INSERT INTO EVALUATE(selected1, selected2, selected3, selected4, 
             selected5, selected6, selected7, email, courseid, coursename) VALUES ('$selected1',
             '$selected2','$selected3','$selected4','$selected5','$selected6',
             '$selected7','$email','$courseid','$coursename')";
    $conn->query($query);
    echo "success";
}else {
    echo "error";
}
?>

