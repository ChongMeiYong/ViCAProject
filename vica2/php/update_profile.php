<?php
error_reporting(0);
include_once("dbconnect.php");

$email = $_POST['email'];
$password = $_POST['password'];
$phone = $_POST['phone'];
$name = $_POST['name'];
$dob = $_POST['dob'];
$address = $_POST['address'];

$usersql = "SELECT * FROM USER WHERE EMAIL = '$email'";

if (isset($name) && (!empty($name))){
    $sql = "UPDATE USER SET NAME = '$name' WHERE EMAIL = '$email'";
}
if (isset($password) && (!empty($password))){
    $sql = "UPDATE USER SET PASSWORD = sha1($password) WHERE EMAIL = '$email'";
}
if (isset($phone) && (!empty($phone))){
    $sql = "UPDATE USER SET PHONE = '$phone' WHERE EMAIL = '$email'";
}
if (isset($dob) && (!empty($dob))){
    $sql = "UPDATE USER SET DOB = '$dob' WHERE EMAIL = '$email'";
}
if (isset($address) && (!empty($address))){
    $sql = "UPDATE USER SET ADDRESS = '$address' WHERE EMAIL = '$email'";
}

if ($conn->query($sql) === TRUE) {
    $result = $conn->query($usersql);
if ($result->num_rows > 0) {
        while ($row = $result ->fetch_assoc()){
        echo "success,".$row["NAME"].",".$row["EMAIL"].",".$row["PHONE"].",".$row["DOB"].",".$row["ADDRESS"];
        }
    }else{
        echo "failed,null,null,null,null.null";
    }
} else {
    echo "error";
}

$conn->close();
?>
