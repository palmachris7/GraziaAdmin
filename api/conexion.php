<?php
//require_once "config/global.php";
//$conexion = new mysqli(DB_HOST,DB_USERNAME,DB_PASSWORD,DB_NAME);
$mysql=new mysqli("localhost","root","root","grazia");
if($mysql->connect_error){
    die("Error de conexion");
}
else{
    echo "Conexion exitosa";
}