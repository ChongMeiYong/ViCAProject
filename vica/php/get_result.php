<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$courseid =$_POST['courseid'];

$sql = "SELECT * FROM EVALUATE WHERE email = '$email' AND courseid = '$courseid' ";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["course"] = array();
    while ($row = $result ->fetch_assoc()){
        array_push($response["course"], "s");
        array_push($response["course"], $row["selected1"]);
        array_push($response["course"], $row["selected2"]);
        array_push($response["course"], $row["selected3"]);
        array_push($response["course"], $row["selected4"]);
        array_push($response["course"], $row["selected5"]);
        array_push($response["course"], $row["selected6"]);
        array_push($response["course"], $row["selected7"]);
    }
    echo json_encode($response);
}else{
    echo "nodata,null,null,null,null,null,null,null";
}
?>

