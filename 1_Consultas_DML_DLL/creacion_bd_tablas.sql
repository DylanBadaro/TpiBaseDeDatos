use BdTpiBaseDatos;
CREATE TABLE Proyecto (
    codigo_proyecto INT PRIMARY KEY,
    nombre VARCHAR(100),
    cliente VARCHAR(100),
    descripcion TEXT,
    presupuesto DECIMAL(10,2),
    horas_totales INT,
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE Fase (
    codigo_fase INT PRIMARY KEY,
    nombre VARCHAR(100),
    estado VARCHAR(20),
    fecha_inicio DATE,
    fecha_fin DATE,
    codigo_proyecto INT,
    FOREIGN KEY (codigo_proyecto) REFERENCES Proyecto(codigo_proyecto)
);

CREATE TABLE Empleado (
    codigo_empleado INT PRIMARY KEY,
    DNI VARCHAR(10),
    nombre VARCHAR(100),
    direccion VARCHAR(100),
    titulacion VARCHAR(50),
    anios_exp INT
);

CREATE TABLE Jefe_Proyecto (
    codigo_empleado INT PRIMARY KEY,
    horas_dedicadas INT,
    coste_participacion DECIMAL(10,2),
    FOREIGN KEY (codigo_empleado) REFERENCES Empleado(codigo_empleado)
);

CREATE TABLE Informatico (
    codigo_empleado INT PRIMARY KEY,
    horas_dedicadas INT,
    coste_participacion DECIMAL(10,2),
    FOREIGN KEY (codigo_empleado) REFERENCES Empleado(codigo_empleado)
);

CREATE TABLE Analista (
    codigo_empleado INT PRIMARY KEY,
    FOREIGN KEY (codigo_empleado) REFERENCES Informatico(codigo_empleado)
);

CREATE TABLE Programador (
    codigo_empleado INT PRIMARY KEY,
    lenguajes_programacion VARCHAR(255),
    FOREIGN KEY (codigo_empleado) REFERENCES Informatico(codigo_empleado)
);

CREATE TABLE Producto (
    codigo_producto INT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    estado BOOLEAN,
    responsable INT,
    FOREIGN KEY (responsable) REFERENCES Analista(codigo_empleado)
);

CREATE TABLE Software (
    codigo_producto INT PRIMARY KEY,
    tipo VARCHAR(50),
    FOREIGN KEY (codigo_producto) REFERENCES Producto(codigo_producto)
);

CREATE TABLE Prototipo (
    codigo_producto INT PRIMARY KEY,
    version VARCHAR(10),
    ubicacion VARCHAR(100),
    FOREIGN KEY (codigo_producto) REFERENCES Producto(codigo_producto)
);

CREATE TABLE Recurso (
    codigo_recurso INT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    tipo VARCHAR(10),
    periodo VARCHAR(50),
    codigo_fase INT,
    FOREIGN KEY (codigo_fase) REFERENCES Fase(codigo_fase)
);

CREATE TABLE Gasto (
    codigo_gasto INT PRIMARY KEY,
    descripcion TEXT,
    fecha DATE,
    importe DECIMAL(10,2),
    tipo VARCHAR(50),
    codigo_empleado INT,
    codigo_proyecto INT,
    FOREIGN KEY (codigo_empleado) REFERENCES Empleado(codigo_empleado),
    FOREIGN KEY (codigo_proyecto) REFERENCES Proyecto(codigo_proyecto)
);

CREATE TABLE Empleado_Producto (
    codigo_empleado INT,
    codigo_producto INT,
    horas_dedicadas INT,
    PRIMARY KEY (codigo_empleado, codigo_producto),
    FOREIGN KEY (codigo_empleado) REFERENCES Empleado(codigo_empleado),
    FOREIGN KEY (codigo_producto) REFERENCES Producto(codigo_producto)
);

CREATE TABLE Fase_Recurso (
    codigo_fase INT,
    codigo_recurso INT,
    PRIMARY KEY (codigo_fase, codigo_recurso),
    FOREIGN KEY (codigo_fase) REFERENCES Fase(codigo_fase),
    FOREIGN KEY (codigo_recurso) REFERENCES Recurso(codigo_recurso)
);
