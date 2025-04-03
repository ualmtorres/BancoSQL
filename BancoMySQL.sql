
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS Banco;

-- DROP Existing tables
DROP TABLE IF EXISTS `CtaCli`;
DROP TABLE IF EXISTS `Transacciones`;
DROP TABLE IF EXISTS `Clientes`;
DROP TABLE IF EXISTS `Cuentas`;
DROP TABLE IF EXISTS `Empleados`;
DROP TABLE IF EXISTS `Sucursales`;
USE Banco;
--
-- Table structure for table `Clientes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Clientes` (
  `nombreCli` varchar(255),
  `dniCli` varchar(255),
  `domicilio` varchar(255),
  PRIMARY KEY (dniCli)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Clientes`
--

LOCK TABLES `Clientes` WRITE;
/*!40000 ALTER TABLE `Clientes` DISABLE KEYS */;
INSERT INTO `Clientes` VALUES ('Johnson','1','La Reina nº 7'),('Smith','2','Fragata Azul nº 8'),('Hayes','3','Gibraltar Español nº 14'),('Turner','4','Gibraltar Español nº 17'),('Williams','5','Diamante S/N'),('Lindsay','6','Gato negro nº 13'),('Green','7','Perro nº 1');
/*!40000 ALTER TABLE `Clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CtaCli`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CtaCli` (
  `dniCli` varchar(255),
  `numeroCta` varchar(255),
  PRIMARY KEY(dniCli, numeroCta)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CtaCli`
--

LOCK TABLES `CtaCli` WRITE;
/*!40000 ALTER TABLE `CtaCli` DISABLE KEYS */;
INSERT INTO `CtaCli` VALUES ('1','1'),('1','2'),(1,'6'),('2','3'),('3','4'),('4','5'),('5','5'),('6','5'),('7','6');
/*!40000 ALTER TABLE `CtaCli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cuentas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cuentas` (
  `numeroCta` varchar(255) ,
  `saldo` decimal(10,1) ,
  `nombreSuc` varchar(255) ,
  PRIMARY KEY(numeroCta)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cuentas`
--

LOCK TABLES `Cuentas` WRITE;
/*!40000 ALTER TABLE `Cuentas` DISABLE KEYS */;
INSERT INTO `Cuentas` VALUES ('1',10000.0,'Downtown'),('2',20000.0,'Downtown'),('3',30000.0,'Perrydge'),('4',40000.0,'Perrydge'),('5',50000.0,'Mianus'),('6',60000.0,'Brighton');
/*!40000 ALTER TABLE `Cuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Empleados`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Empleados` (
  `nombreEmp` varchar(255) ,
  `dniEmp` varchar(255) ,
  `telefono` varchar(15) ,
  `nombreSuc` varchar(255) ,
  PRIMARY KEY (dniEmp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Empleados`
--

LOCK TABLES `Empleados` WRITE;
/*!40000 ALTER TABLE `Empleados` DISABLE KEYS */;
INSERT INTO `Empleados` VALUES ('Smith','10','101010','Downtown'),('Kortz','11','111111','Downtown'),('Hansen','12','121212','Perrydge'),('Dubitzky','13','131313','Perrydge'),('Henson','14','141414','Mianus'),('Kravitz','15','151515','Brighton');
/*!40000 ALTER TABLE `Empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sucursales`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sucursales` (
  `nombreSuc` varchar(255) ,
  `ciudadSuc` varchar(255) ,
  `activo` decimal(10,1) ,
  PRIMARY KEY(nombreSuc)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sucursales`
--

LOCK TABLES `Sucursales` WRITE;
/*!40000 ALTER TABLE `Sucursales` DISABLE KEYS */;
INSERT INTO `Sucursales` VALUES ('Downtown','Brooklyn',9000000.0),('Redwood','Palo Alto',2100000.0),('Perrydge','Horseneck',1700000.0),('Mianus','Horseneck',400000.0),('Round Hill','Horseneck',8000000.0),('Pownal','Bennington',300000.0),('North Town','Rye',3700000.0),('Brighton','Brooklyn',7100000.0);
/*!40000 ALTER TABLE `Sucursales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transacciones`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Transacciones` (
  `numeroCta` varchar(255) ,
  `numeroTrans` INT,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `importe` decimal(10,1) ,
  PRIMARY KEY(numeroCta, numeroTrans)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transacciones`
--

LOCK TABLES `Transacciones` WRITE;
/*!40000 ALTER TABLE `Transacciones` DISABLE KEYS */;
INSERT INTO `Transacciones`
VALUES ('1',1,NULL,10000.0),('2',1,NULL,30000.0),('2',2,NULL,-20000.0),('3',1,NULL,30000.0),('4',1,NULL,40000.0),('5',1,NULL,50000.0),('6',1,NULL,60000.0);
/*!40000 ALTER TABLE `Transacciones` ENABLE KEYS */;
UNLOCK TABLES;

