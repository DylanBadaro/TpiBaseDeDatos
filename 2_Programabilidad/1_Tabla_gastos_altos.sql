-- Crear tabla para registrar los gastos altos
CREATE TABLE GASTOS_ALTOS (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_empleado INT,
    codigo_proyecto INT,
    fecha DATE,
    importe DECIMAL(10,2),
    FOREIGN KEY (codigo_empleado) REFERENCES Empleado(codigo_empleado),
    FOREIGN KEY (codigo_proyecto) REFERENCES Proyecto(codigo_proyecto)
);

