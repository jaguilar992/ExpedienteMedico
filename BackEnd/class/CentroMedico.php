<?php
class CentroMedico{
	private $idCentroMedico;
	private $nombre;
	private $direccion;
	private $idTipoCentro;

	public function __construct(
		$idCentroMedico = null,
		$nombre = null,
		$direccion = null,
		$idTipoCentro = null
	){
		$this->idCentroMedico = $idCentroMedico;
		$this->nombre = $nombre;
		$this->direccion = $direccion;
		$this->idTipoCentro = $idTipoCentro;
	}

	public function __toString(){
		$var = "CentroMedico{"
		."idCentroMedico: ".$this->idCentroMedico." , "
		."nombre: ".$this->nombre." , "
		."direccion: ".$this->direccion." , "
		."idTipoCentro: ".$this->idTipoCentro;
		return $var."}";
	}

	public function getIdCentroMedico(){
		return $this->idCentroMedico;
	}

	public function setIdCentroMedico($idCentroMedico){
		$this->idCentroMedico = $idCentroMedico;
	}
	public function getNombre(){
		return $this->nombre;
	}

	public function setNombre($nombre){
		$this->nombre = $nombre;
	}
	public function getDireccion(){
		return $this->direccion;
	}

	public function setDireccion($direccion){
		$this->direccion = $direccion;
	}
	public function getIdTipoCentro(){
		return $this->idTipoCentro;
	}

	public function setIdTipoCentro($idTipoCentro){
		$this->idTipoCentro = $idTipoCentro;
	}

	public function crear($conexion){
		$query=sprintf("
		  BEGIN
		    PL_CrearCentroMedico(
		      '%s'
		      ,'%s'
		      ,%s
		      ,:res
		      ,:msg
		    );
		  END;
		",
		  $this->nombre
		  ,$this->direccion
		  ,$this->idTipoCentro
		);
		$resultado=$conexion->query($query);
		oci_bind_by_name($resultado, ':msg', $msg, 2000);
		oci_bind_by_name($resultado, ':res', $res);
		oci_execute($resultado);
		oci_free_statement($resultado);
		$respuesta=[];
		$respuesta['mensaje'] = $msg;
		$respuesta['resultado'] = $res == 1;
		return json_encode($respuesta);

	}
	public function listarTodos($conexion){
	}
	public function actualizar($conexion){
		$query=sprintf("
		  BEGIN
		    PL_ActualizarCentroMedico(
		      %s
		      ,'%s'
		      ,'%s'
		      ,%s
		      ,:msg
		      ,:res
		    );
		  END;
		",
		  $this->idCentroMedico
		  ,$this->pnombre
		  ,$this->pdireccion
		  ,$this->idTipoCentro
		);
		$resultado=$conexion->query($query);
		oci_bind_by_name($resultado, ':msg', $msg, 2000);
		oci_bind_by_name($resultado, ':res', $res);
		oci_execute($resultado);
		oci_free_statement($resultado);
		$respuesta=[];
		$respuesta['mensaje'] = $msg;
		$respuesta['resultado'] = $res == 1;
		return json_encode($respuesta);
	}
	public function eliminar($conexion){
	}

}
?>