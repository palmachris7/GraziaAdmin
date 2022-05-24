<?php 
//Incluímos inicialmente la conexión a la base de datos
require "../config/Conexion.php";

Class Compra
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}

	//Implementamos un método para insertar registros
	public function insertar($idproveedor,$idusuario,$tipo_comprobante,$serie_comprobante,$num_comprobante,$fecha_hora,$impuesto,$total_compra,$idarticulo,$cantidad,$precio_compra,$precio_venta)
	{
		$sql="INSERT INTO compra (idproveedor,idusuario,tipo_comprobante,serie_comprobante,num_comprobante,fecha_hora,impuesto,total_compra,estado)
		VALUES ('$idproveedor','$idusuario','$tipo_comprobante','$serie_comprobante','$num_comprobante','$fecha_hora','$impuesto','$total_compra','Aceptado')";
		//return ejecutarConsulta($sql);
		$idcompranew=ejecutarConsulta_retornarID($sql);

		$num_elementos=0;
		$sw=true;

		while ($num_elementos < count($idarticulo))
		{
			$sql_detalle = "INSERT INTO detalle_compra(idcompra, idproducto,cantidad,precio_compra,precio_venta) VALUES ('$idcompranew', '$idarticulo[$num_elementos]','$cantidad[$num_elementos]','$precio_compra[$num_elementos]','$precio_venta[$num_elementos]')";
			ejecutarConsulta($sql_detalle) or $sw = false;
			$num_elementos=$num_elementos + 1;
		}

		return $sw;
	}

	
	//Implementamos un método para anular categorías
	public function anular($idcompra)
	{
		$sql="UPDATE compra SET estado='Anulado' WHERE idcompra='$idcompra'";
		return ejecutarConsulta($sql);
	}


	//Implementar un método para mostrar los datos de un registro a modificar
	public function mostrar($idcompra)
	{
		$sql="SELECT i.idcompra,DATE(i.fecha_hora) as fecha,i.idproveedor,p.nombre as proveedor,u.idusuario,u.nombre as usuario,i.tipo_comprobante,i.serie_comprobante,i.num_comprobante,i.total_compra,i.impuesto,i.estado FROM compra i INNER JOIN persona p ON i.idproveedor=p.idpersona INNER JOIN usuario u ON i.idusuario=u.idusuario WHERE i.idcompra='$idcompra'";
		return ejecutarConsultaSimpleFila($sql);
	}

	public function listarDetalle($idcompra)
	{
		$sql= "SELECT di.idcompra,di.idproducto,a.nombre,di.cantidad,di.precio_compra,di.precio_venta FROM detalle_compra di inner join producto a on di.idproducto=a.idproducto where di.idcompra='$idcompra'";
		return ejecutarConsulta($sql);
	}

	//Implementar un método para listar los registros
	public function listar()
	{
		$sql="SELECT i.idcompra,DATE(i.fecha_hora) as fecha,i.idproveedor,p.nombre as proveedor,u.idusuario,u.nombre as usuario,i.tipo_comprobante,i.serie_comprobante,i.num_comprobante,i.total_compra,i.impuesto,i.estado FROM compra i INNER JOIN persona p ON i.idproveedor=p.idpersona INNER JOIN usuario u ON i.idusuario=u.idusuario ORDER BY i.idcompra desc";
		return ejecutarConsulta($sql);		
	}
	
	public function ingresocabecera($idcompra){
		$sql="SELECT i.idcompra,i.idproveedor,p.nombre as proveedor,p.direccion,p.tipo_documento,p.num_documento,p.email,p.telefono,i.idusuario,u.nombre as usuario,i.tipo_comprobante,i.serie_comprobante,i.num_comprobante,date(i.fecha_hora) as fecha,i.impuesto,i.total_compra FROM compra i INNER JOIN persona p ON i.idproveedor=p.idpersona INNER JOIN usuario u ON i.idusuario=u.idusuario WHERE i.idcompra='$idcompra'";
		return ejecutarConsulta($sql);
	}

	public function ingresodetalle($idcompra){
		$sql= "SELECT a.nombre as producto,a.codigo,d.cantidad,d.precio_compra,d.precio_venta,(d.cantidad*d.precio_compra) as subtotal FROM detalle_compra d INNER JOIN producto a ON d.idproducto=a.idproducto WHERE d.idcompra='$idcompra'";
		return ejecutarConsulta($sql);
	}
}

?>