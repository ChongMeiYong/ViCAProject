<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM COURSE WHERE OWNER = '$email'";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["course"] = array();
    while ($row = $result ->fetch_assoc()){
        $courselist = array();
        $courselist[id] = $row["ID"];
        $courselist[cname] = $row["NAME"];
        $courselist[owner] = $row["OWNER"];
        $courselist[descp] = $row["DESCP"];
        $courselist[duration] = $row["DURATION"];
        $courselist[image] = $row["IMAGE"];
        array_push($response["course"], $courselist);    
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>