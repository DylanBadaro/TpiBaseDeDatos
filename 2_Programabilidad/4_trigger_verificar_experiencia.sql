-- Trigger para verificar experiencia mínima de analistas
DELIMITER //
CREATE TRIGGER trigger_verificar_experiencia
BEFORE INSERT ON Producto
FOR EACH ROW
BEGIN
    DECLARE experiencia INT;
    SELECT anios_exp INTO experiencia
    FROM Empleado
    WHERE codigo_empleado = NEW.responsable;

    IF experiencia < 2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El analista no cuenta con al menos 2 años de experiencia.';
    END IF;
END;//
DELIMITER ;
