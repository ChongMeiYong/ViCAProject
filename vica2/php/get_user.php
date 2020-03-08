<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$name = $_POST['name'];
$password = $_POST['password'];
$phone = $_POST['phone'];
$dob = $_POST['dob'];
$address = $_POST['address'];

$sql = "SELECT * FROM USER WHERE EMAIL = '$email'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo "success,".$row["name"].",".$row["email"].",".$row["password"].",".$row["phone"].",".$row["dob"].",".$row["address"];
    }
}else{
    echo "failed,null,null,null,null,null";
}