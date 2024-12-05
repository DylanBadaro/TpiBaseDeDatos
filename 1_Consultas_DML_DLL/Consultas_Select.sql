/* 1.Crear una vista mediante la cual la empresa pueda contar con un listado 
de los proyectos no finalizados aun, con la cantidad de fases realizadas, 
total de gastos, y cantidad de empleados asignados. */


CREATE VIEW Vista_Proyectos_No_Finalizados AS
SELECT 
    p.codigo_proyecto,
    p.nombre AS nombre_proyecto,
    COUNT(DISTINCT f.codigo_fase) AS cantidad_fases_realizadas,
    COALESCE(SUM(g.importe), 0) AS total_gastos,
    COUNT(DISTINCT ep.codigo_empleado) AS cantidad_empleados_asignados
FROM Proyecto p
LEFT JOIN Fase f ON p.codigo_proyecto = f.codigo_proyecto
LEFT JOIN Gasto g ON p.codigo_proyecto = g.codigo_proyecto
LEFT JOIN Fase_Recurso fr ON f.codigo_fase = fr.codigo_fase
LEFT JOIN Empleado_Producto ep ON fr.codigo_recurso = ep.codigo_producto
WHERE p.fecha_fin IS NULL OR p.fecha_fin > CURRENT_DATE
GROUP BY p.codigo_proyecto, p.nombre;

SELECT * FROM proyecto_basededatos.vista_proyectos_no_finalizados;

/*2.El contador pidió tener los promedios de gastos que cada empleado efectúa en 
cada proyecto que participa. Crear una vista que provea esta información.*/

CREATE VIEW Vista_Promedios_Gastos_Empleado AS
SELECT 
    g.codigo_empleado,
    e.nombre AS nombre_empleado,
    g.codigo_proyecto,
    p.nombre AS nombre_proyecto,
    AVG(g.importe) AS promedio_gasto
FROM 
    Gasto g
INNER JOIN Empleado e ON g.codigo_empleado = e.codigo_empleado
INNER JOIN Proyecto p ON g.codigo_proyecto = p.codigo_proyecto
GROUP BY 
    g.codigo_empleado, e.nombre, g.codigo_proyecto, p.nombre;

SELECT * FROM proyecto_basededatos.vista_Promedios_Gastos_Empleado;

/*3.Listar los Jefes de proyectos que mayor cantidad de horas dedicadas tienen.
 */
SELECT 
    jp.codigo_empleado,
    e.nombre AS nombre_empleado,
    jp.horas_dedicadas
FROM 
    Jefe_Proyecto jp
INNER JOIN Empleado e 
    ON jp.codigo_empleado = e.codigo_empleado
WHERE 
    jp.horas_dedicadas = (
        SELECT MAX(horas_dedicadas)
        FROM Jefe_Proyecto
    );
  
/*4.Nombre de los proyectos que generaron al menos tres productos distintos.*/
SELECT 
    p.nombre AS nombre_proyecto
FROM 
    Proyecto p
INNER JOIN Fase f ON p.codigo_proyecto = f.codigo_proyecto
INNER JOIN Producto prod ON f.codigo_fase = prod.codigo_producto
GROUP BY 
    p.codigo_proyecto, p.nombre
HAVING 
    COUNT(DISTINCT prod.codigo_producto) >= 3;
    
/* 5. Listar los nombres de los Analistas con más de cinco años de experiencia 
que nunca fueron asignados como responsables de productos de software de tipo “diagrama”.*/
    
SELECT 
    e.nombre AS nombre_analista
FROM 
    Analista a
INNER JOIN Empleado e ON a.codigo_empleado = e.codigo_empleado
WHERE 
    e.anios_exp > 5
    AND e.codigo_empleado NOT IN (
        SELECT responsable
        FROM Producto p
        INNER JOIN Software s ON p.codigo_producto = s.codigo_producto
        WHERE s.tipo = 'diagrama'
    );

/*6. Listar los empleados (Informáticos) que hayan trabajado en todos los proyectos.*/

SELECT e.nombre AS nombre_informatico
FROM Empleado e
JOIN Informatico i ON e.codigo_empleado = i.codigo_empleado
JOIN Empleado_Producto ep ON e.codigo_empleado = ep.codigo_empleado
GROUP BY e.codigo_empleado, e.nombre
HAVING COUNT(DISTINCT ep.codigo_producto) = (SELECT COUNT(*) FROM Proyecto);
