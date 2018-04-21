CREATE OR REPLACE PROCEDURE PL_CrearAmbulancia(
  placa IN VARCHAR
  ,idCentro IN INTEGER
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
vnConteo INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF placa = '' OR placa IS NULL THEN
    mensaje:= mensaje || 'placa, ';
  END IF;
  IF idCentro = '' OR idCentro IS NULL THEN
    mensaje:= mensaje || 'idCentro, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
    SELECT 
        COUNT(cem.id_centro_medico) 
    INTO vnConteo 
    FROM Centromedico cem
    WHERE Id_Centro_Medico=idCentro;
    IF vnConteo=0 THEN
        mensaje:='No existe Centro Medico para enlazar ambulancia';
        RETURN;
    END IF;
    
    INSERT INTO Ambulancia 
    (placa, Id_Centro_Medico) VALUES (placa, idCentro);
    COMMIT;
    /*Devuelve los valores*/
    mensaje:='Creado exitosamente';
    resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_ActualizarAmbulancia(
  idAmbulancia IN INT
  ,p_placa IN VARCHAR
  ,idCentroMedico IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idAmbulancia = '' OR idAmbulancia IS NULL THEN
    mensaje:= mensaje || 'idAmbulancia, ';
  END IF;
  IF p_placa = '' OR p_placa IS NULL THEN
    mensaje:= mensaje || 'placa, ';
  END IF;
  IF idCentroMedico = '' OR idCentroMedico IS NULL THEN
    mensaje:= mensaje || 'idCentroMedico, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/

  /*Verificacion de ambulancias*/
  SELECT
    COUNT(*)
  INTO contador
  FROM AMBULANCIA
  WHERE ID_AMBULANCIA = idAmbulancia
  ;
  IF contador=0 THEN
    mensaje:='No existe idAmbulancia';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM CENTROMEDICO
  WHERE ID_CENTRO_MEDICO = idCentroMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe idCentroMedico';
    RETURN;
  END IF;

  UPDATE AMBULANCIA
  SET
  AMBULANCIA.placa = p_placa,
  ID_CENTRO_MEDICO=idCentroMedico
  WHERE ID_AMBULANCIA=idAmbulancia;

  COMMIT;
  mensaje:='Actualizada satisfactoriamente';
  resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_CrearAtencionPH(
  observacion IN VARCHAR
  ,idParamedico IN int
  ,idAmbulancia IN int
  ,idExpediente IN int
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE 
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idParamedico = '' OR idParamedico IS NULL THEN
    mensaje:= mensaje || 'idParamedico, ';
  END IF;
  IF idAmbulancia = '' OR idAmbulancia IS NULL THEN
    mensaje:= mensaje || 'idAmbulancia, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos:'||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM PARAMEDICO
  WHERE ID_PARAMEDICO = idParamedico;
  IF contador=0 THEN
    mensaje:='No existe idParamedico';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM AMBULANCIA
  WHERE ID_AMBULANCIA = idAmbulancia
  ;
  IF contador=0 THEN
    mensaje:='No existe idAmbulancia';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM EXPEDIENTE
  WHERE id_expediente = idExpediente
  ;
  IF contador=0 THEN
    mensaje:='No existe idExpediente';
    RETURN;
  END IF;

  INSERT INTO ATENCIONPREHOSPITALARIA
  (OBSERVACION, FECHA_HORA_ATENCION, ID_PARAMEDICO, ID_AMBULANCIA, ID_EXPEDIENTE)
  VALUES (observacion, SYSDATE, idParamedico, idAmbulancia, idExpediente);
  COMMIT;
  mensaje:='Registro ingresado satisfactoriamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_ActualizarAtencionPH(
  idAtencion IN INT
  ,pobservacion IN VARCHAR
  ,fechaHoraAtencion IN TIMESTAMP
  ,idParamedico IN INT
  ,idAmbulancia IN INT
  ,idExpediente IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idAtencion = '' OR idAtencion IS NULL THEN
    mensaje:= mensaje || 'idAtencion, ';
  END IF;
  IF pobservacion = '' OR pobservacion IS NULL THEN
    mensaje:= mensaje || 'observacion, ';
  END IF;
  IF fechaHoraAtencion = '' OR fechaHoraAtencion IS NULL THEN
    mensaje:= mensaje || 'fechaHoraAtencion, ';
  END IF;
  IF idParamedico = '' OR idParamedico IS NULL THEN
    mensaje:= mensaje || 'idParamedico, ';
  END IF;
  IF idAmbulancia = '' OR idAmbulancia IS NULL THEN
    mensaje:= mensaje || 'idAmbulancia, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos:'||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM ATENCIONPREHOSPITALARIA
  WHERE ID_ATENCION = idAtencion
  ;
  IF contador=0 THEN
    mensaje:='No existe registro de AtencionPreHospitalaria';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM PARAMEDICO
  WHERE ID_PARAMEDICO = idParamedico;
  IF contador=0 THEN
    mensaje:='No existe idParamedico';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM AMBULANCIA
  WHERE ID_AMBULANCIA = idAmbulancia
  ;
  IF contador=0 THEN
    mensaje:='No existe idAmbulancia';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM EXPEDIENTE
  WHERE id_expediente = idExpediente
  ;
  IF contador=0 THEN
    mensaje:='No existe idExpediente';
    RETURN;
  END IF;

  UPDATE ATENCIONPREHOSPITALARIA
  SET OBSERVACION= pobservacion,
  FECHA_HORA_ATENCION= fechaHoraAtencion,
  ID_PARAMEDICO= idParamedico,
  ID_AMBULANCIA= idAmbulancia,
  ID_EXPEDIENTE= idExpediente
  WHERE
    ID_ATENCION = idAtencion
  ;
  COMMIT;
  mensaje:='Actualizada   satisfactoriamente';
  resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_CrearCentroMedico(
  nombre IN VARCHAR
  ,direccion IN VARCHAR
  ,idTipoCentro IN INT
  ,resultado OUT SMALLINT
  ,mensaje OUT VARCHAR
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF nombre = '' OR nombre IS NULL THEN
    mensaje:= mensaje || 'nombre, ';
  END IF;
  IF direccion = '' OR direccion IS NULL THEN
    mensaje:= mensaje || 'direccion, ';
  END IF;
  IF idTipoCentro = '' OR idTipoCentro IS NULL THEN
    mensaje:= mensaje || 'idTipoCentro, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM TIPOCENTRO
  WHERE ID_TIPO_CENTRO = idTipoCentro
  ;
  IF contador=0 THEN
    mensaje:='No existe idTipoCentro';
    RETURN;
  END IF;

  INSERT INTO CENTROMEDICO
  (NOMBRE, DIRECCION, ID_TIPO_CENTRO) VALUES
  (nombre, direccion, idTipoCentro);
  COMMIT;

  mensaje:='Registro insertado satisfactoriamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_ActualizarCentroMedico(
  idCentroMedico IN INTEGER
  ,pnombre IN VARCHAR
  ,pdireccion IN VARCHAR
  ,idTipoCentro IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idCentroMedico = '' OR idCentroMedico IS NULL THEN
    mensaje:= mensaje || 'idCentroMedico, ';
  END IF;
  IF pnombre = '' OR pnombre IS NULL THEN
    mensaje:= mensaje || 'nombre, ';
  END IF;
  IF pdireccion = '' OR pdireccion IS NULL THEN
    mensaje:= mensaje || 'direccion, ';
  END IF;
  IF idTipoCentro = '' OR idTipoCentro IS NULL THEN
    mensaje:= mensaje || 'idTipoCentro, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM CENTROMEDICO
  WHERE ID_CENTRO_MEDICO = idCentroMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe idCentroMedico';
    RETURN;
  END IF;


  SELECT
    COUNT(*)
  INTO contador
  FROM TIPOCENTRO
  WHERE ID_TIPO_CENTRO = idTipoCentro
  ;
  IF contador=0 THEN
    mensaje:='No existe idTipoCentro';
    RETURN;
  END IF;

  UPDATE CENTROMEDICO
  SET NOMBRE= pnombre,
  DIRECCION= pdireccion,
  ID_TIPO_CENTRO= idTipoCentro
  WHERE ID_CENTRO_MEDICO= idCentroMedico
  ;
  COMMIT;
  mensaje:='Actualizada satisfactoriamente';
  resultado:=1;


END;


CREATE OR REPLACE PROCEDURE PL_AgregarCirugia(
  idIngreso IN INT
  ,idTipoCirugia IN INT
  ,idMedico IN INT
  ,fechaHora IN VARCHAR
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idIngreso = '' OR idIngreso IS NULL THEN
    mensaje:= mensaje || 'idIngreso, ';
  END IF;
  IF idTipoCirugia = '' OR idTipoCirugia IS NULL THEN
    mensaje:= mensaje || 'idTipoCirugia, ';
  END IF;
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF fechaHora = '' OR fechaHora IS NULL THEN
    mensaje:= mensaje || 'fechaHora, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM HOSPITALIZACION
  WHERE ID_INGRESO = idIngreso
  ;
  IF contador=0 THEN
    mensaje:='No existe Paciente en Hospitalizacion';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM TIPOCIRUGIA
  WHERE ID_TIPO_CIRUGIA = idTipoCirugia
  ;
  IF contador=0 THEN
    mensaje:='No existe TipoCirugia';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM MEDICO
  WHERE ID_MEDICO = idMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe Medico para enlazar cirugia';
    RETURN;
  END IF;

  INSERT INTO CIRUGIA
  (ID_INGRESO, ID_TIPO_CIRUGIA, ID_MEDICO, FECHA_HORA) VALUES
  (idIngreso, idTipoCirugia, idMedico, fechaHora);

  COMMIT;
  mensaje:='Registro insertado satisfactoriamente';
  resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_CrearConsultaExterna(
  idConsultorio IN INT
  ,idExpediente IN INT
  ,idMedico IN INT
  ,fechaHora IN TIMESTAMP
  ,sintomas IN VARCHAR
  ,diagnostico IN VARCHAR
  ,observacion IN VARCHAR
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idConsultorio = '' OR idConsultorio IS NULL THEN
    mensaje:= mensaje || 'idConsultorio, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF fechaHora = '' OR fechaHora IS NULL THEN
    mensaje:= mensaje || 'fechaHora, ';
  END IF;
  IF sintomas = '' OR sintomas IS NULL THEN
    mensaje:= mensaje || 'sintomas, ';
  END IF;
  IF diagnostico = '' OR diagnostico IS NULL THEN
    mensaje:= mensaje || 'diagnostico, ';
  END IF;
  IF observacion = '' OR observacion IS NULL THEN
    mensaje:= mensaje || 'observacion, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM CONSULTORIO
  WHERE ID_CONSULTORIO = idConsultorio
  ;
  IF contador=0 THEN
    mensaje:='No existe Consultorio ingresado';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM EXPEDIENTE
  WHERE id_expediente = idExpediente
  ;
  IF contador=0 THEN
    mensaje:='No existe expediente ingresado';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM MEDICO
  WHERE ID_MEDICO = idMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe Medico ingresado';
    RETURN;
  END IF;

  INSERT INTO CONSULTAEXTERNA
  (ID_CONSULTORIO, ID_EXPEDIENTE, ID_MEDICO, FECHA_HORA, SINTOMAS, DIAGNOSTICO, OBSERVACION)
  VALUES
  (idConsultorio, idExpediente, idMedico, fechaHora, sintomas, diagnostico, observacion);
  COMMIT;
  mensaje:='Registro insertado satisfactoriamente';
  resultado:=1;


END;


CREATE OR REPLACE PROCEDURE PL_ActualizarConsultaExterna(
  idConsulta IN INT
  ,idExpediente IN INT
  ,idConsultorio IN INT
  ,idMedico IN INT
  ,fechaHora IN TIMESTAMP
  ,psintomas IN VARCHAR
  ,pdiagnostico IN VARCHAR
  ,pobservacion IN VARCHAR
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idConsulta = '' OR idConsulta IS NULL THEN
    mensaje:= mensaje || 'idConsulta, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF idConsultorio = '' OR idConsultorio IS NULL THEN
    mensaje:= mensaje || 'idConsultorio, ';
  END IF;
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF fechaHora = '' OR fechaHora IS NULL THEN
    mensaje:= mensaje || 'fechaHora, ';
  END IF;
  IF psintomas = '' OR psintomas IS NULL THEN
    mensaje:= mensaje || 'sintomas, ';
  END IF;
  IF pdiagnostico = '' OR pdiagnostico IS NULL THEN
    mensaje:= mensaje || 'diagnostico, ';
  END IF;
  IF pobservacion = '' OR pobservacion IS NULL THEN
    mensaje:= mensaje || 'observacion, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/

  SELECT
    COUNT(*)
  INTO contador
  FROM CONSULTAEXTERNA
  WHERE ID_CONSULTA = idConsulta
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de consulta ingresada';
    RETURN;
  END IF;


  SELECT
    COUNT(*)
  INTO contador
  FROM CONSULTORIO
  WHERE ID_CONSULTORIO = idConsultorio
  ;
  IF contador=0 THEN
    mensaje:='No existe Consultorio ingresado';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM EXPEDIENTE
  WHERE id_expediente = idExpediente
  ;
  IF contador=0 THEN
    mensaje:='No existe expediente ingresado';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM MEDICO
  WHERE ID_MEDICO = idMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe Medico ingresado';
    RETURN;
  END IF;

  UPDATE CONSULTAEXTERNA
  SET
  ID_EXPEDIENTE= idExpediente,
  ID_CONSULTORIO= idConsultorio,
  ID_MEDICO= idMedico,
  FECHA_HORA= fechaHora,
  SINTOMAS= psintomas,
  DIAGNOSTICO= pdiagnostico,
  OBSERVACION= pobservacion
  WHERE
    ID_CONSULTA= idConsulta;

  COMMIT;
  mensaje:='Actualizada   satisfactoriamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_PL_CrearConsultorio(
  idPiso IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INT;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idPiso = '' OR idPiso IS NULL THEN
    mensaje:= mensaje || 'idPiso, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM PISO
  WHERE ID_PISO = idPiso
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de piso ingresado';
    RETURN;
  END IF;

  INSERT INTO CONSULTORIO
  (ID_PISO) VALUES(idPiso);

  COMMIT;
  mensaje:='Registro insertado satisfactoriamente';
  resultado:=1;


END;


CREATE OR REPLACE PROCEDURE PL_CrearEdificio(
  nombre IN VARCHAR
  ,idCentroMedico IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
 contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF nombre = '' OR nombre IS NULL THEN
    mensaje:= mensaje || 'nombre, ';
  END IF;
  IF idCentroMedico = '' OR idCentroMedico IS NULL THEN
    mensaje:= mensaje || 'idCentroMedico, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/

  SELECT
    COUNT(*)
  INTO contador
  FROM CENTROMEDICO
  WHERE ID_CENTRO_MEDICO = idCentroMedico
  ;
  IF contador=0 THEN
    mensaje:='No existec codigo de centro medico ingresado';
    RETURN;
  END IF;

  INSERT INTO EDIFICIO
  (NOMBRE, ID_CENTRO_MEDICO) VALUES
  (nombre, idCentroMedico);

  COMMIT;
  mensaje:='Registro insertado satisfactoriamente';
  resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_AgregarPiso(
  idEdificio IN INT
  ,descripcion IN VARCHAR
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idEdificio = '' OR idEdificio IS NULL THEN
    mensaje:= mensaje || 'idEdificio, ';
  END IF;
  IF descripcion = '' OR descripcion IS NULL THEN
    mensaje:= mensaje || 'descripcion, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM EDIFICIO
  WHERE ID_EDIFICIO = idEdificio
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de Edificio ingresado';
    RETURN;
  END IF;

  INSERT INTO PISO
  (DESCRIPCION, ID_EDIFICIO) VALUES
  (descripcion, idEdificio);

  COMMIT;
  mensaje:='Registro insertado satisfactoriamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_CrearEmergencia(
  observacion IN VARCHAR
  ,fechaHoraAtencion IN TIMESTAMP
  ,idExpediente IN INT
  ,idAtencion IN INT
  ,idCentroMedico IN INT
  ,idMedico IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
 contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF observacion = '' OR observacion IS NULL THEN
    mensaje:= mensaje || 'observacion, ';
  END IF;
  IF fechaHoraAtencion = '' OR fechaHoraAtencion IS NULL THEN
    mensaje:= mensaje || 'fechaHoraAtencion, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF idCentroMedico = '' OR idCentroMedico IS NULL THEN
    mensaje:= mensaje || 'idCentroMedico, ';
  END IF;
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/

  SELECT
    COUNT(*)
  INTO contador
  FROM EXPEDIENTE
  WHERE ID_EXPEDIENTE = idExpediente
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo Expediente';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM ATENCIONPREHOSPITALARIA
  WHERE ID_ATENCION = idAtencion
  ;
  IF idAtencion IS NOT NULL AND contador=0 THEN
    mensaje:='No existe codigo de Atencion Pre Hospitalaria';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM CENTROMEDICO
  WHERE ID_CENTRO_MEDICO = idCentroMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de Centro Medico ingresado';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM MEDICO
  WHERE ID_MEDICO = idMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de Medico ingresado';
    RETURN;
  END IF;

  INSERT INTO EMERGENCIA
  (OBSERVACION, FECHA_HORA_ATENCION,
   ID_EXPEDIENTE, ID_ATENCION, ID_CENTRO_MEDICO, ID_MEDICO)
  VALUES
  (observacion, fechaHoraAtencion, idExpediente,idAtencion, idCentroMedico, idMedico);
  COMMIT;
  mensaje:='Registro insertado satisfactoriamente';
  resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_ActualizarEmergencia(
  idIngreso IN INT
  ,pobservacion IN VARCHAR
  ,fechaHoraAtencion IN TIMESTAMP
  ,idExpediente IN INT
  ,idAtencion IN INT
  ,idCentroMedico IN INT
  ,idMedico IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idIngreso = '' OR idIngreso IS NULL THEN
    mensaje:= mensaje || 'idIngreso, ';
  END IF;
  IF pobservacion = '' OR pobservacion IS NULL THEN
    mensaje:= mensaje || 'observacion, ';
  END IF;
  IF fechaHoraAtencion = '' OR fechaHoraAtencion IS NULL THEN
    mensaje:= mensaje || 'fechaHoraAtencion, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF idAtencion = '' OR idAtencion IS NULL THEN
    mensaje:= mensaje || 'idAtencion, ';
  END IF;
  IF idCentroMedico = '' OR idCentroMedico IS NULL THEN
    mensaje:= mensaje || 'idCentroMedico, ';
  END IF;
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM EMERGENCIA
  WHERE ID_INGRESO = idIngreso
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo emergencia ingresado';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM EXPEDIENTE
  WHERE ID_EXPEDIENTE = idExpediente
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo Expediente';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM ATENCIONPREHOSPITALARIA
  WHERE ID_ATENCION = idAtencion
  ;
  IF idAtencion IS NOT NULL AND contador=0 THEN
    mensaje:='No existe codigo de Atencion Pre Hospitalaria';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM CENTROMEDICO
  WHERE ID_CENTRO_MEDICO = idCentroMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de Centro Medico ingresado';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM MEDICO
  WHERE ID_MEDICO = idMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de Medico ingresado';
    RETURN;
  END IF;

  UPDATE EMERGENCIA
  SET
  OBSERVACION=pobservacion,
  FECHA_HORA_ATENCION=fechaHoraAtencion,
  ID_EXPEDIENTE=idExpediente,
  ID_ATENCION=idAtencion,
  ID_CENTRO_MEDICO=idCentroMedico,
  ID_MEDICO=idMedico
  WHERE ID_INGRESO=idIngreso
  ;
  COMMIT;
  mensaje:='Actualizada   satisfactoriamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_CrearEnfermedad(
  enfermedad IN VARCHAR
  ,idTipoEnfermedad IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF enfermedad = '' OR enfermedad IS NULL THEN
    mensaje:= mensaje || 'enfermedad, ';
  END IF;
  IF idTipoEnfermedad = '' OR idTipoEnfermedad IS NULL THEN
    mensaje:= mensaje || 'idTipoEnfermedad, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM TIPOENFERMEDAD
  WHERE ID_TIPO_ENFERMEDAD = idTipoEnfermedad
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de enfermedad ingresado';
    RETURN;
  END IF;

  INSERT INTO ENFERMEDAD
  (ENFERMEDAD, ID_TIPO_ENFERMEDAD) VALUES
  (enfermedad, idTipoEnfermedad);
  COMMIT;
  mensaje:='Registro insertado satisfactoriamente';
  resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_ActualizarEnfermedad(
  idEnfermedad IN INT
  ,penfermedad IN VARCHAR
  ,idTipoEnfermedad IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idEnfermedad = '' OR idEnfermedad IS NULL THEN
    mensaje:= mensaje || 'idEnfermedad, ';
  END IF;
  IF penfermedad = '' OR penfermedad IS NULL THEN
    mensaje:= mensaje || 'enfermedad, ';
  END IF;
  IF idTipoEnfermedad = '' OR idTipoEnfermedad IS NULL THEN
    mensaje:= mensaje || 'idTipoEnfermedad, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM ENFERMEDAD
  WHERE ID_ENFERMEDAD = idEnfermedad
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de enfermedad ingresado';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM TIPOENFERMEDAD
  WHERE ID_TIPO_ENFERMEDAD = idTipoEnfermedad
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de enfermedad ingresado';
    RETURN;
  END IF;

  UPDATE ENFERMEDAD
  SET
  ENFERMEDAD= penfermedad,
  ID_TIPO_ENFERMEDAD= idTipoEnfermedad
  WHERE ID_ENFERMEDAD= idEnfermedad
  ;
  COMMIT;
  mensaje:='Actualizada   satisfactoriamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_DiagnosticarEnfermedad(
  idEnfermedad IN INT
  ,idMedico IN INT
  ,fechaDiagnostico IN TIMESTAMP
  ,idExpediente IN INT
  ,idConsulta IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idEnfermedad = '' OR idEnfermedad IS NULL THEN
    mensaje:= mensaje || 'idEnfermedad, ';
  END IF;
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF fechaDiagnostico = '' OR fechaDiagnostico IS NULL THEN
    mensaje:= mensaje || 'fechaDiagnostico, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF idConsulta = '' OR idConsulta IS NULL THEN
    mensaje:= mensaje || 'idConsulta, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM ENFERMEDAD
  WHERE ID_ENFERMEDAD = idEnfermedad
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de enfermedad ingresado';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM MEDICO
  WHERE ID_MEDICO = idMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de medico ingresado';
    RETURN;
  END IF;


  SELECT
    COUNT(*)
  INTO contador
  FROM CONSULTAEXTERNA
  WHERE ID_CONSULTA = idConsulta
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de consulta ingresada';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM EXPEDIENTE
  WHERE id_expediente = idExpediente
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo expediente';
    RETURN;
  END IF;

  INSERT INTO ENFERMEDADCONSULTA
  (ID_MEDICO, ESTADO, FECHA_DIAGNOSTICO, ID_EXPEDIENTE, ID_CONSULTA) VALUES
  (idMedico, 1, fechaDiagnostico, idExpediente, idConsulta);
  COMMIT;
  mensaje:='Registro insertado satisfactoriamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_QuitarDiagnostico(
  idEnfermedad IN INT
  ,idExpediente IN INT
  ,idConsulta IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idEnfermedad = '' OR idEnfermedad IS NULL THEN
    mensaje:= mensaje || 'idEnfermedad, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF idConsulta = '' OR idConsulta IS NULL THEN
    mensaje:= mensaje || 'idConsulta, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/

  SELECT
    COUNT(*)
  INTO contador
  FROM ENFERMEDAD
  WHERE ID_ENFERMEDAD = idEnfermedad
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo Enfermedad ingresado';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM EXPEDIENTE
  WHERE id_expediente = idExpediente
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo expediente ingresado';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM CONSULTAEXTERNA
  WHERE ID_CONSULTA = idConsulta
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo Consulta ingresado';
    RETURN;
  END IF;

  UPDATE ENFERMEDADCONSULTA
  SET ESTADO = 0
  WHERE ID_ENFERMEDAD = idEnfermedad
  AND ID_EXPEDIENTE = idExpediente
  AND ID_CONSULTA = idConsulta;

  COMMIT;
  mensaje:='Actualizada satisfactoriamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_CrearExamen(
  urlDocumento IN VARCHAR
  ,idTipo IN INT
  ,idCentroMedico IN INT
  ,observacion IN VARCHAR
  ,idExpediente IN INT
  ,fecha IN TIMESTAMP
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF urlDocumento = '' OR urlDocumento IS NULL THEN
    mensaje:= mensaje || 'urlDocumento, ';
  END IF;
  IF idTipo = '' OR idTipo IS NULL THEN
    mensaje:= mensaje || 'idTipo, ';
  END IF;
  IF idCentroMedico = '' OR idCentroMedico IS NULL THEN
    mensaje:= mensaje || 'idCentroMedico, ';
  END IF;
  IF observacion = '' OR observacion IS NULL THEN
    mensaje:= mensaje || 'observacion, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF fecha = '' OR fecha IS NULL THEN
    mensaje:= mensaje || 'fecha, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM TIPOEXAMEN
  WHERE ID_TIPO = idTipo
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de tipo de enfermedad';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM CENTROMEDICO
  WHERE ID_CENTRO_MEDICO = idCentroMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de centro medico';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM EXPEDIENTE
  WHERE id_expediente = idExpediente
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de expediente';
    RETURN;
  END IF;

  INSERT INTO EXAMEN
  (URL_DOCUMENTO, ID_TIPO, ID_CENTRO_MEDICO, OBSERVACION, ID_EXPEDIENTE, FECHA) VALUES
  (urlDocumento, idTipo, idCentroMedico, observacion, idExpediente, fecha);
  COMMIT;
  mensaje:='Registro insertado satisfactoriamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_ActualizarExamen(
  idExamen IN INT
  ,urlDocumento IN VARCHAR
  ,idTipo IN INT
  ,idCentroMedico IN INT
  ,pobservacion IN VARCHAR
  ,idExpediente IN INT
  ,pfecha IN TIMESTAMP
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idExamen = '' OR idExamen IS NULL THEN
    mensaje:= mensaje || 'idExamen, ';
  END IF;
  IF urlDocumento = '' OR urlDocumento IS NULL THEN
    mensaje:= mensaje || 'urlDocumento, ';
  END IF;
  IF idTipo = '' OR idTipo IS NULL THEN
    mensaje:= mensaje || 'idTipo, ';
  END IF;
  IF idCentroMedico = '' OR idCentroMedico IS NULL THEN
    mensaje:= mensaje || 'idCentroMedico, ';
  END IF;
  IF pobservacion = '' OR pobservacion IS NULL THEN
    mensaje:= mensaje || 'observacion, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF pfecha = '' OR pfecha IS NULL THEN
    mensaje:= mensaje || 'fecha, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT
    COUNT(*)
  INTO contador
  FROM EXAMEN
  WHERE ID_EXAMEN = idExamen
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de examen ingresado';
    RETURN;
  END IF;


  SELECT
    COUNT(*)
  INTO contador
  FROM TIPOEXAMEN
  WHERE ID_TIPO = idTipo
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de tipo de enfermedad';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM CENTROMEDICO
  WHERE ID_CENTRO_MEDICO = idCentroMedico
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de centro medico';
    RETURN;
  END IF;

  SELECT
    COUNT(*)
  INTO contador
  FROM EXPEDIENTE
  WHERE id_expediente = idExpediente
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de expediente';
    RETURN;
  END IF;

  UPDATE EXAMEN
  SET
  URL_DOCUMENTO=urlDocumento,
  ID_TIPO=idTipo,
  ID_CENTRO_MEDICO=idCentroMedico,
  OBSERVACION=pobservacion,
  ID_EXPEDIENTE=idExpediente,
  FECHA=pfecha
  WHERE ID_EXAMEN=idExamen;
END;


CREATE OR REPLACE PROCEDURE PL_ActualizarHojaTrabajoSocial(
  descripcion IN VARCHAR
  ,idExpediente IN INT
  ,idCentroMedico IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT

)
IS
temMensaje VARCHAR(2000);
vnConteo NUMBER;

BEGIN
  mensaje:='';
  resultado:=0;

/*----------------VALIDACION DE CAMPOS----------------*/
  IF descripcion = '' OR descripcion IS NULL THEN
    mensaje:= mensaje || 'descripcion, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF idCentroMedico = '' OR idCentroMedico IS NULL THEN
    mensaje:= mensaje || 'idCentroMedico, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
SELECT COUNT(*) INTO vnConteo
  FROM EXPEDIENTE
  WHERE ID_EXPEDIENTE = idExpediente;
IF vnConteo=0 THEN
  mensaje:='No hay registros del expediente' || idExpediente;
RETURN ;
END IF ;

  INSERT INTO HOJATRABAJOSOCIAL(
    DESCRIPCION,
    ID_EXPEDIENTE,
    ID_CENTRO_MEDICO,
    FECHA
  )VALUES (
    descripcion,
    idExpediente,
    idCentroMedico,
    sysdate
  );

   COMMIT;

    mensaje:='Hoja de Trabajo social ingresada correctamente';
    resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_ActualizarHojaTrabajoSocial(
  idTS IN INT
  ,descripcion IN VARCHAR
  ,idExpediente IN INT
  ,idCentroMedico IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
temMensaje VARCHAR(2000);
vnConteo NUMBER;

BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idTS = '' OR idTS IS NULL THEN
    mensaje:= mensaje || 'idTS, ';
  END IF;
  IF descripcion = '' OR descripcion IS NULL THEN
    mensaje:= mensaje || 'descripcion, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF idCentroMedico = '' OR idCentroMedico IS NULL THEN
    mensaje:= mensaje || 'idCentroMedico, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT COUNT(*) INTO vnConteo
    FROM EXPEDIENTE
    WHERE ID_EXPEDIENTE= idExpediente;
  IF vnConteo=0 THEN
    mensaje:='No existe el registro con el id: ' || idExpediente;
  END IF;
  SELECT  COUNT(*) INTO vnConteo
    FROM HOJATRABAJOSOCIAL
    WHERE ID_TS=idTS;
  IF vnConteo=0 THEN
    mensaje:='No existe la hoja: ' || idTS;
  END IF;
  SELECT COUNT(*) INTO vnConteo
    FROM  CENTROMEDICO
    WHERE idCentroMedico= ID_centro_medico;
  IF vnConteo=0 THEN
    mensaje:='NO esta registrado el centro medico con id: ' || idCentroMedico;
  END IF;

    UPDATE HOJATRABAJOSOCIAL
      SET
        DESCRIPCION=descripcion,
        ID_EXPEDIENTE= idExpediente,
        ID_CENTRO_MEDICO=idCentroMedico
      WHERE
        idTS=ID_TS;
        mensaje:= 'actualizacion realizada correctamente';
      COMMIT ;
      mensaje:='No se pudo actualizar';
      resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_CrearHospitalizacion(
  observacion IN VARCHAR
  ,fechaHoraIngreso IN TIMESTAMP
  ,fechaHoraAlta IN TIMESTAMP
  ,idPiso IN INT
  ,cama IN VARCHAR
  ,idMedico IN INT
  ,idExpediente IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
temMensaje VARCHAR(2000);
vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF observacion = '' OR observacion IS NULL THEN
    mensaje:= mensaje || 'observacion, ';
  END IF;
  IF fechaHoraIngreso = '' OR fechaHoraIngreso IS NULL THEN
    mensaje:= mensaje || 'fechaHoraIngreso, ';
  END IF;
  IF fechaHoraAlta = '' OR fechaHoraAlta IS NULL THEN
    mensaje:= mensaje || 'fechaHoraAlta, ';
  END IF;
  IF idPiso = '' OR idPiso IS NULL THEN
    mensaje:= mensaje || 'idPiso, ';
  END IF;
  IF cama = '' OR cama IS NULL THEN
    mensaje:= mensaje || 'cama, ';
  END IF;
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
SELECT COUNT(*) INTO vnConteo
  FROM PISO
  WHERE idPiso=ID_PISO;
  IF vnConteo=0 THEN
    mensaje:='el id: '|| idPiso || 'no esta registrado';
    RETURN ;
  END IF;

  SELECT COUNT(*) INTO vnConteo
    FROM MEDICO
    WHERE idMedico= ID_MEDICO;
  IF vnConteo=0 THEN
    mensaje:='el medico con el id: '|| idMedico ||'no existe';
    RETURN ;
  END IF;

  SELECT COUNT(*) INTO vnConteo
    FROM EXPEDIENTE
      WHERE idExpediente= ID_EXPEDIENTE;
  IF vnConteo=0 THEN
    mensaje:='No existe registro con el expediente ' || idExpediente;
    RETURN;
  END IF;

    INSERT INTO HOSPITALIZACION(

      OBSERVACION,
      FECHA_HORA_INGRESO,

      ID_PISO,
      CAMA,
      ID_MEDICO,
      ID_EXPEDIENTE
    )VALUES (

      observacion,
      to_date(fechaHoraIngreso),

      idPiso,
      cama,
      idMedico,
      idExpediente
    );
    COMMIT ;
  mensaje:='insercion realizada correctamente';
  resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_DarAlta(
  idIngreso IN INT
  ,fechaHoraAlta IN TIMESTAMP
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
temMensaje VARCHAR(2000);
vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idIngreso = '' OR idIngreso IS NULL THEN
    mensaje:= mensaje || 'idIngreso, ';
  END IF;
  IF fechaHoraAlta = '' OR fechaHoraAlta IS NULL THEN
    mensaje:= mensaje || 'fechaHoraAlta, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT COUNT(*) INTO vnConteo
    FROM HOSPITALIZACION
      WHERE idIngreso=ID_INGRESO;
  IF vnConteo=0 THEN
    mensaje:='No existe la hospitalizacion :' || idIngreso;
    RETURN ;
  END IF;
  UPDATE HOSPITALIZACION
    SET
      FECHA_HORA_ALTA=TO_DATE(fechaHoraAlta)
    WHERE
      idIngreso=ID_INGRESO;
  COMMIT ;
  mensaje:='Se actualizo el registro con exito';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_CrearMedico(
  pNombre IN VARCHAR
  ,sNombre IN VARCHAR
  ,pApellido IN VARCHAR
  ,sApellido IN VARCHAR
  ,direccion IN VARCHAR
  ,sexo IN VARCHAR
  ,noIdentidad IN VARCHAR
  ,idPais IN INT
  ,idEspecialidad IN VARCHAR
  ,noColegiacion IN VARCHAR
  ,correo IN VARCHAR
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
temMensaje VARCHAR(2000);
vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF pNombre = '' OR pNombre IS NULL THEN
    mensaje:= mensaje || 'pNombre, ';
  END IF;
  IF sNombre = '' OR sNombre IS NULL THEN
    mensaje:= mensaje || 'sNombre, ';
  END IF;
  IF pApellido = '' OR pApellido IS NULL THEN
    mensaje:= mensaje || 'pApellido, ';
  END IF;
  IF sApellido = '' OR sApellido IS NULL THEN
    mensaje:= mensaje || 'sApellido, ';
  END IF;
  IF direccion = '' OR direccion IS NULL THEN
    mensaje:= mensaje || 'direccion, ';
  END IF;
  IF sexo = '' OR sexo IS NULL THEN
    mensaje:= mensaje || 'sexo, ';
  END IF;
  IF noIdentidad = '' OR noIdentidad IS NULL THEN
    mensaje:= mensaje || 'noIdentidad, ';
  END IF;
  IF idPais = '' OR idPais IS NULL THEN
    mensaje:= mensaje || 'idPais, ';
  END IF;
  IF idEspecialidad = '' OR idEspecialidad IS NULL THEN
    mensaje:= mensaje || 'idEspecialidad, ';
  END IF;
  IF noColegiacion = '' OR noColegiacion IS NULL THEN
    mensaje:= mensaje || 'noColegiacion, ';
  END IF;
  IF correo = '' OR correo IS NULL THEN
    mensaje:= mensaje || 'correo, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
SELECT COUNT(*) INTO vnConteo
  FROM PAIS
  WHERE  idPais=ID_PAIS;
IF vnConteo=0 THEN
    mensaje:='EL pais: '|| idPais ||'no esta registrado.';
  RETURN ;
END IF;

SELECT COUNT(*) INTO vnConteo
  FROM  ESPECIALIDAD
  WHERE  idEspecialidad=ID_ESPECIALIDAD;
IF vnConteo=0 THEN
  mensaje:='La especialidad: '|| idEspecialidad||'no esta registrada';
  RETURN;
END IF;

SELECT COUNT(*) INTO vnConteo
  FROM PERSONA
  WHERE noIdentidad=NO_IDENTIDAD;
IF vnConteo=0 THEN
  mensaje:='El numero de identidad: '|| noIdentidad||'no existe';
  RETURN ;
END IF;
  INSERT INTO PERSONA(
    P_NOMBRE,
    S_NOMBRE,
    P_APELLIDO,
    S_APELLIDO,
    DIRECCION,

    NO_IDENTIDAD,
    ID_PAIS,
    SEXO,
    CORREO
  )VALUES (
    pNombre,
    sNombre,
    pApellido,
    sApellido,
    direccion,

    noIdentidad,
    idPais,
    sexo,
    correo
  );
  INSERT INTO MEDICO(
    NO_COLEGIACION,
    ID_PERSONA,
    ID_ESPECIALIDAD
  )VALUES (
    noColegiacion,
    ?,
    idEspecialidad
  ) RETURNING ID_PERSONA INTO ID_PERSONA;
    COMMIT ;
    mensaje:='La insercion fue exitosa';
    resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_ActualizarMedico(
  idMedico IN INT
  ,direccion IN VARCHAR
  ,idEspecialidad IN VARCHAR
  ,noColegiacion IN VARCHAR
  ,correo IN VARCHAR
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  temMensaje VARCHAR(2000);
vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF direccion = '' OR direccion IS NULL THEN
    mensaje:= mensaje || 'direccion, ';
  END IF;
  IF idEspecialidad = '' OR idEspecialidad IS NULL THEN
    mensaje:= mensaje || 'idEspecialidad, ';
  END IF;
  IF noColegiacion = '' OR noColegiacion IS NULL THEN
    mensaje:= mensaje || 'noColegiacion, ';
  END IF;
  IF correo = '' OR correo IS NULL THEN
    mensaje:= mensaje || 'correo, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/


SELECT COUNT(*) INTO vnConteo
  FROM MEDICO
  WHERE idMedico=ID_MEDICO;
IF vnConteo=0 THEN
  mensaje:='El medico con registro: '|| idMedico||'no existe';
  RETURN ;
END IF;
SELECT COUNT(*) INTO vnConteo
  FROM  ESPECIALIDAD
  WHERE  idEspecialidad=ID_ESPECIALIDAD;
IF vnConteo=0 THEN
  mensaje:='La especialidad: '|| idEspecialidad||'no esta registrada';
  RETURN;
END IF;
  UPDATE MEDICO
    SET
      NO_COLEGIACION=noColegiacion,
      ID_ESPECIALIDAD=idEspecialidad
    WHERE
      idMedico=ID_MEDICO;
  UPDATE PERSONA
      SET
        DIRECCION=direccion,
        CORREO=correo
      WHERE
        ID_PERSONA= (
          SELECT ID_PERSONA
            FROM MEDICO M
            WHERE  idMedico= M.ID_MEDICO
        ) ;

END;


CREATE OR REPLACE PROCEDURE PL_CrearPaciente(
  pNombre IN VARCHAR
  ,sNombre IN VARCHAR
  ,pApellido IN VARCHAR
  ,sApellido IN VARCHAR
  ,direccion IN VARCHAR
  ,noIdentidad IN VARCHAR
  ,idPais IN INT
  ,sexo IN VARCHAR
  ,correo IN VARCHAR
  ,idTipoSangre IN INT
  ,idEscolaridad IN INT
  ,idOcupacion IN INT
  ,idEstadoCivil IN INT
  ,idAscendencia IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  temMensaje VARCHAR(2000);
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF pNombre = '' OR pNombre IS NULL THEN
    mensaje:= mensaje || 'pNombre, ';
  END IF;
  IF sNombre = '' OR sNombre IS NULL THEN
    mensaje:= mensaje || 'sNombre, ';
  END IF;
  IF pApellido = '' OR pApellido IS NULL THEN
    mensaje:= mensaje || 'pApellido, ';
  END IF;
  IF sApellido = '' OR sApellido IS NULL THEN
    mensaje:= mensaje || 'sApellido, ';
  END IF;
  IF direccion = '' OR direccion IS NULL THEN
    mensaje:= mensaje || 'direccion, ';
  END IF;
  IF noIdentidad = '' OR noIdentidad IS NULL THEN
    mensaje:= mensaje || 'noIdentidad, ';
  END IF;
  IF idPais = '' OR idPais IS NULL THEN
    mensaje:= mensaje || 'idPais, ';
  END IF;
  IF sexo = '' OR sexo IS NULL THEN
    mensaje:= mensaje || 'sexo, ';
  END IF;
  IF correo = '' OR correo IS NULL THEN
    mensaje:= mensaje || 'correo, ';
  END IF;
  IF idTipoSangre = '' OR idTipoSangre IS NULL THEN
    mensaje:= mensaje || 'idTipoSangre, ';
  END IF;
  IF idEscolaridad = '' OR idEscolaridad IS NULL THEN
    mensaje:= mensaje || 'idEscolaridad, ';
  END IF;
  IF idOcupacion = '' OR idOcupacion IS NULL THEN
    mensaje:= mensaje || 'idOcupacion, ';
  END IF;
  IF idEstadoCivil = '' OR idEstadoCivil IS NULL THEN
    mensaje:= mensaje || 'idEstadoCivil, ';
  END IF;
  IF idAscendencia = '' OR idAscendencia IS NULL THEN
    mensaje:= mensaje || 'idAscendencia, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
SELECT COUNT(*) INTO vnConteo
  FROM PERSONA
  WHERE ID_PAIS=idPais;
IF vnConteo=0 THEN
  mensaje:='EL pais con el identificador: '|| idPais||'no esta registrado';
  RETURN ;
END IF;
SELECT COUNT(*) INTO vnConteo
  FROM TIPOSANGRE
  WHERE idTipoSangre= ID_TIPO_SANGRE;
IF vnConteo=0 THEN
  mensaje='EL tipo de sangre: '|| idTipoSangre||'no esta registrado';
  RETURN ;
END IF;
SELECT COUNT(*) INTO vnConteo
  FROM ESCOLARIDAD
  WHERE idEscolaridad= ID_ESCOLARIDAD;
IF vnConteo=0 THEN
  mensaje:='Escolaridad: '|| idEscolaridad||'no esta registrada';
  RETURN ;
END IF;

SELECT COUNT(*) INTO vnConteo
  FROM OCUPACION
  WHERE idOcupacion=ID_OCUPACION;
IF vnConteo=0 THEN
  mensaje:='el identificador de ocupacion: '||idOcupacion||'no esta registrado';
  RETURN ;
END IF;
SELECT COUNT(*) INTO vnConteo
  FROM ESTADOCIVIL
  WHERE idEstadoCivil=ID_ESTADO_CIVIL;
IF vnConteo=0 THEN
   mensaje:='el identificador de estado civil : '||idEstadoCivil||'no esta registrado';
  RETURN ;
END IF;
SELECT COUNT(*) INTO vnConteo
  FROM ASCENDENCIA
  WHERE idAscendencia=ID_ASCENDENCIA;
IF vnConteo=0 THEN
  mensaje:='el identificador de ascendencia con : '|| idAscendencia||'NO esta registrado';
  RETURN ;
END IF;

SELECT COUNT(*) INTO vnConteo
  FROM PERSONA
  WHERE noIdentidad=NO_IDENTIDAD;
IF vnConteo=0 THEN
  mensaje:='El numero de identidad: '|| noIdentidad||'no existe';
  RETURN ;
END IF ;
SELECT COUNT(*) INTO vnConteo
  FROM PAIS
  WHERE  idPais=ID_PAIS;
IF vnConteo=0 THEN
    mensaje:='EL pais: '|| idPais ||'no esta registrado.';
  RETURN ;
END IF;
  INSERT INTO PERSONA(
    P_NOMBRE,
    S_NOMBRE,
    P_APELLIDO,
    S_APELLIDO,
    DIRECCION,

    NO_IDENTIDAD,
    ID_PAIS,
    SEXO,
    CORREO
  )VALUES (
    pNombre,
    sNombre,
    pApellido,
    sApellido,
    direccion,
    noIdentidad,
    idPais,
    sexo,
    correo
  );
  INSERT INTO PACIENTE(
    ID_PERSONA,
    ID_TIPO_SANGRE,
    ID_ESCOLARIDAD,
    ID_OCUPACION,
    ID_ESTADO_CIVIL,
    ID_ASCENDENCIA

  )VALUES (
    ?,
    idTipoSangre,
    idEscolaridad,
    idOcupacion,
    idEstadoCivil,
    idAscendencia
  )RETURNING ID_PERSONA INTO ID_PERSONA;
END;


CREATE OR REPLACE PROCEDURE PL_ActualizarPaciente(
  idPaciente IN INT
  ,direccion IN VARCHAR
  ,correo IN VARCHAR
  ,idEscolaridad IN INT
  ,idOcupacion IN INT
  ,idEstadoCivil IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idPaciente = '' OR idPaciente IS NULL THEN
    mensaje:= mensaje || 'idPaciente, ';
    RETURN ;
  END IF;
  IF direccion = '' OR direccion IS NULL THEN
    mensaje:= mensaje || 'direccion, ';
    RETURN ;
  END IF;
  IF correo = '' OR correo IS NULL THEN
    mensaje:= mensaje || 'correo, ';
    RETURN ;
  END IF;
  IF idEscolaridad = '' OR idEscolaridad IS NULL THEN
    mensaje:= mensaje || 'idEscolaridad, ';
    RETURN ;
  END IF;
  IF idOcupacion = '' OR idOcupacion IS NULL THEN
    mensaje:= mensaje || 'idOcupacion, ';
    RETURN ;
  END IF;
  IF idEstadoCivil = '' OR idEstadoCivil IS NULL THEN
    mensaje:= mensaje || 'idEstadoCivil, ';
    RETURN ;
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/

SELECT COUNT(*) INTO vnConteo
  FROM ESCOLARIDAD
  WHERE idEscolaridad= ID_ESCOLARIDAD;
IF vnConteo=0 THEN
  mensaje:='Escolaridad: '|| idEscolaridad||'no esta registrada';
  RETURN ;
END IF;

SELECT COUNT(*) INTO vnConteo
  FROM OCUPACION
  WHERE idOcupacion=ID_OCUPACION;
IF vnConteo=0 THEN
  mensaje:='el identificador de ocupacion: '||idOcupacion||'no esta registrado';
  RETURN ;
END IF;
SELECT COUNT(*) INTO vnConteo
  FROM ESTADOCIVIL
  WHERE idEstadoCivil=ID_ESTADO_CIVIL;
IF vnConteo=0 THEN
   mensaje:='el identificador de estado civil : '||idEstadoCivil||'no esta registrado';
  RETURN ;
END IF;
UPDATE PACIENTE
  SET
    ID_ESCOLARIDAD=idEscolaridad,
    ID_OCUPACION=idOcupacion,
    ID_ESTADO_CIVIL=idEstadoCivil
  WHERE
    ID_PACIENTE=idPaciente;

  UPDATE  PERSONA
    SET
      DIRECCION=direccion,
      CORREO=correo
    WHERE
      ID_PERSONA=
              (SELECT  P.ID_PERSONA
              FROM PACIENTE P
              WHERE P.ID_PACIENTE=idPaciente);
  COMMIT ;
  mensaje:='Se actualizaron los registros correctamente';
  resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_CrearParamedico(
  pNombre IN VARCHAR
  ,sNombre IN VARCHAR
  ,pApellido IN VARCHAR
  ,sApellido IN VARCHAR
  ,direccion IN VARCHAR
  ,sexo IN VARCHAR
  ,noIdentidad IN VARCHAR
  ,correo IN VARCHAR
  ,idPais IN INT
  ,licencia IN VARCHAR
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF pNombre = '' OR pNombre IS NULL THEN
    mensaje:= mensaje || 'pNombre, ';
  END IF;
  IF sNombre = '' OR sNombre IS NULL THEN
    mensaje:= mensaje || 'sNombre, ';
  END IF;
  IF pApellido = '' OR pApellido IS NULL THEN
    mensaje:= mensaje || 'pApellido, ';
  END IF;
  IF sApellido = '' OR sApellido IS NULL THEN
    mensaje:= mensaje || 'sApellido, ';
  END IF;
  IF direccion = '' OR direccion IS NULL THEN
    mensaje:= mensaje || 'direccion, ';
  END IF;
  IF sexo = '' OR sexo IS NULL THEN
    mensaje:= mensaje || 'sexo, ';
  END IF;
  IF noIdentidad = '' OR noIdentidad IS NULL THEN
    mensaje:= mensaje || 'noIdentidad, ';
  END IF;
  IF correo = '' OR correo IS NULL THEN
    mensaje:= mensaje || 'correo, ';
  END IF;
  IF idPais = '' OR idPais IS NULL THEN
    mensaje:= mensaje || 'idPais, ';
  END IF;
  IF licencia = '' OR licencia IS NULL THEN
    mensaje:= mensaje || 'licencia, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
SELECT COUNT(*) INTO vnConteo
  FROM PERSONA
  WHERE NO_IDENTIDAD=noIdentidad;
IF vnConteo=0 THEN
  mensaje:='el numero de id: '||noIdentidad||'no existe';
  RETURN ;
END IF;

  SELECT COUNT(*) INTO vnConteo
  FROM PAIS
  WHERE  idPais=ID_PAIS;
IF vnConteo=0 THEN
    mensaje:='EL pais: '|| idPais ||'no esta registrado.';
    RETURN ;
END IF;
   INSERT INTO PERSONA(
    P_NOMBRE,
    S_NOMBRE,
    P_APELLIDO,
    S_APELLIDO,
    DIRECCION,
    NO_IDENTIDAD,
    ID_PAIS,
    SEXO,
    CORREO
  )VALUES (
    pNombre,
    sNombre,
    pApellido,
    sApellido,
    direccion,
    noIdentidad,
    idPais,
    sexo,
    correo
  );


  INSERT INTO PARAMEDICO(
    LICENCIA,
    ID_PERSONA
  )VALUES (
    licencia,
    ?
  ) RETURNING ID_PERSONA INTO ID_PERSONA;
  COMMIT ;
  resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_ActualizarParamedico(
  idParamedico IN INT,
  direccion IN VARCHAR
  ,correo IN VARCHAR
  ,licencia IN VARCHAR
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF direccion = '' OR direccion IS NULL THEN
    mensaje:= mensaje || 'direccion, ';
  END IF;
  IF correo = '' OR correo IS NULL THEN
    mensaje:= mensaje || 'correo, ';
  END IF;
  IF licencia = '' OR licencia IS NULL THEN
    mensaje:= mensaje || 'licencia, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
SELECT COUNT(*) INTO vnConteo
  FROM PARAMEDICO
  WHERE ID_PARAMEDICO=idParamedico;
IF vnConteo=0 THEN
  mensaje:=idParamedico ||'No esta registrado como paramedico';
  RETURN ;
END IF;
  UPDATE  PERSONA
    SET
      DIRECCION=direccion,
      CORREO=correo
    WHERE
      ID_PERSONA=
            (SELECT ID_PERSONA
            FROM PARAMEDICO
            WHERE ID_PARAMEDICO=idParamedico);

  UPDATE PARAMEDICO
    SET
      LICENCIA=licencia
    WHERE idParamedico=ID_PARAMEDICO;
END;


CREATE OR REPLACE PROCEDURE PL_CrearReferencia(
  idReferencia IN INT
  ,descripcion IN VARCHAR
  ,idMedico IN INT
  ,idExpediente IN INT
  ,idCentroMedicoRemite IN INT
  ,idCentroMedicoRecibe IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idReferencia = '' OR idReferencia IS NULL THEN
    mensaje:= mensaje || 'idReferencia, ';
  END IF;
  IF descripcion = '' OR descripcion IS NULL THEN
    mensaje:= mensaje || 'descripcion, ';
  END IF;
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF idCentroMedicoRemite = '' OR idCentroMedicoRemite IS NULL THEN
    mensaje:= mensaje || 'idCentroMedicoRemite, ';
  END IF;
  IF idCentroMedicoRecibe = '' OR idCentroMedicoRecibe IS NULL THEN
    mensaje:= mensaje || 'idCentroMedicoRecibe, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT COUNT(*) INTO vnConteo
    FROM MEDICO
    WHERE idMedico=ID_MEDICO;
  IF vnConteo=0 THEN
    mensaje:='El medico con identificador: '||idMedico||'no esta registrado';
    RETURN ;
  END IF;

 SELECT COUNT(*) INTO vnConteo
    FROM EXPEDIENTE
    WHERE idExpediente=ID_EXPEDIENTE;
  IF vnConteo=0 THEN
    mensaje:='El expediente con identificador: '||idExpediente||'no esta registrado';
    RETURN ;
  END IF;

  SELECT COUNT(*) INTO vnConteo
    FROM CENTROMEDICO
    WHERE idCentroMedicoRemite=ID_CENTRO_MEDICO AND idCentroMedicoRecibe=ID_CENTRO_MEDICO;
  IF vnConteo=0 THEN
    mensaje:='El CENTRO medico no esta registrado';
    RETURN ;
  END IF;

  INSERT INTO REFERENCIA(
    DESCRIPCION,
    ID_MEDICO,
    ID_EXPEDIENTE,
    ID_CENTRO_MEDICO_REMITE,
    ID_CENTRO_MEDICO_RECIBE
  )VALUES (
    descripcion,
    idMedico,
    idExpediente,
    idCentroMedicoRemite,
    idCentroMedicoRecibe
  );
  COMMIT ;
  mensaje:='se ha creado la referencia con exito CAPITAN!';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_ActualizarReferencia(
  idReferencia IN INT
  ,idReferencia IN INT
  ,descripcion IN VARCHAR
  ,idMedico IN INT
  ,idExpediente IN INT
  ,idCentroMedicoRemite IN INT
  ,idCentroMedicoRecibe IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idReferencia = '' OR idReferencia IS NULL THEN
    mensaje:= mensaje || 'idReferencia, ';
  END IF;
  IF idReferencia = '' OR idReferencia IS NULL THEN
    mensaje:= mensaje || 'idReferencia, ';
  END IF;
  IF descripcion = '' OR descripcion IS NULL THEN
    mensaje:= mensaje || 'descripcion, ';
  END IF;
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF idExpediente = '' OR idExpediente IS NULL THEN
    mensaje:= mensaje || 'idExpediente, ';
  END IF;
  IF idCentroMedicoRemite = '' OR idCentroMedicoRemite IS NULL THEN
    mensaje:= mensaje || 'idCentroMedicoRemite, ';
  END IF;
  IF idCentroMedicoRecibe = '' OR idCentroMedicoRecibe IS NULL THEN
    mensaje:= mensaje || 'idCentroMedicoRecibe, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/

  SELECT COUNT(*) INTO vnConteo
    FROM REFERENCIA
    WHERE idReferencia=ID_REFERENCIA;
  IF vnConteo=0 THEN
    mensaje:='No existe la referencia con el identificador: '|| idReferencia ;
    RETURN ;
  END IF;


    SELECT COUNT(*) INTO vnConteo
    FROM MEDICO
    WHERE idMedico=ID_MEDICO;
  IF vnConteo=0 THEN
    mensaje:='El medico con identificador: '||idMedico||'no esta registrado';
    RETURN ;
  END IF;

 SELECT COUNT(*) INTO vnConteo
    FROM EXPEDIENTE
    WHERE idExpediente=ID_EXPEDIENTE;
  IF vnConteo=0 THEN
    mensaje:='El expediente con identificador: '||idExpediente||'no esta registrado';
    RETURN ;
  END IF;

  SELECT COUNT(*) INTO vnConteo
    FROM CENTROMEDICO
    WHERE idCentroMedicoRemite=ID_CENTRO_MEDICO AND idCentroMedicoRecibe=ID_CENTRO_MEDICO;
  IF vnConteo=0 THEN
    mensaje:='El CENTRO medico no esta registrado';
    RETURN ;
  END IF;

  UPDATE REFERENCIA
  SET
    DESCRIPCION=descripcion,
    ID_MEDICO=idMedico,
    ID_EXPEDIENTE=idExpediente,
    ID_CENTRO_MEDICO_REMITE=idCentroMedicoRemite,
    ID_CENTRO_MEDICO_RECIBE=idCentroMedicoRecibe
  WHERE
      idReferencia=ID_REFERENCIA;
  COMMIT ;
  mensaje:='Se actualizo la referencia correctamente, Cappitan!';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_PL_AgregarPersona(
  pNombre IN VARCHAR
  ,sNombre IN VARCHAR
  ,pApellido IN VARCHAR
  ,sApellido IN VARCHAR
  ,direccion IN VARCHAR
  ,noIdentidad IN VARCHAR
  ,idPais IN INT
  ,sexo IN VARCHAR
  ,correo IN VARCHAR
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF pNombre = '' OR pNombre IS NULL THEN
    mensaje:= mensaje || 'pNombre, ';
  END IF;
  IF sNombre = '' OR sNombre IS NULL THEN
    mensaje:= mensaje || 'sNombre, ';
  END IF;
  IF pApellido = '' OR pApellido IS NULL THEN
    mensaje:= mensaje || 'pApellido, ';
  END IF;
  IF sApellido = '' OR sApellido IS NULL THEN
    mensaje:= mensaje || 'sApellido, ';
  END IF;
  IF direccion = '' OR direccion IS NULL THEN
    mensaje:= mensaje || 'direccion, ';
  END IF;
  IF noIdentidad = '' OR noIdentidad IS NULL THEN
    mensaje:= mensaje || 'noIdentidad, ';
  END IF;
  IF idPais = '' OR idPais IS NULL THEN
    mensaje:= mensaje || 'idPais, ';
  END IF;
  IF sexo = '' OR sexo IS NULL THEN
    mensaje:= mensaje || 'sexo, ';
  END IF;
  IF correo = '' OR correo IS NULL THEN
    mensaje:= mensaje || 'correo, ';
  END IF;
  IF mensaje<>'' THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
SELECT COUNT(*) INTO vnConteo
  FROM PAIS
  WHERE  idPais=ID_PAIS;
IF vnConteo=0 THEN
    mensaje:='EL pais: '|| idPais ||'no esta registrado.';
    RETURN ;
END IF;
   INSERT INTO PERSONA(
    P_NOMBRE,
    S_NOMBRE,
    P_APELLIDO,
    S_APELLIDO,
    DIRECCION,
    NO_IDENTIDAD,
    ID_PAIS,
    SEXO,
    CORREO
  )VALUES (
    pNombre,
    sNombre,
    pApellido,
    sApellido,
    direccion,
    noIdentidad,
    idPais,
    sexo,
    correo
  );
  COMMIT ;
  mensaje:='Se ingreso la informacion correctamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_AgregartelefonoxCentro(
  idCentroMedico IN INT
  ,telefono IN VARCHAR
  ,idTipoTelefono IN INT
  ,idPais IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idCentroMedico = '' OR idCentroMedico IS NULL THEN
    mensaje:= mensaje || 'idCentroMedico, ';
  END IF;
  IF telefono = '' OR telefono IS NULL THEN
    mensaje:= mensaje || 'telefono, ';
  END IF;
  IF idTipoTelefono = '' OR idTipoTelefono IS NULL THEN
    mensaje:= mensaje || 'idTipoTelefono, ';
  END IF;
  IF idPais = '' OR idPais IS NULL THEN
    mensaje:= mensaje || 'idPais, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
 SELECT COUNT(*) INTO vnConteo
    FROM CENTROMEDICO
    WHERE idCentroMedico=ID_CENTRO_MEDICO ;
  IF vnConteo=0 THEN
    mensaje:='El CENTRO medico con identificador: '||idCentroMedico||' no esta registrado';
    RETURN ;
  END IF;
  SELECT COUNT(*) INTO vnConteo
    FROM TIPOTELEFONO
    WHERE idTipoTelefono=ID_TIPO_TELEFONO;
  IF vnConteo=0 THEN
    mensaje:='El TIPO de telefono: '||idTipoTelefono||' no esta registrado';
    RETURN ;
  END IF;
  SELECT COUNT(*) INTO vnConteo
  FROM PAIS
  WHERE  idPais=ID_PAIS;
IF vnConteo=0 THEN
    mensaje:='EL pais: '|| idPais ||'no esta registrado.';
    RETURN ;
END IF;

  INSERT INTO TELEFONO (
    TELEFONO,
    ID_TIPO_TELEFONO,
    ID_PAIS
  )VALUES(
    telefono,
    idTipoTelefono,
    idPais
  );

  INSERT INTO TELEFONOCENTROMEDICO (
  )VALUES(
    idCentroMedico=ID_CENTRO_MEDICO,
    ?

  )RETURNING ID_TELEFONO INTO ID_TELEFONO;

  COMMIT ;
  mensaje:='Se ingreso la informacion correctamente';
  resultado:=1;
END;




CREATE OR REPLACE PROCEDURE PL_actualizarViaSuministro(
  idViaSuministro IN INT
  ,viaSuministro IN VARCHAR
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idViaSuministro = '' OR idViaSuministro IS NULL THEN
    mensaje:= mensaje || 'idViaSuministro, ';
  END IF;
  IF viaSuministro = '' OR viaSuministro IS NULL THEN
    mensaje:= mensaje || 'viaSuministro, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
SELECT count(*) INTO vnConteo
  FROM VIASUMINISTRO
  WHERE id_via_suministro=idViaSuministro;
IF vnConteo=0 THEN
  mensaje:='NO esta registrado el identificador: '|| idViaSuministro;
END IF;

  UPDATE VIASUMINISTRO
    SET
      VIA_SUMINISTRO=viaSuministro
    WHERE idViaSuministro=ID_VIA_SUMINISTRO;

  COMMIT ;
  mensaje:='Se actualizo la informacion correctamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_crearTratamiento(
  dosis IN VARCHAR
  ,intervaloTiempo IN VARCHAR
  ,fechaInicio IN DATE
  ,duracionTratamiento IN VARCHAR
  ,idTipo IN INT
  ,idViaSuministro IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/

  IF dosis = '' OR dosis IS NULL THEN
    mensaje:= mensaje || 'dosis, ';
  END IF;
  IF intervaloTiempo = '' OR intervaloTiempo IS NULL THEN
    mensaje:= mensaje || 'intervaloTiempo, ';
  END IF;
  IF fechaInicio = '' OR fechaInicio IS NULL THEN
    mensaje:= mensaje || 'fechaInicio, ';
  END IF;
  IF duracionTratamiento = '' OR duracionTratamiento IS NULL THEN
    mensaje:= mensaje || 'duracionTratamiento, ';
  END IF;
  IF idTipo = '' OR idTipo IS NULL THEN
    mensaje:= mensaje || 'idTipo, ';
  END IF;
  IF idViaSuministro = '' OR idViaSuministro IS NULL THEN
    mensaje:= mensaje || 'idViaSuministro, ';
  END IF;
  IF mensaje<>'' THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT COUNT(* ) INTO vnConteo
    FROM  TIPOTRATAMIENTO
    WHERE idTipo=ID_TIPO;
  IF vnConteo=0 THEN
    mensaje:='El tipo de tratamiento con el identificador: '||idTipo ||'no esta registrado';
    RETURN ;
  END IF;

  SELECT COUNT(*) INTO vnConteo
    FROM  VIASUMINISTRO
    WHERE idViaSuministro=ID_VIA_SUMINISTRO;
  IF vnConteo=0 THEN
    mensaje:='la via de suministro con identificador: '||idViaSuministro||'no esta registrada';
    RETURN ;
  END IF;

  INSERT INTO TRATAMIENTO(

    DOSIS ,
    INTERVALO_TIEMPO,
    FECHA_INICIO,
    DURACION_TRATAMIENTO,
    ID_TIPO,
    ID_VIA_SUMINISTRO

  )VALUES (

    dosis ,
    intervaloTiempo,
    fechaInicio,
    duracionTratamiento,
    idTipo ,
    idViaSuministro
  );

  COMMIT ;
  mensaje:='Se ingreso la informacion correctamente';
  resultado:=1;

END;


CREATE OR REPLACE PROCEDURE PL_crearTratamiento(
  idTratamiento IN INT
  ,dosis IN VARCHAR
  ,intervaloTiempo IN VARCHAR
  ,fechaInicio IN DATE
  ,duracionTratamiento IN VARCHAR
  ,idTipo IN INT
  ,idViaSuministro IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idTratamiento = '' OR idTratamiento IS NULL THEN
    mensaje:= mensaje || 'idTratamiento, ';
  END IF;
  IF dosis = '' OR dosis IS NULL THEN
    mensaje:= mensaje || 'dosis, ';
  END IF;
  IF intervaloTiempo = '' OR intervaloTiempo IS NULL THEN
    mensaje:= mensaje || 'intervaloTiempo, ';
  END IF;
  IF fechaInicio = '' OR fechaInicio IS NULL THEN
    mensaje:= mensaje || 'fechaInicio, ';
  END IF;
  IF duracionTratamiento = '' OR duracionTratamiento IS NULL THEN
    mensaje:= mensaje || 'duracionTratamiento, ';
  END IF;
  IF idTipo = '' OR idTipo IS NULL THEN
    mensaje:= mensaje || 'idTipo, ';
  END IF;
  IF idViaSuministro = '' OR idViaSuministro IS NULL THEN
    mensaje:= mensaje || 'idViaSuministro, ';
  END IF;
  IF mensaje<>'' THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
  SELECT COUNT(* ) INTO vnConteo
    FROM  TIPOTRATAMIENTO
    WHERE idTipo=ID_TIPO;
  IF vnConteo=0 THEN
    mensaje:='El tipo de tratamiento con el identificador: '||idTipo ||'no esta registrado';
    RETURN ;
  END IF;

  SELECT COUNT(*) INTO vnConteo
    FROM  VIASUMINISTRO
    WHERE idViaSuministro=ID_VIA_SUMINISTRO;
  IF vnConteo=0 THEN
    mensaje:='la via de suministro con identificador: '||idViaSuministro||'no esta registrada';
    RETURN ;
  END IF;

  INSERT INTO TRATAMIENTO(
    ID_TRATAMIENTO ,
    DOSIS ,
    INTERVALO_TIEMPO,
    FECHA_INICIO,
    DURACION_TRATAMIENTO,
    ID_TIPO,
    ID_VIA_SUMINISTRO

  )VALUES (
    idTratamiento ,
    dosis ,
    intervaloTiempo,
    fechaInicio,
    duracionTratamiento,
    idTipo ,
    idViaSuministro
  );
  COMMIT ;
  mensaje:='Se ingreso la informacion correctamente';
  resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_Recetar(
  idTratamiento IN INT
  ,idConsulta IN INT
  ,idMedico IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idTratamiento = '' OR idTratamiento IS NULL THEN
    mensaje:= mensaje || 'idTratamiento, ';
  END IF;
  IF idConsulta = '' OR idConsulta IS NULL THEN
    mensaje:= mensaje || 'idConsulta, ';
  END IF;
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
SELECT COUNT(*) INTO vnConteo
    FROM  TRATAMIENTO
    WHERE idTratamiento=ID_TRATAMIENTO;
  IF vnConteo=0 THEN
    mensaje:='el tratamiento con identificador: '||idTratamiento||'no esta registrada';
    RETURN ;
  END IF;
  SELECT COUNT(*) INTO vnConteo
    FROM  CONSULTAEXTERNA
    WHERE idConsulta=ID_CONSULTA;
  IF vnConteo=0 THEN
    mensaje:='la consulta con identificador: '||idConsulta||'no esta registrada';
    RETURN ;
  END IF;

  SELECT COUNT(*) INTO vnConteo
    FROM  MEDICO
    WHERE idMedico=ID_MEDICO;
  IF vnConteo=0 THEN
    mensaje:='el medico con identificador: '||idMedico||'no esta registradi';
    RETURN ;
  END IF;

  INSERT  INTO TRATAMIENTOCONSULTA(
    ID_CONSULTA,
    ID_TRATAMIENTO,
    ID_MEDICO
  )VALUES (
    idConsulta,
    idTratamiento,
    idMedico
  );
  COMMIT;
  mensaje:='se ingreso la informacion correctamente';
  resultado:=1;
END;


CREATE OR REPLACE PROCEDURE PL_ActualizarReceta(
  idTratamiento IN INT
  ,idConsulta IN INT
  ,idMedico IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  vnConteo NUMBER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idTratamiento = '' OR idTratamiento IS NULL THEN
    mensaje:= mensaje || 'idTratamiento, ';
  END IF;
  IF idConsulta = '' OR idConsulta IS NULL THEN
    mensaje:= mensaje || 'idConsulta, ';
  END IF;
  IF idMedico = '' OR idMedico IS NULL THEN
    mensaje:= mensaje || 'idMedico, ';
  END IF;
  IF mensaje<>'' OR mensaje IS NOT NULL THEN
    mensaje:='Campos requeridos: '||mensaje;
    RETURN;
  END IF;
/*---------------- CUERPO DEL PL----------------*/
SELECT COUNT(*) INTO vnConteo
    FROM  TRATAMIENTO
    WHERE idTratamiento=ID_TRATAMIENTO;
  IF vnConteo=0 THEN
    mensaje:='el tratamiento con identificador: '||idTratamiento||'no esta registrada';
    RETURN ;
  END IF;
  SELECT COUNT(*) INTO vnConteo
    FROM  CONSULTAEXTERNA
    WHERE idConsulta=ID_CONSULTA;
  IF vnConteo=0 THEN
    mensaje:='la consulta con identificador: '||idConsulta||'no esta registrada';
    RETURN ;
  END IF;

  SELECT COUNT(*) INTO vnConteo
    FROM  MEDICO
    WHERE idMedico=ID_MEDICO;
  IF vnConteo=0 THEN
    mensaje:='el medico con identificador: '||idMedico||'no esta registradi';
    RETURN ;
  END IF;

  UPDATE TRATAMIENTOCONSULTA
    SET
    ID_CONSULTA=idConsulta,
    ID_TRATAMIENTO=idTratamiento,
    ID_MEDICO=idMedico
  WHERE
    ID_TRATAMIENTO=idTratamiento;
  COMMIT ;
  mensaje:='Se actualizo la receta correctamente';
END;



