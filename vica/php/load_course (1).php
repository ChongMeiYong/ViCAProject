<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM COURSE WHERE userenroll = '$email'";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["course"] = array();
    while ($row = $result ->fetch_assoc()){
        $courselist = array();
        $courselist[courseid] = $row["courseid"];
        $courselist[coursename] = $row["coursename"];
        $courselist[courseduration] = $row["courseduration"];
        $courselist[coursedes] = $row["coursedes"];
        $courselist[courseimage] = $row["courseimage"];
        $courselist[userenroll] = $row["userenroll"];
        //$courselist[postdate] = date_format(date_create($row["postdate"]), 'd///m/Y h:i:s');
        
        array_push($response["course"], $courselist);    
   }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>