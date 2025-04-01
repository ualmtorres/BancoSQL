-- Contenido de tabla Clientes
SELECT *
FROM Clientes

-- Nombre y domicilio de los Clientes
SELECT nombrecli, domicilio
FROM Clientes

–- Estructura de una tabla en SQLite
PRAGMA table_info(Clientes)

–- Estructura de una tabla en MySQL
DESCRIBE Clientes

-- Nombres y DNI de empleados que trabajen en la sucursal de Downtown
SELECT nombreemp, dniemp
FROM Empleados
WHERE nombresuc = 'Downtown'

-- Sucursales en las que hay empleados trabajando (eliminando los duplicados)
SELECT DISTINCT(nombresuc)
FROM Empleados

-- Mostrar todas las cuentas añadiendo su saldo en dólares y renombrando la columna como saldoEnDolares
SELECT Cuentas.*, saldo * 1.08 AS saldoEnDolares
FROM Cuentas

-- Mostras las cuentas y su saldo de aquellas cuentas que están en la sucursal de Perrydge
-- y tienen un saldo superior a 35000
SELECT numerocta, saldo
FROM Cuentas
WHERE nombresuc = 'Perrydge'
AND saldo > 35000

-- Mostras las cuentas y su saldo de aquellas cuentas que están en la sucursal de Perrydge
-- y tienen un saldo superior a 35000 USD
SELECT numerocta, saldo
FROM Cuentas
WHERE nombresuc = 'Perrydge'
AND saldo > 35000/1.08

-- Mostras las cuentas y su saldo de aquellas cuentas que están en la sucursal de Perrydge
-- y tienen un saldo superior a 35000 USD. El saldo se debe mostar en dólares
SELECT numerocta, saldo*1.08 AS saldoEnDolares
FROM Cuentas
WHERE nombresuc = 'Perrydge'
AND saldo > 35000/1.08

-- Mostrar las filas de los empleados que trabajen en Downtown o Perrydge
SELECT *
FROM Empleados
WHERE nombresuc = 'Downtown' 
OR nombresuc = 'Perrydge'

-- Mostrar las filas de los empleados que trabajen en Downtown o Perrydge (con IN)
SELECT *
FROM Empleados
WHERE nombresuc IN ('Downtown', 'Perrydge')

-- Mostrar las filas de las cuentas con saldo entre 20000 y 40000
SELECT *
FROM Cuentas
WHERE saldo >= 20000
AND saldo <= 40000

-- Mostrar las filas de las cuentas con saldo entre 20000 y 40000 (con BETWEEN)
SELECT *
FROM Cuentas
WHERE saldo BETWEEN 20000 AND 40000

-- Mostrar las filas de los clientes que su domicilio comience por Fragata
SELECT *
FROM Clientes
WHERE domicilio LIKE 'Fragata%'

-- Mostrar las filas de los clientes que su domicilio contenga Azul
SELECT	*
FROM	Clientes
WHERE	domicilio LIKE '%Azul%'

-- Mostrar las filas cuentas ordenadas alfabéticamente por sucursal y saldo en orden descendente
SELECT *
FROM Cuentas
ORDER BY nombresuc, saldo DESC

-- Mostrar numero de cuenta y saldo de las cuentas de Johnson
SELECT Cuentas.numerocta, saldo
FROM Clientes,
    CtaCli,
    Cuentas
WHERE Clientes.dniCli = CtaCli.dniCli
AND CtaCli.numeroCta = Cuentas.numeroCta
AND nombrecli = 'Johnson'

-- Mostrar numero de cuenta y saldo de las cuentas de Johnson (con INNER JOIN)
SELECT Cuentas.numerocta, saldo
FROM Clientes
INNER JOIN CtaCli ON Clientes.dniCli = CtaCli.dniCli
INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
WHERE nombrecli = 'Johnson'

-- En qué ciudad está la sucursal en la que trabaja Smith
SELECT ciudadsuc
FROM Sucursales,
    Empleados
WHERE Sucursales.nombreSuc = Empleados.nombreSuc
AND Empleados.nombreEmp = 'Smith'

-- En qué ciudad está la sucursal en la que trabaja Smith (con INNER JOIN)
SELECT ciudadsuc
FROM Sucursales
INNER JOIN Empleados ON Sucursales.nombreSuc = Empleados.nombreSuc
WHERE Empleados.nombreEmp = 'Smith'

-- En qué ciudad está la sucursal en la que trabaja Smith (con CROSS JOIN)
SELECT ciudadsuc
FROM Sucursales
CROSS JOIN Empleados  
WHERE Sucursales.nombreSuc = Empleados.nombreSuc
AND Empleados.nombreEmp = 'Smith'

-- Cuentas que hay en la ciudad de Horseneck
SELECT *
FROM Sucursales
CROSS JOIN Cuentas  
WHERE Sucursales.nombreSuc = Cuentas.nombreSuc
AND ciudadsuc = 'Horseneck'

-- Cuentas que hay en la ciudad de Horseneck, mostrando todas las sucursales de Horseneck
-- aunque no tengan cuentas
SELECT *
FROM Sucursales
LEFT JOIN Cuentas ON Sucursales.nombreSuc = Cuentas.nombreSuc
WHERE ciudadsuc = 'Horseneck'

-- Nombres de todos las personas del banco. 
-- Se eliminan duplicados de forma predeterminada. Para conservar duplicados hacer UNION ALL
SELECT nombreEmp
FROM empleados
UNION 
SELECT nombreCli
FROM clientes

-- Se eliminan duplicados de forma predeterminada. 
-- Para conservar duplicados hacer UNION ALL (También se ha aprovechado para renombrar la columna)
SELECT	nombreemp AS nombrePersona
FROM	Empleados
UNION ALL
SELECT	nombrecli
FROM	Clientes

-- Nombres de empleados que trabajan en la misma sucursal que Smith
SELECT nombreemp
FROM Empleados
WHERE nombresuc IN (SELECT nombresuc
                FROM Empleados
                WHERE nombreemp = 'Smith')

-- Mostrar número de cuenta y saldo de las cuentas de Johnson (con INNER JOIN) -- RENOMBRANDO TABLAS
SELECT	Cu.numerocta, saldo
FROM	Cuentas Cu
		inner join CtaCli CC on Cu.numeroCta = CC.numeroCta
        inner join Clientes Cl ON CC.dniCli = Cl.dniCli
WHERE	nombrecli = 'Johnson'

-- Nombres de empleados que trabajan en la misma sucursal que Smith (Usando RENOMBRAR)
SELECT	E2.nombreEmp
FROM	Empleados E1,
		Empleados E2
WHERE	E1.nombreEmp = 'Smith'
		and E1.nombreSuc = E2.nombreSuc

-- Nombres de empleados que trabajan en la misma sucursal que Smith (Con subconsulta FROM)
SELECT	*
FROM	Empleados, 
		(SELECT	nombresuc
         FROM	Empleados
         WHERE	nombreemp = 'Smith'
        ) SucursalDeSmith
WHERE	Empleados.nombreSuc = SucursalDeSmith.nombreSuc

-- Mostrar el TOP 3 de sucursales por activo
SELECT  nombresuc, activo
FROM    Sucursales
ORDER BY activo DESC
LIMIT 3

-- Mostrar las segundas 3 mejores sucursales por activo
SELECT  nombresuc, activo
FROM    Sucursales
ORDER BY activo DESC
LIMIT 3 OFFSET 3

-- Mostrar cada cliente con su cuenta de mayor saldo
SELECT nombrecli, ( SELECT      Cu.numerocta
                    FROM	Cuentas Cu
                                INNER JOIN CtaCli CC ON Cu.numeroCta = CC.numeroCta
                    WHERE       Clientes.dniCli = CC.dniCli
                    ORDER BY    saldo DESC
                    LIMIT 1)
FROM Clientes

-- Uso de CONCAT para mostrar el número de cuenta, saldo y sucursal de la cuenta de mayor saldo de cada cliente
SELECT nombrecli,   (SELECT	CONCAT(Cu.numerocta, ' - ', Cu.saldo, ' - ', Cu.nombreSuc)
                    FROM	Cuentas Cu
                                INNER JOIN CtaCli CC ON Cu.numeroCta = CC.numeroCta
                    WHERE       Clientes.dniCli = CC.dniCli
                    ORDER BY    saldo DESC
                    LIMIT 1) AS datosMejorCuenta
FROM Clientes

-- Uso de JSON_OBJECT para mostrar el número de cuenta, saldo y sucursal de la cuenta de mayor saldo de cada cliente
SELECT nombrecli,   (SELECT	JSON_OBJECT('numerocta', Cu.numerocta, 'saldo', Cu.saldo, 'nombreSuc', Cu.nombreSuc)
                    FROM	Cuentas Cu
                                INNER JOIN CtaCli CC ON Cu.numeroCta = CC.numeroCta
                    WHERE       Clientes.dniCli = CC.dniCli
                    ORDER BY    saldo DESC
                    LIMIT 1) AS datosMejorCuenta
FROM Clientes

-- Nombres de sucursales que tienen empleados (directo y con consultas correlacionadas)
SELECT  DISTINCT(nombreSuc)
FROM    Empleados;

SELECT  nombresuc
FROM    Sucursales
WHERE   EXISTS (SELECT  *
                FROM    Empleados
                WHERE   Sucursales.nombresuc = Empleados.nombresuc);

-- Nombres de sucursales que no tienen empleados (Conjuntos, LEFT JOIN y correlacionada)
SELECT  nombresuc
FROM    Sucursales
WHERE   nombresuc NOT IN (SELECT  nombresuc
                          FROM    Empleados);

SELECT  Sucursales.nombresuc
FROM    Sucursales
        LEFT JOIN Empleados ON Sucursales.nombresuc = Empleados.nombresuc
WHERE   Empleados.nombresuc IS NULL;

SELECT  nombresuc
FROM    Sucursales
WHERE   NOT EXISTS (SELECT  *
                    FROM    Empleados
                    WHERE   Sucursales.nombresuc = Empleados.nombresuc);

-- Nombre, número de cuenta y saldo de clientes que tienen cuentas con una saldo superior al de todas las cuentas de Smith
SELECT  nombrecli, Cuentas.numerocta, saldo
FROM    Clientes
        INNER JOIN CtaCli ON Clientes.dniCli = CtaCli.dniCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
WHERE   saldo > ALL (SELECT saldo
                    FROM    Cuentas
                            INNER JOIN CtaCli ON Cuentas.numeroCta = CtaCli.numeroCta
                            INNER JOIN Clientes ON CtaCli.dniCli = Clientes.dniCli
                    WHERE nombreemp = 'Smith')

-- Nombre, número de cuenta y saldo de clientes que tienen cuentas con una saldo superior a alguna de las cuentas de Smith
SELECT  nombrecli, Cuentas.numerocta, saldo
FROM    Clientes
        INNER JOIN CtaCli ON Clientes.dniCli = CtaCli.dniCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
WHERE   saldo > ANY (SELECT saldo
                    FROM    Cuentas
                            INNER JOIN CtaCli ON Cuentas.numeroCta = CtaCli.numeroCta
                            INNER JOIN Clientes ON CtaCli.dniCli = Clientes.dniCli
                    WHERE nombreemp = 'Smith')

-- Número total de empleados
SELECT  COUNT(*) AS numEmpleados
FROM    Empleados

-- Cantidad de empleados de la sucursal Downtown
SELECT  COUNT(*) AS numEmpleados
FROM    Empleados
WHERE   nombresuc = 'Downtown'

-- En cuántas sucursales hay empleados trabajando
SELECT  COUNT(DISTINCT nombresuc) AS numSucursales
FROM    Empleados

-- Saldo total de las cuentas del cliente Johnson
SELECT  SUM(saldo) AS saldoTotal
FROM    Cuentas
        INNER JOIN CtaCli ON Cuentas.numeroCta = CtaCli.numeroCta
        INNER JOIN Clientes ON CtaCli.dniCli = Clientes.dniCli
WHERE   nombrecli = 'Johnson'

-- Saldo medio de las cuentas de la sucursal `Downtown`
SELECT  AVG(saldo) AS saldoMedio
FROM    Cuentas 
WHERE   nombreSuc = 'Downtown'

-- Obtener el mayor saldo de las cuentas de la sucursal `Downtown`
SELECT  MAX(saldo) AS saldoMaximo
FROM    Cuentas 
WHERE   nombreSuc = 'Downtown'

-- Saldo máximo de las cuentas del cliente `Johnson`
SELECT  MAX(saldo) AS saldoMaximo
FROM    Cuentas 
        INNER JOIN CtaCli ON Cuentas.numeroCta = CtaCli.numeroCta
        INNER JOIN Clientes ON CtaCli.dniCli = Clientes.dniCli
WHERE   nombrecli = 'Johnson'

-- Clientes que tienen cuentas con un saldo superior al saldo medio de las cuentas de `Johnson`
SELECT  nombrecli, Cuentas.numerocta, saldo
FROM    Clientes
        INNER JOIN CtaCli ON Clientes.dniCli = CtaCli.dniCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
WHERE   saldo > (SELECT AVG(saldo)
                 FROM    Cuentas
                         INNER JOIN CtaCli ON Cuentas.numeroCta = CtaCli.numeroCta
                         INNER JOIN Clientes ON CtaCli.dniCli = Clientes.dniCli
                 WHERE nombrecli = 'Johnson')

-- Saldo total de las cuentas agrupadas por sucursal:
SELECT  nombresuc, SUM(saldo) AS saldoTotal
FROM    Cuentas
GROUP BY nombresuc

-- Saldo total de las cuentas de las sucursales de la ciudad `Brooklyn`
SELECT  nombresuc, SUM(saldo) AS saldoTotal
FROM    Cuentas
        INNER JOIN Sucursales ON Cuentas.nombresuc = Sucursales.nombresuc
WHERE   ciudadsuc = 'Brooklyn'
GROUP BY nombresuc

-- Cuántos empleados trabajan en cada ciudad:
SELECT  ciudadsuc, COUNT(*) AS numEmpleados
FROM    Empleados
        INNER JOIN Sucursales ON Empleados.nombresuc = Sucursales.nombresuc
GROUP BY ciudadsuc

-- Cuántos empleados trabajan en cada ciudad (mostrando todas las ciudades)
SELECT  ciudadsuc, COUNT(Empleados.dniEmp) AS numEmpleados
FROM    Sucursales
        LEFT JOIN Empleados ON Sucursales.nombresuc = Empleados.nombresuc
GROUP BY ciudadsuc

-- Nombres de cada sucursal junto con el nombre de los empleados que trabajan en ella separados por comas
SELECT  nombresuc, GROUP_CONCAT(nombreemp) AS empleados
FROM    Empleados
GROUP BY nombresuc

-- Nombre de un cliente junto con el saldo total de sus cuentas
-- EVITAR ESTO
SELECT  nombrecli, SUM(saldo) AS saldoTotal
FROM    Clientes
        INNER JOIN CtaCli ON Clientes.dniCli = CtaCli.dniCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
GROUP BY nombrecli;

SELECT  dniCli, SUM(saldo) AS saldoTotal, 
        (SELECT nombrecli
         FROM    Clientes
         WHERE   Clientes.dniCli = CtaCli.dniCli) AS nombrecli
FROM    CtaCli
        INNER JOIN Cuentas ON CtaCli.numeroCta = Cuentas.numeroCta
GROUP BY dnicli

-- Cuántas cuentas con saldo superior a `10000` hay en cada sucursal.
-- Mostrar sólo aquellas sucursales que tienen más de una cuenta con saldo superior a `10000`
SELECT  nombresuc, COUNT(*) AS numCuentas
FROM    Cuentas
WHERE   saldo > 10000
GROUP BY nombresuc
HAVING numCuentas > 1

-- clientes que tienen más de una cuenta con saldo superior a `10000`. Mostrar el DNI y el nombre del cliente
-- y el número de cuentas que tiene
----
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
LIMIT 3

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
                               GROUP BY dniCli) AS subquery)

-- Crear una vista para mostrar la información de las cuentas y sus propietarios
CREATE VIEW InfoCuentas AS
SELECT  Cu.numerocta, Cu.saldo, Cu.nombresuc,
        Cl.nombrecli, Cl.dnicli
FROM    Cuentas Cu
        INNER JOIN CtaCli CC ON Cu.numeroCta = CC.numeroCta
        INNER JOIN Clientes Cl ON CC.dniCli = Cl.dniCli

-- Crear una vista que muestre cada sucursal y la ciudad a la que pertenece, junto con el número de empleados, el número de cuentas y el saldo total de las cuentas de cada sucursal
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
GROUP BY S.nombresuc

-- Crear una vista que muestre los clientes VIP, es decir, aquellos cuyo saldo total supera la media del saldo total por sucursal
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
                             GROUP BY nombresuc) T)