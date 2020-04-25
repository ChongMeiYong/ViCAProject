<?php
$servername = "localhost";
$username 	= "myondbco_vicaAdmin";
$password 	= "hStpQcdI-DfM";
$dbname 	= "myondbco_vicaProject";
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>