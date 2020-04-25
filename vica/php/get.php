<?php

$servername = "localhost";
$username 	= "myondbco_vicaAdmin";
$password 	= "hStpQcdI-DfM";
$dbname 	= "myondbco_vicaProject";
 
    // we will get actions from the app to do operations in the database...
    $action = $_POST["action"];
     
    // Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($conn->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
    }
 
    // If connection is OK...
 
    // Get all employee records from the database
    $in_data = json_decode($_GET['data'], true);
if($in_data['command'] === "get_courses")
{
  $result = mysqli_query($connection, "SELECT * FROM COURSE;");
  if($result)
  {
    $data = mysqli_fetch_all($result, MYSQLI_ASSOC);
    echo json_encode($data);
  }
}
?>