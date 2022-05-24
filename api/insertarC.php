<?php
if($_SERVER["REQUEST_METHOD"]=="POST"){
    require_once 'conexion.php';
    $nombre=$_POST["nombre"];
    $email=$_POST["email"];
    $query="INSERT INTO persona 
              (tipo_persona,     nombre,     tipo_documento,     num_documento,      direccion,      zona,       telefono,       email) 
    VALUES('1','".$nombre."','1','Cliente movil','Cliente Movil','0','Cliente movil','".$email."')";
    $resultado=$mysql->query($query);
    if($resultado==true){
        echo "El cliente se inserto de forma exitosa";
    }else{
        echo "Error al insertar cliente";
    }
}


