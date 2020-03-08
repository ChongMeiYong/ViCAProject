<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM USER";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["user"] = array();
    while ($row = $result ->fetch_assoc()){
        $userlist = array();
        $userlist[name] = $row["name"];
        $userlist[email] = $row["email"];
        $userlist[phone] = $row["phone"];
        $userlist[dob] = $row["dob"];
        $userlist[address] = $row["address"];
        //$courselist[userenroll] = $row["userenroll"];
        //$courselist[postdate] = date_format(date_create($row["postdate"]), 'd///m/Y h:i:s');
        
        array_push($response["user"], $userlist);    
   }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>

