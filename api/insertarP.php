<?php
if($_SERVER["REQUEST_METHOD"]=="POST"){
    require_once 'conexion.php';
    $idcategoria=$_POST["idcategoria"];
    $codigo=$_POST["codigo"];
    $nombre=$_POST["nombre"];
    $stock=$_POST["stock"];
    $descripcion=$_POST["descripcion"];
    $imagen=$_POST["imagen"];

    $query="INSERT INTO producto 
              (idcategoria      ,codigo       ,nombre       ,stock      ,descripcion    ,imagen     ,condicion     ,idmarca) 
    VALUES('".$idcategoria."','".$codigo."','".$nombre."','".$stock."','".$descripcion."','".$imagen."','1','2')";
    $resultado=$mysql->query($query);
    if($resultado==true){
        echo "El producto se inserto de forma exitosa";
    }else{
        echo "Error al insertar el producto";
    }
}

