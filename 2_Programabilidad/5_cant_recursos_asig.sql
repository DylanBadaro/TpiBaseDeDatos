DELIMITER //
CREATE PROCEDURE cant_recursos_por_proy(IN cod_proy INT, OUT cant_proy INT)
BEGIN
    SELECT COUNT(DISTINCT fr.codigo_recurso) INTO cant_proy
    FROM fase_recurso fr
    JOIN fase f ON fr.codigo_fase = f.codigo_fase
    WHERE f.codigo_proyecto = cod_proy;
END //
DELIMITER ;

-- Llamada al procedimiento
CALL cant_recursos_por_proy(3, @total_recursos);
SELECT @total_recursos AS CantidadRecursos;
