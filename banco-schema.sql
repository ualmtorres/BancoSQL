-- Tabla: Sucursales
CREATE TABLE Sucursales (
    nombreSuc varchar(50) PRIMARY KEY,
    ciudadSuc varchar(50),
    activo FLOAT
);

-- Tabla: Empleados
CREATE TABLE Empleados (
    nombreEmp varchar(50),
    dniEmp varchar(10) PRIMARY KEY,
    telefono varchar(10),
    nombreSuc varchar(50),
    FOREIGN KEY (nombreSuc) REFERENCES Sucursales(nombreSuc)
);

-- Tabla: Cuentas
CREATE TABLE Cuentas (
    numeroCta varchar(5) PRIMARY KEY,
    saldo FLOAT,
    nombreSuc varchar(50),
    FOREIGN KEY (nombreSuc) REFERENCES Sucursales(nombreSuc)
);

-- Tabla: Clientes
CREATE TABLE Clientes (
    nombreCli varchar(50),
    dniCli varchar(10) PRIMARY KEY,
    domicilio varchar(50)
);

-- Tabla: Transacciones
CREATE TABLE Transacciones (
    numeroCta varchar(5),
    numeroTrans varchar(5),
    fecha DATE,
    importe FLOAT,
    PRIMARY KEY (numeroCta, numeroTrans),
    FOREIGN KEY (numeroCta) REFERENCES Cuentas(numeroCta)
);

-- Tabla: CtaCli
CREATE TABLE CtaCli (
    dniCli varchar(10),
    numeroCta varchar(5),
    PRIMARY KEY (dniCli, numeroCta),
    FOREIGN KEY (dniCli) REFERENCES Clientes(dniCli),
    FOREIGN KEY (numeroCta) REFERENCES Cuentas(numeroCta)
);