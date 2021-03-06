<?php
header("Access-Control-Allow-Origin: *");
include_once('./utils/date.php');
include_once('../class/Conexion.php');
include_once('../class/Ambulancia.php');
if(isset($_POST['accion'])){
$conexion = new Conexion();
switch ($_POST['accion']) {
case 'crear':

  if(isset($_POST['placa'])){
    $placa= $_POST['placa'];
  }else{
    $placa=null;
    $res['mensaje']='Se necesita campo: placa';
    $res['resultado']=false;
    echo json_encode($res);
    break;
  }

  if(isset($_POST['idCentroMedico']) && $_POST['idCentroMedico']!=''){
    $idCentroMedico= $_POST['idCentroMedico'];
  }else{
    $idCentroMedico='null';
    $res['mensaje']='Se necesita campo: idCentroMedico';
    $res['resultado']=false;
    echo json_encode($res);
    break;
  }
  $ambulancia=new Ambulancia();
  $ambulancia->setPlaca($placa);
  $ambulancia->setIdCentroMedico($idCentroMedico);
  echo $ambulancia->crear($conexion);
break;

case 'listarTodos':

  if(isset($_POST['idCentroMedico']) && $_POST['idCentroMedico']!=''){
    $idCentroMedico= $_POST['idCentroMedico'];
  }else{
    $idCentroMedico='null';
    $res['mensaje']='Se necesita campo: idCentroMedico';
    $res['resultado']=false;
    echo json_encode($res);
    break;
  }
  $ambulancia=new Ambulancia();
  $ambulancia->setIdCentroMedico($idCentroMedico);
  echo $ambulancia->listarTodos($conexion);
break;

case 'actualizar':

  if(isset($_POST['placa'])){
    $placa= $_POST['placa'];
  }else{
    $placa=null;
    $res['mensaje']='Se necesita campo: placa';
    $res['resultado']=false;
    echo json_encode($res);
    break;
  }

  if(isset($_POST['idCentroMedico']) && $_POST['idCentroMedico']!=''){
    $idCentroMedico= $_POST['idCentroMedico'];
  }else{
    $idCentroMedico='null';
    $res['mensaje']='Se necesita campo: idCentroMedico';
    $res['resultado']=false;
    echo json_encode($res);
    break;
  }

  if(isset($_POST['idAmbulancia']) && $_POST['idAmbulancia']!=''){
    $idAmbulancia= $_POST['idAmbulancia'];
  }else{
    $idAmbulancia='null';
    $res['mensaje']='Se necesita campo: idAmbulancia';
    $res['resultado']=false;
    echo json_encode($res);
    break;
  }
  $ambulancia=new Ambulancia();
  $ambulancia->setPlaca($placa);
  $ambulancia->setIdCentroMedico($idCentroMedico);
  $ambulancia->setIdAmbulancia($idAmbulancia);
  echo $ambulancia->actualizar($conexion);
break;

case 'listarPorCentroMedico':

  if(isset($_POST['idCentroMedico']) && $_POST['idCentroMedico']!=''){
    $idCentroMedico= $_POST['idCentroMedico'];
  }else{
    $idCentroMedico='null';
    $res['mensaje']='Se necesita campo: idCentroMedico';
    $res['resultado']=false;
    echo json_encode($res);
    break;
  }

  if(isset($_POST['nombreCentro'])){
    $nombreCentro= $_POST['nombreCentro'];
  }else{
    $nombreCentro=null;
    $res['mensaje']='Se necesita campo: nombreCentro';
    $res['resultado']=false;
    echo json_encode($res);
    break;
  }
  $ambulancia=new Ambulancia();
  $ambulancia->setIdCentroMedico($idCentroMedico);
  $ambulancia->setNombreCentro($nombreCentro);
  echo $ambulancia->listarPorCentroMedico($conexion);
break;

default:
    $res['mensaje']='Accion no reconocida';
    $res['resultado']=false;
    echo json_encode($res);
break;

}
$conexion->close();
}else{
  $res['mensaje']='Accion no especificada';
  $res['resultado']=false;
  echo json_encode($res);
}
?>