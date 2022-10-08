<?php
if($_SERVER['REQUEST_METHOD']=='POST'){
    include_once 'conexion.php';
    $email=$_POST['email'];
    $telefono=$_POST['telefono'];
    $query="UPDATE persona SET telefono='".$telefono."' WHERE email='".$email."'";
    $resultado=$mysql->query($query);
    if($mysql->affected_rows>0 && $resultado==true){
        echo "El cliente se edito exitosamente";

    }else{
        echo "Error al editar cliente";
    }
    $mysql->close();
}