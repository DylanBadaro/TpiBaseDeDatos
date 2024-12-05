@echo off
set BACKUP_DIR=D:\basedatos\Work\backup

REM Verifica si la carpeta existe, si no, la crea
if not exist "%BACKUP_DIR%" (
    mkdir "%BACKUP_DIR%"
)

REM Realiza el respaldo
set DATE=%date:~10,4%%date:~7,2%%date:~4,2%
mysqldump -u backup_user -pBackup#2024! BdTpiBaseDatos > %BACKUP_DIR%\backup_%DATE%.sql

REM Mensaje de confirmación
echo Respaldo completado: %BACKUP_DIR%\backup_%DATE%.sql
pause
