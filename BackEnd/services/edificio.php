<?php
  include '../class/Conexion.php';
	$response = array();
	if(isset($_POST['accion'])){
		$conexion = new Conexion();
		switch ($_POST['accion']) {
			case 'crear':
				$response['result'] = null;
			break;
			case 'listarPorCentro':
				$response['result'] = null;
			break;
			case 'listar':
				$response['result'] = null;
			break;
			case 'actualizar':
				$response['result'] = null;
			break;
			case 'listarPiso':
				$response['result'] = null;
			break;
			case 'agregarPiso':
				$response['result'] = null;
			break;
			case 'actualizarPiso':
				$response['result'] = null;
			break;
			default:
				$response['status']=false;
				$response['code']=404;
				$response['message']='Petición no reconocida [404]';
			break;
		}
		$conexion->close();
		$response['status']=true;
		$response['message']='OK [200]';
		$response['code']=200;
	}else{
		$response['status']=false;
		$response['message']='No se especificó petición [400]';
		$response['code']=400;
	}
?>