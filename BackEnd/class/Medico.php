<?php
class Medico extends Persona{
	private $noColegiacion;
	private $idEspecialidad;
	private $idMedico;
	private $idCentroMedico;

	public function __construct(
		$noColegiacion = null,
		$idEspecialidad = null,
		$idMedico = null
	){
		$this->noColegiacion = $noColegiacion;
		$this->idEspecialidad = $idEspecialidad;
		$this->idMedico = $idMedico;
	}

	public function __toString(){
		$var = parent::__toString();
		$var .= "<br>"."Medico{"
		."noColegiacion: ".$this->noColegiacion." , "
		."idEspecialidad: ".$this->idEspecialidad." , "
		."idMedico: ".$this->idMedico;
		return $var."}";
	}

	public function getNoColegiacion(){
		return $this->noColegiacion;
	}

	public function setNoColegiacion($noColegiacion){
		$this->noColegiacion = $noColegiacion;
	}
	public function getidEspecialidad(){
		return $this->idEspecialidad;
	}

	public function setidEspecialidad($idEspecialidad){
		$this->idEspecialidad = $idEspecialidad;
	}
	public function getIdMedico(){
		return $this->idMedico;
	}

	public function setIdMedico($idMedico){
		$this->idMedico = $idMedico;
	}

	public function getIdCentroMedico(){
		return $this->idCentroMedico;
	}

	public function setIdCentroMedico($idCentroMedico){
		$this->idCentroMedico = $idCentroMedico;
	}

	public function crear($conexion){
		$query=sprintf("
		  BEGIN
		    PL_CrearMedico(
		      '%s'
		      ,'%s'
		      ,'%s'
		      ,'%s'
		      ,'%s'
		      ,'%s'
		      ,'%s'
		      ,%s
		      ,'%s'
		      ,'%s'
		      ,'%s'
		      ,:msg
		      ,:res
		    );
		  END;
		",
		  $this->getPNombre()
		  ,$this->getSNombre()
		  ,$this->getPApellido()
		  ,$this->getSApellido()
		  ,$this->getDireccion()
		  ,$this->getSexo()
		  ,$this->getNoIdentidad()
		  ,$this->getIdPais()
		  ,$this->idEspecialidad
		  ,$this->noColegiacion
		  ,$this->getCorreo()
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
		  SELECT DISTINCT
		    *
		  FROM MEDICOCONSULTORIO mc
		  INNER JOIN VISTAMEDICO m
		    ON mc.ID_MEDICO = m.ID_MEDICO
		  INNER JOIN CONSULTORIO c
		    ON mc.ID_CONSULTORIO = c.ID_CONSULTORIO
		  INNER JOIN PISO p
		    ON p.ID_PISO = c.ID_PISO
		  INNER JOIN EDIFICIO e
		    ON p.ID_EDIFICIO = e.ID_EDIFICIO 
		  WHERE  e.ID_CENTRO_MEDICO =%s ORDER BY m.ESPECIALIDAD 
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
		    PL_ActualizarMedico(
		      %s
		      ,'%s'
		      ,'%s'
		      ,'%s'
		      ,'%s'
		      ,:msg
		      ,:res
		    );
		  END;
		",
		  $this->idMedico
		  ,$this->getDireccion()
		  ,$this->idEspecialidad
		  ,$this->noColegiacion
		  ,$this->getCorreo()
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
	
	public function listar($conexion){
		$query=sprintf("
		    SELECT  * 
		    FROM VISTAMEDICO v 
		    WHERE v.ID_MEDICO =%s
		"
		  ,$this->idMedico
		);
		$resultado = $conexion->query($query);
		$respuesta = $conexion->filas($resultado);
		return json_encode($respuesta);
	}

	public function buscarPorNombre($conexion){
		$query=sprintf("
		    SELECT  * 
		    FROM VISTAMEDICO v 
		    WHERE  v.P_NOMBRE = '%s'  OR v.S_NOMBRE = '%s' 
		"
		  ,$this->getPNombre()
		  ,$this->getSNombre()
		);
		$resultado = $conexion->query($query);
		$respuesta = $conexion->filas($resultado);
		return json_encode($respuesta);
	}
	public function buscarPorApellido($conexion){
		$query=sprintf("
		    SELECT  * 
		    FROM VISTAMEDICO v 
		    WHERE  v.P_APELLIDO = '%s'  OR v.S_APELLIDO = '%s' 
		"
		  ,$this->getPApellido()
		  ,$this->getSApellido()
		);
		$resultado = $conexion->query($query);
		$respuesta = $conexion->filas($resultado);
		return json_encode($respuesta);
	}
	public function buscarPorNoIdentidad($conexion){
		$query=sprintf("
		    SELECT  * 
		    FROM VISTAMEDICO v 
		    WHERE  v.NO_IDENTIDAD LIKE '%%%s%%' 
		"
		  ,$this->getNoIdentidad()
		);
		$resultado = $conexion->query($query);
		$respuesta = $conexion->filas($resultado);
		return json_encode($respuesta);
	}

	public function buscarPorNoColegiacion($conexion){
		$query=sprintf("
		    SELECT  * 
		    FROM VISTAMEDICO v 
		    WHERE  v.NO_COLEGIACION = '%s' 
		"
		  ,$this->noColegiacion
		);
		$resultado = $conexion->query($query);
		$respuesta = $conexion->filas($resultado);
		return json_encode($respuesta);
	}

	public function listarEspecialidad($conexion){
		$query=sprintf("
		    SELECT *
		    FROM ESPECIALIDAD
		"
		);
		$resultado = $conexion->query($query);
		$respuesta = $conexion->filas($resultado);
		return json_encode($respuesta);
	}
}
?>