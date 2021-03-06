CREATE OR REPLACE PROCEDURE PL_DiagnosticarEnfermedad(
  idEnfermedad IN INT
  ,idConsulta IN INT
  ,mensaje OUT VARCHAR
  ,resultado OUT SMALLINT
)
IS
--DECLARE
  contador INTEGER;
  idExpediente INTEGER;
  idMedico INTEGER;
BEGIN
  mensaje:='';
  resultado:=0;
/*----------------VALIDACION DE CAMPOS----------------*/
  IF idEnfermedad = '' OR idEnfermedad IS NULL THEN
    mensaje:= mensaje || 'idEnfermedad, ';
  END IF;
--   IF idMedico = '' OR idMedico IS NULL THEN
--     mensaje:= mensaje || 'idMedico, ';
--   END IF;
--   IF fechaDiagnostico = '' OR fechaDiagnostico IS NULL THEN
--     mensaje:= mensaje || 'fechaDiagnostico, ';
--   END IF;
--   IF idExpediente = '' OR idExpediente IS NULL THEN
--     mensaje:= mensaje || 'idExpediente, ';
--   END IF;
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
  FROM CONSULTAEXTERNA
  WHERE ID_CONSULTA = idConsulta
  ;
  IF contador=0 THEN
    mensaje:='No existe codigo de consulta ingresada';
    RETURN;
  END IF;

  SELECT
    ID_MEDICO
  INTO idMedico
  FROM CONSULTAEXTERNA
  WHERE ID_CONSULTA = idConsulta
  ;

  SELECT
    ID_EXPEDIENTE
  INTO idExpediente
  FROM CONSULTAEXTERNA
  WHERE ID_CONSULTA = idConsulta
  ;

  INSERT INTO ENFERMEDADCONSULTA
  (ID_MEDICO, ESTADO, FECHA_DIAGNOSTICO, ID_EXPEDIENTE, ID_CONSULTA) VALUES
  (idMedico, 1, SYSDATE, idExpediente, idConsulta);
  COMMIT;
  mensaje:='Registro insertado satisfactoriamente';
  resultado:=1;

END;
/