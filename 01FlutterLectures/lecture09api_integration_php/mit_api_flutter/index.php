<?php
$hostname="localhost";
$username="root";
$password="";
$db="mit_api";

$conn= mysqli_connect($hostname, $username, $password,$db);

if (!$conn) {

die(json_encode(["message"=>"failed database"]));
}else{
    echo "success";
}


$name=$_POST["name"];
$email=$_POST["email"];
$pass=password_hash( $_POST["password"],PASSWORD_DEFAULT);


$sqlinsert="INSERT INTO `info`( `Name`, `Email`, `Password`) VALUES ('$name','$email','$pass')";
$res=mysqli_query($conn,$sqlinsert );

if ($res) {
    
echo json_encode(["message"=>$res?"successfully inserted":"error"]);

}
?>