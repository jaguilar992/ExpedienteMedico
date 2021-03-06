<?php
class Ambulancia{
	private $idAmbulancia;
	private $placa;
	private $idCentroMedico;
	private $nombreCentro;

	public function __construct(
		$idAmbulancia = null,
		$placa = null,
		$idCentroMedico = null
	){
		$this->idAmbulancia = $idAmbulancia;
		$this->placa = $placa;
		$this->idCentroMedico = $idCentroMedico;
	}

	public function __toString(){
		$var = "Ambulancia{"
		."idAmbulancia: ".$this->idAmbulancia." , "
		."placa: ".$this->placa." , "
		."idCentroMedico: ".$this->idCentroMedico;
		return $var."}";
	}

	public function getIdAmbulancia(){
		return $this->idAmbulancia;
	}

	public function setIdAmbulancia($idAmbulancia){
		$this->idAmbulancia = $idAmbulancia;
	}
	public function getPlaca(){
		return $this->placa;
	}

	public function setPlaca($placa){
		$this->placa = $placa;
	}
	public function getIdCentroMedico(){
		return $this->idCentroMedico;
	}

	public function setIdCentroMedico($idCentroMedico){
		$this->idCentroMedico = $idCentroMedico;
	}

	public function getNombreCentro(){
		return $this->nombreCentro;
	}

	public function setNombreCentro($nombreCentro){
		$this->nombreCentro = $nombreCentro;
	}

	public function crear($conexion){
		$query=sprintf("
		  BEGIN
		    PL_CrearAmbulancia(
		      '%s'
		      ,%s
		      ,:msg
		      ,:res
		    );
		  END;
		",
		  $this->placa
		  ,$this->idCentroMedico
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
		$query=sprintf("
		  SELECT  * 
		  FROM vistaAmbulancia V 
		  WHERE  v.ID_CENTRO_MEDICO=%s 
		"
		  ,$this->idCentroMedico
		);
		$resultado = $conexion->query($query);
		$respuesta = $conexion->filas($resultado);
		return json_encode($respuesta);
	}
	public function actualizar($conexion){
		$query=sprintf("
		  BEGIN
		    PL_ActualizarAmbulancia(
		      %s
		      ,'%s'
		      ,%s
		      ,:msg
		      ,:res
		    );
		  END;
		",
		  $this->idAmbulancia
		  ,$this->placa
		  ,$this->idCentroMedico
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

	public function listarPorCentroMedico($conexion){
		$query=sprintf("
		   SELECT  * 
		   FROM vistaAmbulancia v 
		   WHERE v.NOMBRE LIKE '%s' OR V.ID_CENTRO_MEDICO=%s 
		"
		  ,$this->nombreCentro
		  ,$this->idCentroMedico
		);
		$resultado = $conexion->query($query);
		$respuesta = $conexion->filas($resultado);
		return json_encode($respuesta);
	}

}
?>