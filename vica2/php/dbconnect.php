<?php
$servername = "localhost";
$username 	= "myondbco_vicaAdmin";
$password 	= "~Z8fZ59(aDh~";
$dbname 	= "myondbco_vicaProject";
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>