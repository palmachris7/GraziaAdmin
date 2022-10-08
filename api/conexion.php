<?php

$mysql=new mysqli("localhost","root","root","grazia");
if($mysql->connect_error){
   die("Error de conexion");
}
else{
   echo "Conexion exitosa";
}


 ?>