<?php
error_reporting(0);
include_once("dbconnect.php");

$name = $_POST['name'];
$email = $_POST['email'];
$password = $_POST['password'];
$phone = $_POST['phone'];
$dob = $_POST['dob'];
$address = $_POST['address'];

$usersql = "SELECT * FROM USER WHERE email = '$email'";

if (isset($name) && (!empty($name))){
    $sql = "UPDATE USER SET name = '$name' WHERE email = '$email'";
}
if (isset($password) && (!empty($password))){
    $sql = "UPDATE USER SET password = sha1($password) WHERE email = '$email'";
}
if (isset($phone) && (!empty($phone))){
    $sql = "UPDATE USER SET phone = '$phone' WHERE email = '$email'";
}
if (isset($dob) && (!empty($dob))){
    $sql = "UPDATE USER SET dob = '$dob' WHERE email = '$email'";
}
if (isset($address) && (!empty($address))){
    $sql = "UPDATE USER SET address = '$address' WHERE email = '$email'";
}
if ($conn->query($sql) === TRUE) {
    $result = $conn->query($usersql);
if ($result->num_rows > 0) {
        while ($row = $result ->fetch_assoc()){
        echo "success,".$row["name"].",".$row["email"].",".$row["phone"].",".$row["dob"].",".$row["address"];
        }
    }else{
        echo "failed,null,null,null,null,null,null";
    }
} else {
    echo "error";
}

$conn->close();
?>