-- Consultas

-- Contenido de tabla Clientes
SELECT  *
FROM    Clientes;

-- Nombre y domicilio de los Clientes
SELECT  nombrecli, domicilio
FROM    Clientes;

-- Sucursales en las que hay empleados trabajando (eliminando los duplicados)
SELECT DISTINCT(nombresuc)
FROM Empleados;

-- Nombres y DNI de empleados que trabajen en la sucursal de Downtown
SELECT  nombreemp, dniemp
FROM    Empleados
WHERE   nombresuc = 'Downtown';

-- Mostras las cuentas y su saldo de aquellas cuentas que están en la sucursal de Perrydge
-- y tienen un saldo superior a 35000
SELECT  numerocta, saldo
FROM    Cuentas
WHERE   nombresuc = 'Perrydge'
        AND saldo > 35000;

-- Mostrar las filas de los empleados que trabajen en Downtown o Perrydge
SELECT *
FROM Empleados
WHERE nombresuc = 'Downtown' 
OR nombresuc = 'Perrydge';

-- Mostrar las filas de los empleados que trabajen en Downtown o Perrydge (con IN)
SELECT  *
FROM    Empleados
WHERE   nombresuc IN ('Downtown', 'Perrydge');

-- Mostrar las filas de las cuentas con saldo entre 20000 y 40000
SELECT  *
FROM    Cuentas
WHERE   saldo >= 20000
        AND saldo <= 40000;

-- Mostrar las filas de las cuentas con saldo entre 20000 y 40000 (con BETWEEN)
SELECT  *
FROM    Cuentas
WHERE   saldo BETWEEN 20000 AND 40000;

-- Mostrar las filas de los clientes que su domicilio comience por Fragata
SELECT  *
FROM    Clientes
WHERE   domicilio LIKE 'Fragata%';

-- Mostrar las filas de los clientes que su domicilio contenga Azul
SELECT	*
FROM	Clientes
WHERE	domicilio LIKE '%Azul%'

-- Mostrar las filas cuentas ordenadas alfabéticamente por sucursal y saldo en orden descendente
SELECT  *
FROM    Cuentas
ORDER BY nombresuc, saldo DESC;

-- Mostrar el TOP 3 de sucursales por activo
SELECT  nombresuc, activo
FROM    Sucursales
ORDER BY activo DESC
LIMIT 3;

-- Mostrar las segundas 3 mejores sucursales por activo
SELECT  nombresuc, activo
FROM    Sucursales
ORDER BY activo DESC
LIMIT 3 OFFSET 3;

-- Mostrar numero de cuenta y saldo de las cuentas de Johnson
SELECT  Cuentas.numerocta, saldo
FROM    Clientes,
        CtaCli,
        Cuentas
WHERE   Clientes.dniCli = CtaCli.dniCli
        AND CtaCli.numeroCta = Cuentas.numeroCta
        AND nombrecli = 'Johnson';

-- En qué ciudad está la sucursal en la que trabaja Smith
SELECT  ciudadsuc
FROM    Sucursales,
        Empleados
WHERE   Sucursales.nombreSuc = Empleados.nombreSuc
        AND Empleados.nombreEmp = 'Smith';

-- Mostrar numero de cuenta y saldo de las cuentas de Johnson (con alias)
SELECT  Cu.numerocta, Cu.saldo
FROM    Clientes Cl,
        CtaCli CC,
        Cuentas Cu
WHERE   Cl.dniCli = CC.dniCli
        AND CC.numeroCta = Cu.numeroCta
        AND Cl.nombrecli = 'Johnson';

SELECT  Cu.numerocta, Cu.saldo
FROM    Clientes Cl
        INNER JOIN CtaCli CC ON Cl.dniCli = CC.dniCli
        INNER JOIN Cuentas Cu ON CC.numeroCta = Cu.numeroCta
WHERE   Cl.nombrecli = 'Johnson';

-- En qué ciudad está la sucursal en la que trabaja Smith (con CROSS JOIN)
SELECT  ciudadsuc
FROM    Sucursales
        CROSS JOIN Empleados
WHERE   Sucursales.nombreSuc = Empleados.nombreSuc
        AND Empleados.nombreEmp = 'Smith';

-- Cuentas que hay en la ciudad de Horseneck
SELECT  *
FROM    Sucursales
        CROSS JOIN Cuentas  
WHERE   Sucursales.nombreSuc = Cuentas.nombreSuc
        AND ciudadsuc = 'Horseneck';

-- Mostrar numero de cuenta y saldo de las cuentas de Johnson (con INNER JOIN)
SELECT  Cuentas.numerocta, saldo
FROM    Clientes
        INNER JOIN CtaCli ON Clientes.dniCli = CtaCli.dniCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
WHERE   nombrecli = 'Johnson';

-- En qué ciudad está la sucursal en la que trabaja Smith (con INNER JOIN)
SELECT  ciudadsuc
FROM    Sucursales
        INNER JOIN Empleados ON Sucursales.nombreSuc = Empleados.nombreSuc
WHERE   Empleados.nombreEmp = 'Smith';

-- Mostrar todas las cuentas añadiendo su saldo en dólares y renombrando la columna como saldoEnDolares
SELECT  Cuentas.*, saldo * 1.08 AS saldoEnDolares
FROM    Cuentas;

-- Mostras las cuentas y su saldo de aquellas cuentas que están en la sucursal de Perrydge
-- y tienen un saldo superior a 35000 USD
SELECT  numerocta, saldo
FROM    Cuentas
WHERE   nombresuc = 'Perrydge'
        AND saldo > 35000/1.08;

-- Mostras las cuentas y su saldo de aquellas cuentas que están en la sucursal de Perrydge
-- y tienen un saldo superior a 35000 USD. El saldo se debe mostar en dólares
SELECT  numerocta, saldo, saldo * 1.08 AS saldoEnDolares
FROM    Cuentas
WHERE   nombresuc = 'Perrydge'
        AND saldo > 35000/1.08;

-- Nombres de todos las personas del banco. 
-- Se eliminan duplicados de forma predeterminada. Para conservar duplicados hacer UNION ALL
SELECT  nombreEmp
FROM    Empleados
UNION 
SELECT  nombreCli
FROM    Clientes;

-- Se eliminan duplicados de forma predeterminada. 
-- Para conservar duplicados hacer UNION ALL (También se ha aprovechado para renombrar la columna)
SELECT	nombreemp AS nombrePersona
FROM	Empleados
UNION ALL
SELECT	nombrecli
FROM	Clientes

-- Cuentas que hay en la ciudad de Horseneck, mostrando todas las sucursales de Horseneck
-- aunque no tengan cuentas
SELECT  *
FROM    Sucursales
        LEFT JOIN Cuentas ON Sucursales.nombreSuc = Cuentas.nombreSuc
WHERE   ciudadsuc = 'Horseneck';

-- Nombres de empleados que trabajan en la misma sucursal que Smith
SELECT  nombreemp
FROM    Empleados
WHERE   nombresuc IN (
    SELECT nombresuc
    FROM Empleados
    WHERE nombreemp = 'Smith'
);

-- Sucursales en las que trabaja Smith
SELECT  nombresuc
FROM    Empleados
WHERE   nombreemp = 'Smith';

-- Nombres de empleados que trabajan en la misma sucursal que Smith (Usando RENOMBRAR)
SELECT  DISTINCT E1.nombreemp
FROM    Empleados E1
        INNER JOIN Empleados E2 ON E1.nombresuc = E2.nombresuc
WHERE   E2.nombreemp = 'Smith';

-- Nombres de empleados que trabajan en la misma sucursal que Smith (Usando subconsulta en FROM)
SELECT  nombreemp
FROM    (SELECT nombresuc
          FROM   Empleados
          WHERE  nombreemp = 'Smith') AS SucursalDeSmith
        INNER JOIN Empleados ON Empleados.nombresuc = SucursalDeSmith.nombresuc;

-- Misma consulta que la anterior pero eliminando a Smith
SELECT  nombreemp
FROM    (SELECT nombresuc
          FROM   Empleados
          WHERE  nombreemp = 'Smith') AS SucursalDeSmith
        INNER JOIN Empleados ON Empleados.nombresuc = SucursalDeSmith.nombresuc
WHERE   nombreemp <> 'Smith';

-- Mostrar cada cliente con su cuenta de mayor saldo
SELECT nombrecli, ( SELECT      Cu.numerocta
                    FROM	Cuentas Cu
                                INNER JOIN CtaCli CC ON Cu.numeroCta = CC.numeroCta
                    WHERE       Clientes.dniCli = CC.dniCli
                    ORDER BY    saldo DESC
                    LIMIT 1)
FROM Clientes;

-- Uso de CONCAT para mostrar el número de cuenta, saldo y sucursal de la cuenta de mayor saldo de cada cliente
SELECT nombrecli,   (SELECT	CONCAT(Cu.numerocta, ' - ', Cu.saldo, ' - ', Cu.nombreSuc)
                    FROM	Cuentas Cu
                                INNER JOIN CtaCli CC ON Cu.numeroCta = CC.numeroCta
                    WHERE       Clientes.dniCli = CC.dniCli
                    ORDER BY    saldo DESC
                    LIMIT 1) AS datosMejorCuenta
FROM Clientes;

-- Uso de JSON_OBJECT para mostrar el número de cuenta, saldo y sucursal de la cuenta de mayor saldo de cada cliente
SELECT nombrecli,   (SELECT	JSON_OBJECT('numerocta', Cu.numerocta, 'saldo', Cu.saldo, 'nombreSuc', Cu.nombreSuc)
                    FROM	Cuentas Cu
                                INNER JOIN CtaCli CC ON Cu.numeroCta = CC.numeroCta
                    WHERE       Clientes.dniCli = CC.dniCli
                    ORDER BY    saldo DESC
                    LIMIT 1) AS datosMejorCuenta
FROM Clientes;

-- Misma consulta que la anterior pero usando JOIN 
-- para enriquecer la subconsulta con las columnas necesarias
SELECT	Cuentas.numeroCta, Cuentas.saldo, Cuentas.nombreSuc, Aux.nombrecli
FROM  (SELECT nombrecli, ( SELECT      Cu.numerocta
                            FROM	Cuentas Cu
                                        INNER JOIN CtaCli CC ON Cu.numeroCta = CC.numeroCta
                            WHERE       Clientes.dniCli = CC.dniCli
                            ORDER BY    saldo DESC
                            LIMIT 1) as mejorCuenta
        FROM Clientes) Aux,
        Cuentas
WHERE	Aux.mejorCuenta = Cuentas.numeroCta;

-- Empleados que trabajan en la misma sucursal que Smith usando CTE
WITH SucursalDeSmith AS (
    SELECT nombresuc
    FROM Empleados
    WHERE nombreemp = 'Smith'
)
SELECT nombreemp
FROM Empleados
WHERE nombresuc IN (SELECT nombresuc FROM SucursalDeSmith)
      AND nombreemp <> 'Smith';

-- Número de cuentas por sucursal y la ciudad de cada sucursa usando CTE
WITH CuentasAgrupadas AS (
    SELECT nombreSuc, COUNT(*) AS numCuentas
    FROM Cuentas
    GROUP BY nombreSuc
)
SELECT CuentasAgrupadas.nombreSuc, CuentasAgrupadas.numCuentas, Sucursales.ciudadsuc
FROM CuentasAgrupadas
JOIN Sucursales ON CuentasAgrupadas.nombreSuc = Sucursales.nombreSuc;

-- Nombres de sucursales que tienen empleados (con consultas correlacionadas)
SELECT  nombresuc
FROM    Sucursales
WHERE   EXISTS (SELECT  *
                FROM    Empleados
                WHERE   Sucursales.nombresuc = Empleados.nombresuc);

-- Nombres de sucursales que tienen empleados (directo)
SELECT  DISTINCT(nombreSuc)
FROM    Empleados;

-- Nombres de sucursales que no tienen empleados (con consultas correlacionadas)
SELECT  nombresuc
FROM    Sucursales
WHERE   NOT EXISTS (SELECT  *
                    FROM    Empleados
                    WHERE   Sucursales.nombresuc = Empleados.nombresuc);

-- Nombres de sucursales que no tienen empleados (LEFT JOIN)
SELECT  Sucursales.nombresuc
FROM    Sucursales
        LEFT JOIN Empleados ON Sucursales.nombresuc = Empleados.nombresuc
WHERE   Empleados.nombresuc IS NULL;

-- Nombres de sucursales que no tienen empleados (Conjuntos)
SELECT  nombresuc
FROM    Sucursales
WHERE   nombresuc NOT IN (SELECT  nombresuc
                          FROM    Empleados);

-- Nombre, número de cuenta y saldo de clientes que tienen cuentas con una saldo superior al de todas las cuentas de Smith
SELECT  nombrecli, Cuentas.numerocta, saldo
FROM    Clientes
        INNER JOIN CtaCli ON Clientes.dniCli = CtaCli.dniCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
WHERE   saldo > ALL (SELECT saldo
                    FROM    Cuentas
                            INNER JOIN CtaCli ON Cuentas.numeroCta = CtaCli.numeroCta
                            INNER JOIN Clientes ON CtaCli.dniCli = Clientes.dniCli
                    WHERE nombreCli = 'Smith');

-- Nombre, número de cuenta y saldo de clientes que tienen cuentas con una saldo superior a alguna de las cuentas de Smith
SELECT  nombrecli, Cuentas.numerocta, saldo
FROM    Clientes
        INNER JOIN CtaCli ON Clientes.dniCli = CtaCli.dniCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
WHERE   saldo > ANY (SELECT saldo
                    FROM    Cuentas
                            INNER JOIN CtaCli ON Cuentas.numeroCta = CtaCli.numeroCta
                            INNER JOIN Clientes ON CtaCli.dniCli = Clientes.dniCli
                    WHERE nombreCli = 'Smith');

-- Número total de empleados
SELECT  COUNT(*) AS numEmpleados
FROM    Empleados;

-- Cantidad de empleados de la sucursal Downtown
SELECT  COUNT(*) AS numEmpleados
FROM    Empleados
WHERE   nombresuc = 'Downtown';

-- En cuántas sucursales hay empleados trabajando
SELECT  COUNT(DISTINCT nombresuc) AS numSucursales
FROM    Empleados;

-- Saldo total de las cuentas del cliente Johnson
SELECT  SUM(saldo) AS saldoTotal
FROM    Cuentas
        INNER JOIN CtaCli ON Cuentas.numeroCta = CtaCli.numeroCta
        INNER JOIN Clientes ON CtaCli.dniCli = Clientes.dniCli
WHERE   nombrecli = 'Johnson';

-- Saldo medio de las cuentas de la sucursal `Downtown`
SELECT  AVG(saldo) AS saldoMedio
FROM    Cuentas 
WHERE   nombreSuc = 'Downtown';

-- Obtener el mayor saldo de las cuentas de la sucursal `Downtown`
SELECT  MAX(saldo) AS saldoMaximo
FROM    Cuentas 
WHERE   nombreSuc = 'Downtown';

-- Saldo máximo de las cuentas del cliente `Johnson`
SELECT  MAX(saldo) AS saldoMaximo
FROM    Cuentas 
        INNER JOIN CtaCli ON Cuentas.numeroCta = CtaCli.numeroCta
        INNER JOIN Clientes ON CtaCli.dniCli = Clientes.dniCli
WHERE   nombrecli = 'Johnson';

-- Clientes que tienen cuentas con un saldo superior al saldo medio de las cuentas de `Johnson`
SELECT  nombrecli, Cuentas.numerocta, saldo
FROM    Clientes
        INNER JOIN CtaCli ON Clientes.dniCli = CtaCli.dniCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
WHERE   saldo > (SELECT AVG(saldo)
                 FROM    Cuentas
                         INNER JOIN CtaCli ON Cuentas.numeroCta = CtaCli.numeroCta
                         INNER JOIN Clientes ON CtaCli.dniCli = Clientes.dniCli
                 WHERE nombrecli = 'Johnson');

-- Saldo total de las cuentas agrupadas por sucursal:
SELECT  nombresuc, SUM(saldo) AS saldoTotal
FROM    Cuentas
GROUP BY nombresuc;

-- Saldo total de las cuentas de las sucursales de la ciudad `Brooklyn`
SELECT  Sucursales.nombresuc, SUM(saldo) AS saldoTotal
FROM    Cuentas
        INNER JOIN Sucursales ON Cuentas.nombresuc = Sucursales.nombresuc
WHERE   ciudadsuc = 'Brooklyn'
GROUP BY Sucursales.nombresuc;

-- Cuántos empleados trabajan en cada ciudad:
SELECT  ciudadsuc, COUNT(*) AS numEmpleados
FROM    Empleados
        INNER JOIN Sucursales ON Empleados.nombresuc = Sucursales.nombresuc
GROUP BY ciudadsuc;

-- Cuántos empleados trabajan en cada ciudad (mostrando todas las ciudades)
SELECT  ciudadsuc, COUNT(Empleados.dniEmp) AS numEmpleados
FROM    Sucursales
        LEFT JOIN Empleados ON Sucursales.nombresuc = Empleados.nombresuc
GROUP BY ciudadsuc;

-- Nombres de cada sucursal junto con el nombre de los empleados que trabajan en ella separados por comas
SELECT  nombresuc, GROUP_CONCAT(nombreemp) AS empleados
FROM    Empleados
GROUP BY nombresuc;

-- Nombre de un cliente junto con el saldo total de sus cuentas
-- EVITAR ESTO
SELECT  nombrecli, SUM(saldo) AS saldoTotal
FROM    Clientes
        INNER JOIN CtaCli ON Clientes.dniCli = CtaCli.dniCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
GROUP BY nombrecli;

-- HACER ESTO
SELECT  dniCli, SUM(saldo) AS saldoTotal, 
        (SELECT nombrecli
         FROM    Clientes
         WHERE   Clientes.dniCli = CtaCli.dniCli) AS nombrecli
FROM    CtaCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
GROUP BY dnicli;

-- O ESTO
SELECT  CtaCli.dniCli, SUM(saldo) AS saldoTotal, Cl.nombreCli
FROM    CtaCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
        INNER JOIN (SELECT dniCli, nombrecli
                   FROM   Clientes) AS Cl
        ON CtaCli.dniCli = Cl.dniCli
GROUP BY CtaCli.dnicli;

-- Cuántas cuentas con saldo superior a `10000` hay en cada sucursal.
-- Mostrar sólo aquellas sucursales que tienen más de una cuenta con saldo superior a `10000`
SELECT  nombresuc, COUNT(*) AS numCuentas
FROM    Cuentas
WHERE   saldo > 10000
GROUP BY nombresuc
HAVING numCuentas > 1;

-- Clientes que tienen más de una cuenta con saldo superior a `10000`. Mostrar el DNI y el nombre del cliente
-- y el número de cuentas que tiene
SELECT  dniCli, COUNT(*) AS numCuentas
FROM    CtaCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
WHERE   saldo > 10000
GROUP BY dniCli
HAVING numCuentas > 1;

SELECT  dniCli, COUNT(*) AS numCuentas, 
        (SELECT nombrecli
         FROM    Clientes
         WHERE   Clientes.dniCli = CtaCli.dniCli) AS nombrecli
FROM    CtaCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
WHERE   saldo > 10000
GROUP BY dnicli
HAVING numCuentas > 1;

SELECT  CtaCli.dniCli, COUNT(*) AS numCuentas, Cl.nombreCli
FROM    CtaCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
        INNER JOIN (SELECT dniCli, nombrecli
                   FROM   Clientes) AS Cl
        ON CtaCli.dniCli = Cl.dniCli
WHERE   saldo > 10000
GROUP BY CtaCli.dnicli
HAVING numCuentas > 1;

-- Mostrar los 3 clientes que tengan al menos una cuenta con saldo superior a `10000` y ordenados por saldo total de mayor a menor
SELECT  dniCli, SUM(saldo) AS saldoTotal, COUNT(*) AS numCuentas
FROM    CtaCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
WHERE   saldo > 10000
GROUP BY dniCli
HAVING numCuentas > 0
ORDER BY saldoTotal DESC
LIMIT 3;

SELECT  CtaCli.dniCli, SUM(saldo) AS saldoTotal, COUNT(*) AS numCuentas, Cl.nombreCli
FROM    CtaCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
        INNER JOIN (SELECT dniCli, nombrecli
                   FROM   Clientes) AS Cl
        ON CtaCli.dniCli = Cl.dniCli
WHERE   saldo > 10000
GROUP BY CtaCli.dnicli
HAVING numCuentas > 0
ORDER BY saldoTotal DESC
LIMIT 3;

-- Clientes que tienen más cuentas que la media de cuentas por cliente
SELECT  dniCli, COUNT(*) AS numCuentas, 
        (SELECT nombrecli
         FROM    Clientes
         WHERE   Clientes.dniCli = CtaCli.dniCli) AS nombrecli
FROM    CtaCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
GROUP BY dniCli
HAVING numCuentas > (SELECT AVG(numCuentas)
                      FROM    (SELECT dniCli, COUNT(*) AS numCuentas
                               FROM    CtaCli
                                       INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
                               GROUP BY dniCli) AS subquery);

-- Crear una vista para mostrar la información de las cuentas y sus propietarios
CREATE VIEW InfoCuentas AS
SELECT  Cu.numerocta, Cu.saldo, Cu.nombresuc,
        Cl.nombrecli, Cl.dnicli
FROM    Cuentas Cu
        INNER JOIN CtaCli CC ON Cu.numeroCta = CC.numeroCta
        INNER JOIN Clientes Cl ON CC.dniCli = Cl.dniCli;

-- Crear una vista que muestre cada sucursal y la ciudad a la que pertenece,
-- junto con el número de empleados, el número de cuentas 
-- y el saldo total de las cuentas de cada sucursal
CREATE VIEW EstadisticasSucursales AS
SELECT  S.nombresuc, 
        (SELECT ciudadsuc
         FROM    Sucursales
         WHERE   nombresuc = S.nombresuc) AS ciudadsuc,
        COUNT(DISTINCT E.dniemp) as num_empleados,
        COUNT(DISTINCT C.numerocta) as num_cuentas,
        SUM(C.saldo) as saldo_total
FROM    Sucursales S
        LEFT JOIN Empleados E ON S.nombresuc = E.nombresuc
        LEFT JOIN Cuentas C ON S.nombresuc = C.nombresuc
GROUP BY S.nombresuc;

-- Crear una vista que muestre los clientes VIP, es decir, 
-- aquellos cuyo saldo total supera la media del saldo total por sucursal
CREATE VIEW ClientesVIP AS
SELECT  Cl.dnicli,
        (SELECT nombrecli
         FROM    Clientes
         WHERE   Clientes.dniCli = Cl.dniCli) AS nombrecli,
        COUNT(Cu.numerocta) as num_cuentas,
        SUM(Cu.saldo) as saldo_total
FROM    Clientes Cl
        INNER JOIN CtaCli CC ON Cl.dniCli = CC.dniCli
        INNER JOIN Cuentas Cu ON CC.numeroCta = Cu.numeroCta
GROUP BY Cl.dnicli
HAVING SUM(Cu.saldo) > (SELECT AVG(saldo_total)
                       FROM (SELECT SUM(saldo) as saldo_total
                             FROM Cuentas
                             GROUP BY nombresuc) T);

-- Consultas a las vistas
SELECT *
FROM InfoCuentas
WHERE saldo > 50000;

SELECT *
FROM EstadisticasSucursales
WHERE ciudadsuc = 'Brooklyn';

SELECT *
FROM ClientesVIP
ORDER BY saldo_total DESC;

-- DML

-- Insertar un nuevo cliente con nombre y domicilio
-- (el resto de campos se completan automáticamente)
INSERT INTO Clientes 
VALUES ('Ana García', 10, 'Calle Mayor 123');

-- Insertar una nueva sucursal
INSERT INTO Sucursales 
VALUES ('Central', 'Madrid', 1000000);

-- Insertar varios empleados a la vez, pero sin especificar el telefono
INSERT INTO Empleados (dniEmp, nombreEmp, nombreSuc)
VALUES 
    ('16', 'Juan Pérez', 'Central'),
    ('17', 'María López', 'Central'),
    ('18', 'Pedro García', 'Central');

-- Insertar varias cuentas
INSERT INTO Cuentas 
VALUES 
    (10, 50000, 'Central'),
    (11, 75000, 'Central'),
    (12, 90000, 'Central');

-- Crear cuentas para todos los empleados de la sucursal Central
INSERT INTO Cuentas 
SELECT 
    dniEmp + 100,    -- Número de cuenta creado a partir del dni
    50000,          -- Saldo inicial
    nombreSuc       -- Misma sucursal donde trabaja
FROM Empleados 
WHERE nombreSuc = 'Central';

-- Vincular las cuentas creadas con los empleados
INSERT INTO CtaCli (dniCli, numeroCta)
SELECT 
    dniEmp,
    dniEmp + 100  -- Usar el mismo número de cuenta creado
FROM Empleados 
WHERE nombreSuc = 'Central';

-- Incrementar el saldo de todas las cuentas de la sucursal Central en un 10%
UPDATE Cuentas
SET saldo = saldo * 1.10
WHERE nombreSuc = 'Central';

-- Cambiar el domicilio de un cliente
UPDATE Clientes
SET domicilio = 'Nueva Calle 456'
WHERE dniCli = 10;

-- Aumentar el saldo de las cuentas de los clientes que tienen un saldo mayor a 1000
UPDATE Cuentas
SET saldo = saldo * 1.05
WHERE numeroCta IN (
    SELECT numeroCta
    FROM CtaCli
    WHERE dniCli IN (
        SELECT dniCli
        FROM Clientes
        WHERE saldo > 1000
    )
);
-- Actualizar el activo de las sucursales según el saldo total de sus cuentas
UPDATE Sucursales
SET activo = (
    SELECT COALESCE(SUM(saldo), 0)
    FROM Cuentas
    WHERE Cuentas.nombreSuc = Sucursales.nombreSuc
);

-- Eliminar un cliente específico
DELETE FROM Clientes
WHERE dniCli = 10;

-- Eliminar todas las cuentas con saldo cero
DELETE FROM Cuentas
WHERE saldo = 0;

-- Eliminar las cuentas de los clientes que no han realizado movimientos en el último año
DELETE FROM Cuentas
WHERE numeroCta IN (
    SELECT numeroCta
    FROM CtaCli
    WHERE dniCli IN (
        SELECT dniCli
        FROM Clientes
        WHERE ultimoMovimiento < date('now', '-1 year')
    )
);

-- Eliminar las relaciones cliente-cuenta para cuentas cerradas
DELETE FROM CtaCli
WHERE numeroCta IN (
    SELECT numeroCta
    FROM Cuentas
    WHERE estado = 'CERRADA'
);

-- Eliminar todas las cuentas de una sucursal que va a cerrar
DELETE FROM Cuentas
WHERE nombreSuc IN (
    SELECT nombreSuc
    FROM Sucursales
    WHERE estado = 'PENDIENTE_CIERRE'
);

-- Procedures

-- Procedimiento para obtener el saldo de una cuenta
-- Parámetros de entrada: número de cuenta
-- Parámetros de salida: saldo
DELIMITER //

DROP PROCEDURE IF EXISTS ObtenerSaldo //
CREATE PROCEDURE ObtenerSaldo(
    IN p_NumeroCta VARCHAR(5),
    OUT p_Saldo FLOAT
)
BEGIN
    SELECT saldo INTO p_Saldo
    FROM Cuentas
    WHERE numeroCta = p_NumeroCta;
END //

DELIMITER ;

-- Llamada al procedimiento para obtener el saldo de la cuenta '1'
CALL ObtenerSaldo('1', @saldo);
SELECT @saldo;

-- Procedimiento para crear una nueva cuenta bancaria
-- Parámetros de entrada: número de cuenta, saldo inicial, nombre de la sucursal
-- Parámetros de salida: ninguno
-- Verifica si la sucursal existe antes de crear la cuenta
DELIMITER //

DROP PROCEDURE IF EXISTS CrearCuenta //
CREATE PROCEDURE CrearCuenta(
    IN p_NumeroCta VARCHAR(5),
    IN p_Saldo FLOAT,
    IN p_NombreSuc VARCHAR(50)
)
BEGIN
    DECLARE sucursal_existe INT;
    SELECT COUNT(*) INTO sucursal_existe FROM Sucursales WHERE nombreSuc = p_NombreSuc;

    IF sucursal_existe > 0 THEN
        INSERT INTO Cuentas (numeroCta, saldo, nombreSuc)
        VALUES (p_NumeroCta, p_Saldo, p_NombreSuc);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La sucursal especificada no existe';
    END IF;
END //

DELIMITER ;

-- Llamada al procedimiento para crear una nueva cuenta
CALL CrearCuenta(100, 1000, 'Central');
SELECT * FROM Cuentas WHERE numeroCta = 100;

-- Procedimiento para actualizar el saldo de una cuenta
-- Parámetros de entrada: número de cuenta, importe a agregar o restar
-- Parámetros de salida: ninguno
-- Verifica si el saldo es suficiente antes de realizar la actualización
-- Si el saldo es insuficiente, lanza un error

DELIMITER //

DROP PROCEDURE IF EXISTS ActualizarSaldo //
CREATE PROCEDURE ActualizarSaldo(
    IN p_NumeroCta VARCHAR(5),
    IN p_Importe FLOAT
)
BEGIN
    DECLARE saldo_actual FLOAT;
    
    -- Obtener el saldo actual
    SELECT saldo INTO saldo_actual
    FROM Cuentas
    WHERE numeroCta = p_NumeroCta;
    
    -- Verificar si el saldo es suficiente
    IF saldo_actual + p_Importe < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Saldo insuficiente';
    ELSE
        -- Actualizar el saldo
        UPDATE Cuentas
        SET saldo = saldo + p_Importe
        WHERE numeroCta = p_NumeroCta;
    END IF;
END //

DELIMITER ;

-- Llamada al procedimiento para actualizar el saldo de la cuenta '100'
CALL ActualizarSaldo(100, -200);
SELECT * FROM Cuentas WHERE numeroCta = 100;

-- Llamada al procedimiento para actualizar el saldo de la cuenta '100' con un importe negativo
-- que excede el saldo actual
CALL ActualizarSaldo(100, -2000);
SELECT * FROM Cuentas WHERE numeroCta = 100;

-- Procedimiento para realizar una transferencia entre cuentas
-- Parámetros de entrada: cuenta de origen, cuenta de destino, importe a transferir
-- Parámetros de salida: ninguno
-- Verifica si el saldo es suficiente antes de realizar la transferencia
-- Si el saldo es insuficiente en la cuenta origen, lanza un error
DELIMITER //

DROP PROCEDURE IF EXISTS RealizarTransferencia //
CREATE PROCEDURE RealizarTransferencia(
    IN p_CuentaOrigen VARCHAR(5),
    IN p_CuentaDestino VARCHAR(5),
    IN p_Importe FLOAT
)
BEGIN
    DECLARE saldo_origen FLOAT;
    DECLARE saldo_destino FLOAT;
    
    -- Obtener los saldos de ambas cuentas
    SELECT saldo INTO saldo_origen
    FROM Cuentas
    WHERE numeroCta = p_CuentaOrigen;
    
    SELECT saldo INTO saldo_destino
    FROM Cuentas
    WHERE numeroCta = p_CuentaDestino;
    
    -- Verificar si el saldo es suficiente
    IF saldo_origen < p_Importe THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Saldo insuficiente en la cuenta de origen';
    ELSE
        -- Realizar la transferencia
        UPDATE Cuentas
        SET saldo = saldo - p_Importe
        WHERE numeroCta = p_CuentaOrigen;
        
        UPDATE Cuentas
        SET saldo = saldo + p_Importe
        WHERE numeroCta = p_CuentaDestino;
    END IF;
END //

DELIMITER ;

-- Ver saldo de las cuentas antes de la transferencia
SELECT * FROM Cuentas WHERE numeroCta IN ('100', '116');

-- Llamada al procedimiento para realizar una transferencia de la cuenta '100' a la cuenta '116'
-- con un importe de 200
CALL RealizarTransferencia(100, 116, 200);
SELECT * FROM Cuentas WHERE numeroCta IN ('100', '116');

-- Llamada al procedimiento para realizar una transferencia de la cuenta '100' a la cuenta '116'
-- con un importe que excede el saldo actual
-- Esto debería lanzar un error de saldo insuficiente
CALL RealizarTransferencia(100, 116, 2000);
SELECT * FROM Cuentas WHERE numeroCta IN ('100', '116');

-- Triggers

-- Trigger para actualizar el saldo de la cuenta después de insertar un movimiento
DELIMITER //

DROP TRIGGER IF EXISTS ActualizarSaldo //
CREATE TRIGGER ActualizarSaldo
AFTER INSERT
ON Transacciones
FOR EACH ROW
BEGIN
    UPDATE Cuentas
    SET saldo = saldo + NEW.importe
    WHERE numeroCta = NEW.numeroCta;
END //

DELIMITER ;

-- Consultar el saldo de la cuenta antes de insertar un movimiento
SELECT saldo
FROM Cuentas
WHERE numeroCta = 100;

-- Insertar un nuevo movimiento en la tabla Transacciones
INSERT INTO Transacciones (numeroCta, numeroTrans, fecha, importe)
VALUES (100, 1, NOW(), 100.00);

-- Consultar el saldo de la cuenta después de insertar el movimiento
-- El saldo debería haber aumentado en 100.00
SELECT saldo
FROM Cuentas
WHERE numeroCta = 100;

-- Crear las tablas Descubiertos y Notificaciones
DROP TABLE IF EXISTS Descubiertos;
DROP TABLE IF EXISTS Notificaciones;

CREATE TABLE Descubiertos (
    numeroCta VARCHAR(20),
    fecha DATE,
    importe DECIMAL(10, 2),
    estado ENUM('PENDIENTE', 'RESUELTO')
);
CREATE TABLE Notificaciones (
    numeroCta tinyint(4),
    fecha DATE,
    mensaje VARCHAR(255),
    estado ENUM('ENVIADA', 'NO_ENVIADA')
);

-- Trigger para gestionar los descubiertos de las cuentas
-- y enviar notificaciones a los clientes
-- cuando el saldo de la cuenta es negativo
DELIMITER //

CREATE TRIGGER GestionarDescubiertos
AFTER UPDATE
ON Cuentas
FOR EACH ROW
BEGIN
    IF NEW.saldo < 0 THEN
        INSERT INTO Descubiertos (numeroCta, fecha, importe, estado)
        VALUES (NEW.numeroCta, NOW(), -NEW.saldo, 'PENDIENTE');
        
        INSERT INTO Notificaciones (numeroCta, fecha, mensaje, estado)
        VALUES (NEW.numeroCta, NOW(), 'Se ha detectado un descubierto en su cuenta de ' || -NEW.saldo, 'ENVIADA');
    END IF;
END //

DELIMITER ;

-- Trigger para actualizar el saldo de la cuenta después de insertar un movimiento
-- y gestionar los descubiertos
-- y enviar notificaciones a los clientes
-- cuando el saldo de la cuenta es negativo
-- y actualizar el estado del descubierto a "RESUELTO" cuando el saldo es positivo
-- y el saldo anterior era negativo

DELIMITER //

DROP TRIGGER IF EXISTS ActualizarSaldo //
CREATE TRIGGER ActualizarSaldo
AFTER INSERT
ON Transacciones
FOR EACH ROW
BEGIN
    DECLARE saldo_anterior DECIMAL(10, 2);
    DECLARE nuevo_saldo DECIMAL(10, 2);

    -- Obtener el saldo anterior de la cuenta
    SELECT saldo INTO saldo_anterior
    FROM Cuentas
    WHERE numeroCta = NEW.numeroCta;

    -- Actualizar el saldo de la cuenta
    UPDATE Cuentas
    SET saldo = saldo + NEW.importe
    WHERE numeroCta = NEW.numeroCta;

    -- Obtener el nuevo saldo de la cuenta
    SELECT saldo INTO nuevo_saldo
    FROM Cuentas
    WHERE numeroCta = NEW.numeroCta;

    -- Verificar si el saldo anterior era negativo y el nuevo saldo es positivo
    IF saldo_anterior < 0 AND nuevo_saldo >= 0 THEN
        -- Actualizar el estado del descubierto a "RESUELTO"
        UPDATE Descubiertos
        SET estado = 'RESUELTO'
        WHERE numeroCta = NEW.numeroCta
        AND estado = 'PENDIENTE';
    END IF;
END //

DELIMITER ;

-- Consultar el saldo de la cuenta antes de insertar un movimiento
SELECT *
FROM Cuentas
WHERE numeroCta = 100;

-- Insertar un nuevo movimiento en la tabla Transacciones
-- que reduce el saldo de la cuenta a negativo
INSERT INTO Transacciones (numeroCta, numeroTrans, fecha, importe)
VALUES (100, 2, NOW(), -800);

-- Consultar el saldo de la cuenta después de insertar el movimiento
-- El saldo debe ser negativo
SELECT *
FROM Cuentas
WHERE numeroCta = 100;

-- Consultar el estado del descubierto después de insertar el movimiento
-- Debe haber un nuevo registro en la tabla Descubiertos
-- y el estado debe ser "PENDIENTE"
SELECT *
FROM Descubiertos
WHERE numeroCta = 100;

-- Consultar el estado de las notificaciones
-- Debe haber un nuevo registro en la tabla Notificaciones
-- y el estado debe ser "ENVIADA"
SELECT *
FROM Notificaciones
WHERE numeroCta = 100;

-- Insertar un nuevo movimiento en la tabla Transacciones
-- que convierte el saldo de la cuenta a positivo
-- y actualiza el estado del descubierto a "RESUELTO"
INSERT INTO Transacciones (numeroCta, numeroTrans, fecha, importe)
VALUES (100, 3, NOW(), 500);

-- Consultar el saldo de la cuenta después de insertar el movimiento
-- El saldo debe ser positivo
SELECT *
FROM Cuentas
WHERE numeroCta = 100;

-- Consultar el estado del descubierto después de insertar el movimiento
-- El estado debe ser "RESUELTO"
SELECT *
FROM Descubiertos
WHERE numeroCta = 100;