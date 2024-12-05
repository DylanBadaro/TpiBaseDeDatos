-- Seguridad: 
-- Crear usuarios
CREATE USER 'programador_tpi'@'127.0.0.1' IDENTIFIED BY 'Prog#2024!';
-- Función: Realizar consultas y modificaciones básicas relacionadas con el desarrollo.

CREATE USER 'disenador_tpi'@'127.0.0.1' IDENTIFIED BY 'Disen@2024!';
-- Función: Visualizar datos relevantes para diseño o reportes.

CREATE USER 'admin_tpi'@'127.0.0.1' IDENTIFIED BY 'Adm1n#2024!';
-- Función: Gestionar la base de datos, usuarios, y respaldos.

-- Asignar permisos
GRANT SELECT, INSERT, UPDATE, DELETE ON BdTpiBaseDatos.* TO 'programador_tpi'@'127.0.0.1';
GRANT SELECT ON BdTpiBaseDatos.* TO 'disenador_tpi'@'127.0.0.1';
GRANT ALL PRIVILEGES ON BdTpiBaseDatos.* TO 'admin_tpi'@'127.0.0.1';

-- Aplicar cambios
FLUSH PRIVILEGES;
-- Recarga las tablas de permisos en memoria.

-- Restricción de conexión: solo desde el host local (127.0.0.1).


-- Respaldo y recuperacion:
CREATE USER 'backup_user'@'127.0.0.1' IDENTIFIED BY 'Backup#2024!';
/*CREATE USER: Crea un nuevo usuario en MySQL.
'backup_user': Es el nombre del usuario que estás creando.
@'127.0.0.1': Restringe las conexiones de este usuario únicamente al servidor local. Esto aumenta la seguridad al evitar conexiones remotas.
IDENTIFIED BY 'Backup#2024!': Asigna la contraseña Backup#2024! al usuario. La contraseña debe cumplir con las políticas de seguridad de MySQL.*/
GRANT SELECT, LOCK TABLES, SHOW DATABASES ON *.* TO 'backup_user'@'127.0.0.1';
/*¿Qué hace cada permiso?
SELECT:
Permite al usuario leer datos de todas las tablas en todas las bases de datos (*.* significa "todas las bases de datos y todas las tablas"). Este permiso es fundamental para respaldos, ya que el comando mysqldump utiliza SELECT para extraer los datos.

LOCK TABLES:
Permite al usuario bloquear tablas durante el proceso de respaldo. Esto garantiza que los datos no cambien mientras se realiza el respaldo, asegurando la consistencia del archivo generado.

SHOW DATABASES:
Permite al usuario ver la lista de bases de datos disponibles. Esto es útil si deseas respaldar varias bases de datos o si mysqldump requiere identificar el esquema.
Alcance de los permisos:
ON *.*: Aplica los permisos a todas las bases de datos (*) y todas las tablas dentro de esas bases de datos (*).
TO 'backup_user'@'127.0.0.1': Especifica que estos privilegios se asignan exclusivamente al usuario backup_user que se conecta desde el host local (127.0.0.1).
*/
FLUSH PRIVILEGES;

/*
Tipo de respaldo: completo diario (almacenado localmente).
Frecuencia: Diario a las 23:00 horas.
Ubicación de respaldos: Carpeta local: C:\Backups\BdTpiBaseDatos.

Pruebas de recuperación:
Se deben realizar una restauración semanal para verificar la integridad de los datos.

Comando desde la terminal o configurar una tarea automática usando mysqldump:
Respaldo:
mysqldump -u backup_user -p'Backup#2024!' BdTpiBaseDatos > C:\Backups\BdTpiBaseDatos\backup_$(date +%Y%m%d).sql

Restaurar respaldo:
mysql -u root -p BdTpiBaseDatos < C:\Backups\BdTpiBaseDatos\backup_YYYYMMDD.sql
*/

