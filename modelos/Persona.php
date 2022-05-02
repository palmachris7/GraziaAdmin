<?php 
//Incluímos inicialmente la conexión a la base de datos
require "../config/Conexion.php";

Class Persona
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}

	//Implementamos un método para insertar registros
	public function insertar($tipo_persona,$nombre,$tipo_documento,$num_documento,$direccion,$zona,$telefono,$email)
	{
		$sql="INSERT INTO persona (tipo_persona,nombre,tipo_documento,num_documento,direccion,zona,telefono,email)
		VALUES ('$tipo_persona','$nombre','$tipo_documento','$num_documento','$direccion','$zona','$telefono','$email')";
		return ejecutarConsulta($sql);
	}

	//Implementamos un método para editar registros
	public function editar($idpersona,$tipo_persona,$nombre,$tipo_documento,$num_documento,$direccion,$zona,$telefono,$email)
	{
		$sql="UPDATE persona SET tipo_persona='$tipo_persona',nombre='$nombre',tipo_documento='$tipo_documento',num_documento='$num_documento',direccion='$direccion',zona='$zona',telefono='$telefono',email='$email' WHERE idpersona='$idpersona'";
		return ejecutarConsulta($sql);
	}

	//Implementamos un método para eliminar categorías
	public function eliminar($idpersona)
	{
		$sql="DELETE FROM persona WHERE idpersona='$idpersona'";
		return ejecutarConsulta($sql);
	}

	//Implementar un método para mostrar los datos de un registro a modificar
	public function mostrar($idpersona)
	{
		$sql="SELECT * FROM persona WHERE idpersona='$idpersona'";
		return ejecutarConsultaSimpleFila($sql);
	}

	//Implementar un método para listar los registros
	public function listarpold()
	{
		$sql="SELECT * FROM persona WHERE tipo_persona='Proveedor'";
		return ejecutarConsulta($sql);		
	}

	//Implementar un método para listar los registros
	public function listarp()
	{
		$sql="SELECT v.idpersona,v.tipo_persona,v.nombre,u.nombre as tipo_documento,v.num_documento,v.direccion,v.telefono,v.email FROM persona v INNER JOIN tipo_documento u ON v.tipo_documento=u.id_tipo_documento WHERE tipo_persona=2";
		return ejecutarConsulta($sql);		
	}


	//Implementar un método para listar los registros 
	public function listarcold()
	{
		$sql="SELECT * FROM persona WHERE tipo_persona='Cliente'";
		return ejecutarConsulta($sql);		
	}

		//Implementar un método para listar los registros 
		public function listarc()
		{
			$sql="SELECT v.idpersona,v.tipo_persona,v.nombre,u.nombre as tipo_documento,v.num_documento,v.direccion,v.telefono,v.email FROM persona v INNER JOIN tipo_documento u ON v.tipo_documento=u.id_tipo_documento WHERE tipo_persona=1";
			return ejecutarConsulta($sql);		
		}
}

?>