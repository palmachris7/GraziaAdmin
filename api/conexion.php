<?php
/*
$mysql=new mysqli("localhost","root","root","grazia");
if($mysql->connect_error){
   die("Error de conexion");
}
else{
   echo "Conexion exitosa";
}

*/
$i0 = new mysqli(base64_decode('bG9jYWxob3N0'), base64_decode('cm9vdA=='), base64_decode('cm9vdA=='), base64_decode('Z3Jhemlh'));
if ($i0->connect_error) {
    die(base64_decode('RXJyb3IgZGUgY29uZXhpb24='));
} else {
    echo base64_decode('Q29uZXhpb24gZXhpdG9zYQ==');
} ?>