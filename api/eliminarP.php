<?php
if($_SERVER["REQUEST_METHOD"]=="POST"){
    require_once 'conexion.php';

    $nombre=$_POST['nombre'];
    $query="DELETE FROM producto WHERE nombre='".$nombre."'";
    $resultado=$mysql->query($query);
    if($mysql->affected_rows > 0){
        if($resultado==true){
            echo "Producto borrado exitosamente";
        }
    }else{
        echo "Error al borrar el producto";
    }
    $mysql->close();
}