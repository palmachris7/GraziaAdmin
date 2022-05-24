<?php 
//Incluímos inicialmente la conexión a la base de datos
require "../config/Conexion.php";

Class Producto
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}

	//Implementamos un método para insertar registros
	public function insertar($idcategoria,$codigo,$nombre,$stock,$descripcion,$imagen,$idmarca)
	{
		$sql="INSERT INTO producto (idcategoria,codigo,nombre,stock,descripcion,imagen,condicion,idmarca)
		VALUES ('$idcategoria','$codigo','$nombre','$stock','$descripcion','$imagen','1','$idmarca')";
		return ejecutarConsulta($sql);
	}

	//Implementamos un método para editar registros
	public function editar($idarticulo,$idcategoria,$codigo,$nombre,$stock,$descripcion,$imagen,$idmarca)
	{
		$sql="UPDATE producto SET idcategoria='$idcategoria',codigo='$codigo',nombre='$nombre',stock='$stock',descripcion='$descripcion',imagen='$imagen',idmarca='$idmarca' WHERE idproducto='$idarticulo'";
		return ejecutarConsulta($sql);
	}

	//Implementamos un método para desactivar registros
	public function desactivar($idarticulo)
	{
		$sql="UPDATE producto SET condicion='0' WHERE idproducto='$idarticulo'";
		return ejecutarConsulta($sql);
	}

	//Implementamos un método para activar registros
	public function activar($idarticulo)
	{
		$sql="UPDATE producto SET condicion='1' WHERE idproducto='$idarticulo'";
		return ejecutarConsulta($sql);
	}

	//Implementar un método para mostrar los datos de un registro a modificar
	public function mostrar($idarticulo)
	{
		$sql="SELECT * FROM producto WHERE idproducto='$idarticulo'";
		return ejecutarConsultaSimpleFila($sql);
	}

	//Implementar un método para listar los registros
	public function listar()
	{
		$sql="SELECT a.idproducto,a.idcategoria,c.nombre as categoria,a.codigo,a.nombre,a.stock,a.descripcion,a.imagen,a.condicion FROM producto a INNER JOIN categoria c ON a.idcategoria=c.idcategoria";
		return ejecutarConsulta($sql);		
	}

	//Implementar un método para listar los registros activos
	public function listarActivos()
	{
		$sql="SELECT a.idproducto,a.idcategoria,c.nombre as categoria,a.codigo,a.nombre,a.stock,a.descripcion,a.imagen,a.condicion FROM producto a INNER JOIN categoria c ON a.idcategoria=c.idcategoria WHERE a.condicion='1'";
		return ejecutarConsulta($sql);		
	}

	//Implementar un método para listar los registros activos, su último precio y el stock (vamos a unir con el último registro de la tabla detalle_ingreso)
	public function listarActivosVenta()
	{
		$sql="SELECT a.idproducto,a.idcategoria,c.nombre as categoria,a.codigo,a.nombre,a.stock,(SELECT precio_venta FROM detalle_compra WHERE idproducto=a.idproducto order by iddetalle_compra desc limit 0,1) as precio_venta,a.descripcion,a.imagen,a.condicion FROM producto a INNER JOIN categoria c ON a.idcategoria=c.idcategoria WHERE a.condicion='1'";
		return ejecutarConsulta($sql);		
	}
}

?>