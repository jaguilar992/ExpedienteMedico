CREATE OR REPLACE FUNCTION FN_EstadisticaEmergencias(
	pidCentro IN INT,
	mensaje OUT VARCHAR,
	resultado SMALLINT
)RETURN NUMBER
IS 
vnConteo NUMBER;
estEmergencia NUMBER;
----------VERIFICACION DE LOS CAMPOS-----------
IF pidCentro='' OR pidCentro IS NULL THEN
	mensaje:= mensaje|| 'pidCentro: ';
END IF;

IF mensaje<>'' OR mensaje IS NOT NULL THEN
	mensaje:= 'Campos requeridos: '||mensaje;
RETURN -1;
END IF;
-----------------CUERPO DE LA FN----------------------------
SELECT COUNT(*) 
INTO vnConteo
FROM CENTROMEDICO
WHERE id_centro_medico=pidCentro;

IF vnConteo=0 THEN
mensaje:='El centro medico con id: '||  vnConteo ||'no existe';
RETURN -1;
END IF:

SELECT COUNT(*)
FROM vw_emergenciasXhoy
WHERE id_centro_medico=pidCentro;

Mensaje:='consulta realizada con éxito'
Resultado:=1;
RETURN estEmergencia;
END;