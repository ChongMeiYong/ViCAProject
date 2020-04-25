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
        $courselist = array();
        $courselist[selected1] = $row["selected1"];
        $courselist[selected2] = $row["selected2"];
        $courselist[selected3] = $row["selected3"];
        $courselist[selected4] = $row["selected4"];
        $courselist[selected5] = $row["selected5"];
        $courselist[selected6] = $row["selected6"];
        $courselist[selected7] = $row["selected7"];
        
        array_push($response["course"], $courselist);    
   }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>

