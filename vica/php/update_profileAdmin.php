<?php
error_reporting(0);
include_once("dbconnect.php");

$email = $_POST['email'];
$password = $_POST['password'];
$phone = $_POST['phone'];
$name = $_POST['name'];
$position = $_POST['position'];

$usersql = "SELECT * FROM ADMIN WHERE EMAIL = '$email'";

if (isset($name) && (!empty($name))){
    $sql = "UPDATE ADMIN SET NAME = '$name' WHERE EMAIL = '$email'";
}
if (isset($password) && (!empty($password))){
    $sql = "UPDATE ADMIN SET PASSWORD = sha1($password) WHERE EMAIL = '$email'";
}
if (isset($phone) && (!empty($phone))){
    $sql = "UPDATE ADMIN SET PHONE = '$phone' WHERE EMAIL = '$email'";
}
if (isset($position) && (!empty($phone))){
    $sql = "UPDATE ADMIN SET POSITION = '$position' WHERE EMAIL = '$email'";
}

if ($conn->query($sql) === TRUE) {
    $result = $conn->query($usersql);
if ($result->num_rows > 0) {
        while ($row = $result ->fetch_assoc()){
        echo "success,".$row["NAME"].",".$row["EMAIL"].",".$row["PHONE"].",".$row["POSITION"];
        }
    }else{
        echo "failed,null,null,null,null";
    }
} else {
    echo "error";
}

$conn->close();
?>
