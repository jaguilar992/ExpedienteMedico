<?php include("sesion.php") ?>

<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="./img/favicon.png">
    <title>Hope Medics</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/style.css">
  </head>
  <body>
    <!-- Fixed navbar -->
    <?php include("nav-bar.php") ?>
    <!-- Fin Navbar -->
    <div class="container well card">
      <div class="row">
        <div class="col-lg-12" id="titulo">
          <h1><?php echo $user["CENTRO_MEDICO"] ?></h1>
          <h1>Listado de pacientes</h1>
        </div>
      </div>
      <div class="row">
          <div class="col-lg-12">
            <div class="col-lg-4">
              <input type="text" class="form-control" id="txt-busqueda" placeholder="Búsqueda">
            </div>
            <div class="col-lg-4">
              <select name="slc-filtro-pac" class ="form-control" id="slc-filtro-pac">
                <option value="" hidden="">Filtro</option>
                <option value="1">Nombre</option>
                <option value="2">Apellido</option>
                <option value="3">No Identidad</option>
              </select>
            </div>
            <div class="col-lg-4">
              <button type="button" class="btn btn-default" onclick="cargaTablaPaciente()">Limpiar</button>
              <button type="button" class="btn btn-primary" onclick="buscar()">Buscar</button>
            </div>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-12">
          <table class="table table-striped" id="tbl-paciente">
            <thead>
              <th>No expediente</th>
              <th>Fecha creación</th>
              <th>Primer Nombre</th>
              <th>Segundo Nombre</th>
              <th>Primer Apellido</th>
              <th>Segundo Apellido</th>
              <th>No identidad</th>
              <th>Sexo</th>
              <th>Direccion</th>
              <th>E-Mail</th>
              <th>Editar</th>
            </thead>
            <tbody>
            </tbody>
          </table>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-12">
          <a href="agregar-paciente.php" class="btn btn-primary">Agrega Paciente <span class="glyphicon glyphicon-plus"></span></a>
        </div>
      </div>
    </div> <!-- /container -->

    <!-- Modal -->
    <div class="modal fade" id="modal-editar" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">Editar Paciente</h4>
          </div>
          <input type="hidden" value="" id="txt-id-paciente">
          <div class="modal-body">
            <table class="table">
              <tr>
                <td>Primer Nombre</td>
                <td><input type="text" id="txt-pnombre" disabled="disabled" class="form-control"></td>
              </tr>
              <tr>
                <td>Segundo Nombre</td>
                <td><input type="text" id="txt-snombre" disabled="disabled" class="form-control"></td>
              </tr>
              <tr>
                <td>Primer Apellido</td>
                <td><input type="text" id="txt-papellido" disabled="disabled" class="form-control"></td>
              </tr>
              <tr>
                <td>Segundo Apellido</td>
                <td><input type="text" id ="txt-sapellido" disabled="disabled" class="form-control"></td>
              </tr>
              <tr>
                <td>No Identidad</td>
                <td><input type="text" id="txt-noidentidad" disabled="disabled" class="form-control"></td>
              </tr>
              <tr>
                <td>Dirección: </td>
                <td>
                  <textarea id="txt-direccion" class="form-control" maxlength="50" rows="1" placeholder="Dirección"></textarea>
                </td>
              </tr>
              <tr>
                <td>Correo Electrónico: </td>
                <td>
                  <input type="email" id="txt-email" placeholder="Correo Electrónico" class="form-control">
                </td>
              </tr>
              <tr>
                <td>Escolaridad: </td>
                <td>
                  <select id="slc-escolaridad" class ="form-control">
                    <option value="" hidden="">Escolaridad</option>
                  </select>
                </td>
              </tr>
              <tr>
                <td>Estado Civil</td>
                <td>
                  <select id="slc-estado-civil" class ="form-control">
                    <option value="" hidden="">Estado Civil</option>
                  </select>
                </td>
              </tr>
              <tr>
                <td>Ocupación: </td>
                <td>
                  <select id="slc-ocupacion" class ="form-control">
                    <option value="" hidden="">Ocupación</option>
                  </select>
                </td>
              </tr>
            </table>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
            <button type="button" class="btn btn-primary" onclick="actualizar()">Guardar Cambios</button>
          </div>
        </div>
      </div>
    </div>
    
    <!-- FAB ICON -->
    <div class="container fab">
      <div class="row">
        <div class="col-lg-11"></div>
        <div class="col-lg-1">
          <a href="#" class="btn btn-primary"><span class="glyphicon glyphicon-chevron-up"></span></a>
        </div>
      </div>
    </div>
    <!-- /FAB ICON -->

    <script src="./js/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>

    <script src="./js/config.js  "></script>
    <script src="controlador/admin-paciente.js"></script>
  </body>
</html>
