/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.5.29-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: digital_twin_ponte
-- ------------------------------------------------------
-- Server version	10.4.34-MariaDB-1:10.4.34+maria~ubu2004

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

--
-- Table structure for table `ALLARME`
--

DROP TABLE IF EXISTS `ALLARME`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ALLARME` (
  `id_allarme` int(11) NOT NULL AUTO_INCREMENT,
  `data_ora` datetime DEFAULT NULL,
  `tipologia` varchar(50) DEFAULT NULL,
  `gravita` varchar(30) DEFAULT NULL,
  `descrizione` text DEFAULT NULL,
  `stato` varchar(30) DEFAULT NULL,
  `data_risoluzione` datetime DEFAULT NULL,
  `id_misurazione` bigint(20) DEFAULT NULL,
  `id_soglia` int(11) DEFAULT NULL,
  `id_tecnico` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_allarme`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ALLARME`
--

LOCK TABLES `ALLARME` WRITE;
/*!40000 ALTER TABLE `ALLARME` DISABLE KEYS */;
/*!40000 ALTER TABLE `ALLARME` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INTERVENTO`
--

DROP TABLE IF EXISTS `INTERVENTO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `INTERVENTO` (
  `id_intervento` int(11) NOT NULL AUTO_INCREMENT,
  `data_apertura` date DEFAULT NULL,
  `data_esecuzione` date DEFAULT NULL,
  `tipologia` varchar(50) DEFAULT NULL,
  `descrizione` text DEFAULT NULL,
  `esito` text DEFAULT NULL,
  `stato` varchar(30) DEFAULT NULL,
  `id_ponte` int(11) DEFAULT NULL,
  `id_tecnico` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_intervento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INTERVENTO`
--

LOCK TABLES `INTERVENTO` WRITE;
/*!40000 ALTER TABLE `INTERVENTO` DISABLE KEYS */;
/*!40000 ALTER TABLE `INTERVENTO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INTERVENTO_SENSORE`
--

DROP TABLE IF EXISTS `INTERVENTO_SENSORE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `INTERVENTO_SENSORE` (
  `id_intervento` int(11) NOT NULL,
  `id_sensore` int(11) NOT NULL,
  `descrizione_intervento` text DEFAULT NULL,
  `esito_sensore` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_intervento`,`id_sensore`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INTERVENTO_SENSORE`
--

LOCK TABLES `INTERVENTO_SENSORE` WRITE;
/*!40000 ALTER TABLE `INTERVENTO_SENSORE` DISABLE KEYS */;
/*!40000 ALTER TABLE `INTERVENTO_SENSORE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MISURAZIONE`
--

DROP TABLE IF EXISTS `MISURAZIONE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `MISURAZIONE` (
  `id_misurazione` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime DEFAULT NULL,
  `valore` decimal(15,6) DEFAULT NULL,
  `qualita_dato` varchar(20) DEFAULT NULL,
  `errore` varchar(255) DEFAULT NULL,
  `id_sensore` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_misurazione`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MISURAZIONE`
--

LOCK TABLES `MISURAZIONE` WRITE;
/*!40000 ALTER TABLE `MISURAZIONE` DISABLE KEYS */;
/*!40000 ALTER TABLE `MISURAZIONE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PONTE`
--

DROP TABLE IF EXISTS `PONTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `PONTE` (
  `id_ponte` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `localita` varchar(150) NOT NULL,
  `lunghezza` decimal(8,2) NOT NULL,
  `data_costruzione` date DEFAULT NULL,
  `materiale` varchar(50) DEFAULT NULL,
  `numero_campate` int(11) DEFAULT NULL,
  `stato` varchar(30) NOT NULL,
  PRIMARY KEY (`id_ponte`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PONTE`
--

LOCK TABLES `PONTE` WRITE;
/*!40000 ALTER TABLE `PONTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `PONTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REPORT`
--

DROP TABLE IF EXISTS `REPORT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `REPORT` (
  `id_report` int(11) NOT NULL AUTO_INCREMENT,
  `data_generazione` datetime DEFAULT NULL,
  `periodo_inizio` datetime DEFAULT NULL,
  `periodo_fine` datetime DEFAULT NULL,
  `tipologia` varchar(50) DEFAULT NULL,
  `percorso_file` varchar(255) DEFAULT NULL,
  `id_ponte` int(11) DEFAULT NULL,
  `id_tecnico` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_report`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REPORT`
--

LOCK TABLES `REPORT` WRITE;
/*!40000 ALTER TABLE `REPORT` DISABLE KEYS */;
/*!40000 ALTER TABLE `REPORT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SENSORE`
--

DROP TABLE IF EXISTS `SENSORE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SENSORE` (
  `id_sensore` int(11) NOT NULL AUTO_INCREMENT,
  `codice` varchar(50) DEFAULT NULL,
  `posizione` varchar(150) DEFAULT NULL,
  `unita_misura` varchar(20) DEFAULT NULL,
  `data_installazione` date DEFAULT NULL,
  `stato` varchar(30) DEFAULT NULL,
  `frequenza` int(11) DEFAULT NULL,
  `id_ponte` int(11) DEFAULT NULL,
  `id_tipologia` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_sensore`),
  UNIQUE KEY `codice` (`codice`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SENSORE`
--

LOCK TABLES `SENSORE` WRITE;
/*!40000 ALTER TABLE `SENSORE` DISABLE KEYS */;
/*!40000 ALTER TABLE `SENSORE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SOGLIA`
--

DROP TABLE IF EXISTS `SOGLIA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SOGLIA` (
  `id_soglia` int(11) NOT NULL AUTO_INCREMENT,
  `valore_minimo` decimal(15,6) DEFAULT NULL,
  `valore_massimo` decimal(15,6) DEFAULT NULL,
  `livello_criticita` varchar(30) DEFAULT NULL,
  `data_inizio` datetime DEFAULT NULL,
  `data_fine` datetime DEFAULT NULL,
  `id_sensore` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_soglia`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SOGLIA`
--

LOCK TABLES `SOGLIA` WRITE;
/*!40000 ALTER TABLE `SOGLIA` DISABLE KEYS */;
/*!40000 ALTER TABLE `SOGLIA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TECNICO`
--

DROP TABLE IF EXISTS `TECNICO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `TECNICO` (
  `id_tecnico` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `cognome` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `ruolo` varchar(50) DEFAULT NULL,
  `specializzazione` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_tecnico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TECNICO`
--

LOCK TABLES `TECNICO` WRITE;
/*!40000 ALTER TABLE `TECNICO` DISABLE KEYS */;
/*!40000 ALTER TABLE `TECNICO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TIPOLOGIA_SENSORE`
--

DROP TABLE IF EXISTS `TIPOLOGIA_SENSORE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `TIPOLOGIA_SENSORE` (
  `id_tipologia` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descrizione` text DEFAULT NULL,
  `grandezza_fisica` varchar(80) DEFAULT NULL,
  `unita_misura_standard` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_tipologia`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TIPOLOGIA_SENSORE`
--

LOCK TABLES `TIPOLOGIA_SENSORE` WRITE;
/*!40000 ALTER TABLE `TIPOLOGIA_SENSORE` DISABLE KEYS */;
/*!40000 ALTER TABLE `TIPOLOGIA_SENSORE` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-23 13:22:32
