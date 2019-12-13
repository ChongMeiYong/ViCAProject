<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$password = $_POST['password'];

$sql = "SELECT * FROM ADMIN WHERE EMAIL = '$email' AND PASSWORD = '$password' AND VERIFY ='1'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo "success,".$row["NAME"].",".$row["EMAIL"].",".$row["PHONE"];
    }
}else{
    echo "failed,null,null,null,null";
}