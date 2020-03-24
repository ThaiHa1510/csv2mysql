-- MySQL dump 10.13  Distrib 8.0.19, for Linux (x86_64)
--
-- Host: localhost    Database: testcsv
-- ------------------------------------------------------
-- Server version	8.0.19-0ubuntu0.19.10.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `demo2`
--

DROP TABLE IF EXISTS `demo2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demo2` (
  `Year` int NOT NULL,
  `Industry_aggregation_NZSIOC` longtext,
  `Industry_code_NZSIOC` longtext,
  `Industry_name_NZSIOC` longtext,
  `Units` longtext,
  `Variable_code` longtext,
  `Variable_name` longtext,
  `Variable_category` longtext,
  `Value` longtext,
  `Industry_code_ANZSIC06` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demo2`
--

LOCK TABLES `demo2` WRITE;
/*!40000 ALTER TABLE `demo2` DISABLE KEYS */;
/*!40000 ALTER TABLE `demo2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file` varchar(255) DEFAULT NULL,
  `progress` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (84,'annual-enterprise-survey-2018-financial-year-provisional-csv.csv.darf',100,0,'2020-03-21 11:54:11','2020-03-21 11:54:11'),(85,'test-null.csv',100,0,'2020-03-24 09:49:08','2020-03-24 09:49:08');
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workers`
--

DROP TABLE IF EXISTS `workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `last_heathy` varchar(45) DEFAULT NULL,
  `jobId` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workers`
--

LOCK TABLES `workers` WRITE;
/*!40000 ALTER TABLE `workers` DISABLE KEYS */;
INSERT INTO `workers` VALUES (32,'node','/node/','1','2020-03-23 13:38:50',85),(33,'node','/node/','1','2020-03-23 13:38:50',85),(34,'node','/node/','1','2020-03-23 13:38:50',85),(35,'node','/node/','1','2020-03-23 13:38:50',85),(36,'node','/node/','1','2020-03-23 13:38:50',85),(37,'node','/node/','1','2020-03-23 13:38:50',85),(38,'node','/node/','1','2020-03-23 13:38:50',85),(39,'node','/node/','1','2020-03-23 13:38:50',85),(40,'node','/node/','1','2020-03-23 13:38:50',85),(41,'node','/node/','1','2020-03-23 13:38:50',85),(42,'node','/node/','1','2020-03-23 13:53:19',85),(43,'node','/node/','1','2020-03-23 13:54:29',85),(44,'node','/node/','1','2020-03-23 13:55:22',85),(45,'node','/node/','1','2020-03-23 14:26:48',85),(46,'node','/node/','1','2020-03-23 14:29:39',85),(47,'node','/node/','1','2020-03-23 14:31:48',85),(48,'node','/node/','1','2020-03-23 14:33:52',85),(49,'node','/node/','1','2020-03-23 14:54:20',85),(50,'node','/node/','1','2020-03-23 14:55:00',85),(51,'node','/node/','1','2020-03-23 14:55:19',85),(52,'node','/node/','1','2020-03-23 14:57:02',85),(53,'node','/node/','1','2020-03-23 14:57:34',85),(54,'node','/node/','1','2020-03-23 14:59:55',85),(55,'node','/node/','1','2020-03-23 15:34:57',85),(56,'node','/node/','1','2020-03-23 15:34:57',85),(57,'node','/node/','1','2020-03-23 15:34:57',85),(58,'node','/node/','1','2020-03-23 15:34:57',85),(59,'node','/node/','1','2020-03-23 15:34:57',85),(60,'node','/node/','1','2020-03-23 15:34:57',85),(61,'node','/node/','1','2020-03-23 15:34:57',85),(62,'node','/node/','1','2020-03-23 15:34:57',85),(63,'node','/node/','1','2020-03-23 15:34:57',85),(64,'node','/node/','1','2020-03-23 15:34:57',85),(65,'node','/node/','1','2020-03-23 15:36:21',85),(66,'node','/node/','1','2020-03-23 15:36:21',85),(67,'node','/node/','1','2020-03-23 15:36:21',85),(68,'node','/node/','1','2020-03-23 15:36:21',85),(69,'node','/node/','1','2020-03-23 15:36:21',85),(70,'node','/node/','1','2020-03-23 15:36:21',85),(71,'node','/node/','1','2020-03-23 15:36:21',85),(72,'node','/node/','1','2020-03-23 15:36:21',85),(73,'node','/node/','1','2020-03-23 15:36:21',85),(74,'node','/node/','1','2020-03-23 15:36:21',85),(75,'node','/node/','1','2020-03-23 15:37:19',85),(76,'node','/node/','1','2020-03-23 15:37:19',85),(77,'node','/node/','1','2020-03-23 15:37:19',85),(78,'node','/node/','1','2020-03-23 15:37:19',85),(79,'node','/node/','1','2020-03-23 15:37:19',85),(80,'node','/node/','1','2020-03-23 15:37:19',85),(81,'node','/node/','1','2020-03-23 15:37:19',85),(82,'node','/node/','1','2020-03-23 15:37:19',85),(83,'node','/node/','1','2020-03-23 15:37:19',85),(84,'node','/node/','1','2020-03-23 15:37:19',85),(85,'node','/node/','1','2020-03-23 15:52:18',85),(86,'node','/node/','1','2020-03-23 15:52:18',85),(87,'node','/node/','1','2020-03-23 15:52:18',85),(88,'node','/node/','1','2020-03-23 15:52:18',85),(89,'node','/node/','1','2020-03-23 15:52:18',85),(90,'node','/node/','1','2020-03-23 15:52:18',85),(91,'node','/node/','1','2020-03-23 15:52:18',85),(92,'node','/node/','1','2020-03-23 15:52:18',85),(93,'node','/node/','1','2020-03-23 15:52:18',85),(94,'node','/node/','1','2020-03-23 15:52:18',85),(95,'node','/node/','1','2020-03-23 16:09:04',85),(96,'node','/node/','1','2020-03-23 16:10:57',85),(97,'node','/node/','1','2020-03-23 16:12:11',85),(98,'node','/node/','1','2020-03-23 16:13:05',85),(99,'node','/node/','1','2020-03-23 16:25:17',85),(100,'node','/node/','1','2020-03-23 16:33:42',85),(101,'node','/node/','1','2020-03-23 16:37:37',85),(102,'node','/node/','1','2020-03-23 16:38:24',85),(103,'node','/node/','1','2020-03-23 16:45:33',85),(104,'node','/node/','1','2020-03-24 09:42:40',85),(105,'node','/node/','1','2020-03-24 09:43:43',85),(106,'node','/node/','1','2020-03-24 09:49:08',85),(107,'node','/node/','1','2020-03-24 09:49:08',85),(108,'node','/node/','1','2020-03-24 09:49:08',85),(109,'node','/node/','1','2020-03-24 09:49:08',85),(110,'node','/node/','1','2020-03-24 09:49:08',85),(111,'node','/node/','1','2020-03-24 09:49:08',85),(112,'node','/node/','1','2020-03-24 09:49:08',85),(113,'node','/node/','1','2020-03-24 09:49:08',85),(114,'node','/node/','1','2020-03-24 09:49:08',85),(115,'node','/node/','1','2020-03-24 09:49:08',85);
/*!40000 ALTER TABLE `workers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-24 10:22:09
