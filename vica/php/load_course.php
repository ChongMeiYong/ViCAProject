<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM COURSE ORDER BY ID DESC";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["course"] = array();
    while ($row = $result ->fetch_assoc()){
        $courselist = array();
        $courselist[id] = $row["ID"];
        $courselist[name] = $row["NAME"];
        $courselist[descp] = $row["DESCP"];
        $courselist[duration] = $row["DURATION"];
        $courselist[image] = $row["IMAGE"];
        
        array_push($response["course"], $courselist);    
   }
    echo json_encode($response);
}else{
    echo "nodata";
}

/*function distance($lat1, $lon1, $lat2, $lon2) {
   $pi80 = M_PI / 180;
    $lat1 *= $pi80;
    $lon1 *= $pi80;
    $lat2 *= $pi80;
    $lon2 *= $pi80;

    $r = 6372.797; // mean radius of Earth in km
    $dlat = $lat2 - $lat1;
    $dlon = $lon2 - $lon1;
    $a = sin($dlat / 2) * sin($dlat / 2) + cos($lat1) * cos($lat2) * sin($dlon / 2) * sin($dlon / 2);
    $c = 2 * atan2(sqrt($a), sqrt(1 - $a));
    $km = $r * $c;

    //echo '<br/>'.$km;
    return $km;
}*/

?>