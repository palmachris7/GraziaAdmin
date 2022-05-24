<?php
if($_SERVER["REQUEST_METHOD"]=="POST"){
    require_once 'conexion.php';
    $total_venta=$_POST["total_venta"];
    $query="INSERT INTO venta 
              (idcliente,idusuario,tipo_comprobante,serie_comprobante,num_comprobante,fecha_hora,impuesto,total_venta,estado) 
    VALUES('1000','1','1','null','null','movil','1','".$total_venta."','Aceptado')";
    $resultado=$mysql->query($query);
    if($resultado==true){
        echo "Venta se inserto de forma exitosa";
    }else{
        echo "Error al insertar venta";
    }
}









