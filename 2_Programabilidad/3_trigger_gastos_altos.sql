-- Trigger para registrar gastos altos
DELIMITER //
CREATE TRIGGER trigger_gastos_altos
AFTER INSERT ON Gasto
FOR EACH ROW
BEGIN
    IF NEW.importe > 1000.00 THEN
        INSERT INTO GASTOS_ALTOS (codigo_empleado, codigo_proyecto, fecha, importe)
        VALUES (NEW.codigo_empleado, NEW.codigo_proyecto, NEW.fecha, NEW.importe);
    END IF;
END;//
DELIMITER ;
