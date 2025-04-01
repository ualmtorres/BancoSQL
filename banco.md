# Estructura de la Base de Datos: Banco

## Tablas y Columnas

### 1. Sucursales
- **Descripción:** Contiene información sobre las sucursales del banco.
- **Columnas:**
  - `nombreSuc` (varchar(50)): Nombre de la sucursal. **Clave primaria.**
  - `ciudadSuc` (varchar(50)): Ciudad donde se encuentra la sucursal.
  - `activo` (FLOAT): Activo total de la sucursal.

---

### 2. Empleados
- **Descripción:** Contiene información sobre los empleados del banco.
- **Columnas:**
  - `nombreEmp` (varchar(50)): Nombre del empleado.
  - `dniEmp` (varchar(10)): DNI del empleado. **Clave primaria.**
  - `telefono` (varchar(10)): Teléfono del empleado.
  - `nombreSuc` (varchar(50)): Nombre de la sucursal donde trabaja el empleado. **Clave foránea** que referencia `Sucursales(nombreSuc)`.

---

### 3. Cuentas
- **Descripción:** Contiene información sobre las cuentas bancarias.
- **Columnas:**
  - `numeroCta` (varchar(5)): Número de la cuenta. **Clave primaria.**
  - `saldo` (FLOAT): Saldo de la cuenta.
  - `nombreSuc` (varchar(50)): Nombre de la sucursal asociada a la cuenta. **Clave foránea** que referencia `Sucursales(nombreSuc)`.

---

### 4. Clientes
- **Descripción:** Contiene información sobre los clientes del banco.
- **Columnas:**
  - `nombreCli` (varchar(50)): Nombre del cliente.
  - `dniCli` (varchar(10)): DNI del cliente. **Clave primaria.**
  - `domicilio` (varchar(50)): Domicilio del cliente.

---

### 5. Transacciones
- **Descripción:** Contiene información sobre las transacciones realizadas en las cuentas.
- **Columnas:**
  - `numeroCta` (varchar(5)): Número de la cuenta asociada a la transacción. **Clave foránea** que referencia `Cuentas(numeroCta)`.
  - `numeroTrans` (varchar(5)): Número de la transacción. **Clave primaria compuesta.**
  - `fecha` (DATE): Fecha de la transacción.
  - `importe` (FLOAT): Importe de la transacción.

---

### 6. CtaCli
- **Descripción:** Relaciona clientes con cuentas bancarias.
- **Columnas:**
  - `dniCli` (varchar(10)): DNI del cliente. **Clave primaria compuesta** y **clave foránea** que referencia `Clientes(dniCli)`.
  - `numeroCta` (varchar(5)): Número de la cuenta. **Clave primaria compuesta** y **clave foránea** que referencia `Cuentas(numeroCta)`.

---

## Relaciones entre Tablas
- **Sucursales**:
  - Relacionada con `Empleados` mediante `nombreSuc`.
  - Relacionada con `Cuentas` mediante `nombreSuc`.
- **Empleados**:
  - Relacionada con `Sucursales` mediante `nombreSuc`.
- **Cuentas**:
  - Relacionada con `Sucursales` mediante `nombreSuc`.
  - Relacionada con `Transacciones` mediante `numeroCta`.
  - Relacionada con `CtaCli` mediante `numeroCta`.
- **Clientes**:
  - Relacionada con `CtaCli` mediante `dniCli`.
- **Transacciones**:
  - Relacionada con `Cuentas` mediante `numeroCta`.
- **CtaCli**:
  - Relaciona `Clientes` y `Cuentas`.

---

## Notas
- Las claves primarias están indicadas en cada tabla.
- Las claves foráneas establecen las relaciones entre las tablas.
- Los tipos de datos están definidos según las necesidades de cada columna.