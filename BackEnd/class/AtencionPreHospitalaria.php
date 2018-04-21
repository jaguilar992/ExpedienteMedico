<?php
class AtencionPreHospitalaria{
	private $idAtencion;
	private $observacion;
	private $idParamedico;
	private $idAmbulancia;
	private $idExpediente;

	public function __construct(
		$idAtencion = null,
		$observacion = null,
		$idParamedico = null,
		$idAmbulancia = null,
		$idExpediente = null
	){
		$this->idAtencion = $idAtencion;
		$this->observacion = $observacion;
		$this->idParamedico = $idParamedico;
		$this->idAmbulancia = $idAmbulancia;
		$this->idExpediente = $idExpediente;
	}

	public function __toString(){
		$var = "AtencionPreHospitalaria{"
		."idAtencion: ".$this->idAtencion." , "
		."observacion: ".$this->observacion." , "
		."idParamedico: ".$this->idParamedico." , "
		."idAmbulancia: ".$this->idAmbulancia." , "
		."idExpediente: ".$this->idExpediente;
		return $var."}";
	}

	public function getIdAtencion(){
		return $this->idAtencion;
	}

	public function setIdAtencion($idAtencion){
		$this->idAtencion = $idAtencion;
	}
	public function getObservacion(){
		return $this->observacion;
	}

	public function setObservacion($observacion){
		$this->observacion = $observacion;
	}
	public function getIdParamedico(){
		return $this->idParamedico;
	}

	public function setIdParamedico($idParamedico){
		$this->idParamedico = $idParamedico;
	}
	public function getIdAmbulancia(){
		return $this->idAmbulancia;
	}

	public function setIdAmbulancia($idAmbulancia){
		$this->idAmbulancia = $idAmbulancia;
	}
	public function getIdExpediente(){
		return $this->idExpediente;
	}

	public function setIdExpediente($idExpediente){
		$this->idExpediente = $idExpediente;
	}

	public function crear($conexion){
		$query=sprintf("
		  BEGIN
		    PL_CrearAtencionPH(
		      '%s'
		      ,%s
		      ,%s
		      ,%s
		      ,:msg
		      ,:res
		    );
		  END;
		",
		  $this->observacion
		  ,$this->idParamedico
		  ,$this->idAmbulancia
		  ,$this->idExpediente
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
	public function listarPorPaciente($conexion){
	}
	public function listarPorCentroMedico($conexion){
	}
	public function listarPorParamedico($conexion){
	}
	public function actualizar($conexion){
		$query=sprintf("
		  BEGIN
		    PL_ActualizarAtencionPH(
		      %s
		      ,'%s'
		      ,%s
		      ,%s
		      ,%s
		      ,%s
		      ,:msg
		      ,:res
		    );
		  END;
		",
		  $this->idAtencion
		  ,$this->observacion
		  ,$this->fechaHoraAtencion
		  ,$this->idParamedico
		  ,$this->idAmbulancia
		  ,$this->idExpediente
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