<?php
if($_SERVER["REQUEST_METHOD"]=="POST"){
    require_once 'conexion.php';
    $stringVal=$_POST["total_venta"];
    $total_venta = floatval( $stringVal );

    $query="INSERT INTO venta 
              (idcliente,idusuario,tipo_comprobante,serie_comprobante,num_comprobante,fecha_hora,impuesto,total_venta,estado) 
    VALUES('10','1','1','movil','movil',current_timestamp(),'1','".$total_venta."','Aceptado')";
    $resultado=$mysql->query($query);
    if($resultado==true){
        echo "Venta se inserto de forma exitosa";
    }else{
        echo "Error al insertar venta";
    }
}









