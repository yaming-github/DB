-- MySQL dump 10.13  Distrib 8.0.29, for macos12 (x86_64)
--
-- Host: 119.28.163.231    Database: db_trip
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_city`
--

DROP TABLE IF EXISTS `t_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_city` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `state` varchar(64) NOT NULL DEFAULT '',
  `country` varchar(64) NOT NULL DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`state`,`country`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_city`
--

LOCK TABLES `t_city` WRITE;
/*!40000 ALTER TABLE `t_city` DISABLE KEYS */;
INSERT INTO `t_city` VALUES (1,'Boston','MA','USA','2023-04-19 20:00:26','2023-04-19 20:00:26'),(2,'NYC','NY','USA','2023-04-19 20:00:51','2023-04-19 20:00:51'),(5,'DC','DC','USA','2023-04-19 22:16:27','2023-04-19 22:16:27'),(7,'Phily','PA','USA','2023-04-19 22:26:54','2023-04-19 22:26:54'),(10,'LA','CA','USA','2023-04-21 16:50:30','2023-04-21 16:50:30');
/*!40000 ALTER TABLE `t_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_restaurant`
--

DROP TABLE IF EXISTS `t_restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_restaurant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city_id` int NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '',
  `address` varchar(64) NOT NULL DEFAULT '',
  `cuisine` varchar(64) NOT NULL DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `city_id` (`city_id`,`address`),
  CONSTRAINT `t_restaurant_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `t_city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_restaurant`
--

LOCK TABLES `t_restaurant` WRITE;
/*!40000 ALTER TABLE `t_restaurant` DISABLE KEYS */;
INSERT INTO `t_restaurant` VALUES (1,1,'salty','pru','USA','2023-04-19 22:13:49','2023-04-19 22:13:49'),(10,7,'12','123','chinese','2023-04-21 01:26:11','2023-04-21 01:26:11');
/*!40000 ALTER TABLE `t_restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trip`
--

DROP TABLE IF EXISTS `t_trip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_trip` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `owner` varchar(64) NOT NULL DEFAULT '',
  `date_from` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_to` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  CONSTRAINT `t_trip_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `t_user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trip`
--

LOCK TABLES `t_trip` WRITE;
/*!40000 ALTER TABLE `t_trip` DISABLE KEYS */;
INSERT INTO `t_trip` VALUES (1,'123','yaming','2023-03-29 00:00:00','2023-04-04 00:00:00','2023-04-19 19:59:28','2023-04-20 19:52:28'),(2,'Maimi','yaming','2023-03-03 00:00:00','2023-04-04 00:00:00','2023-04-19 19:59:28','2023-04-20 20:07:30'),(3,'123','yaming2','2023-03-29 00:00:00','2023-04-04 00:00:00','2023-04-20 02:05:23','2023-04-20 19:52:28'),(4,'123','yaming2','2023-03-29 00:00:00','2023-04-04 00:00:00','2023-04-20 02:05:23','2023-04-20 19:52:28'),(11,'road trip','yaming','2023-03-29 00:00:00','2023-04-19 00:00:00','2023-04-20 04:59:28','2023-04-20 20:07:04'),(16,'123','yaming2','2023-03-29 00:00:00','2023-04-04 00:00:00','2023-04-20 18:58:18','2023-04-20 19:52:28'),(17,'123','yaming2','2023-03-29 00:00:00','2023-04-04 00:00:00','2023-04-20 18:59:28','2023-04-20 19:52:28'),(18,'123','yaming2','2023-03-29 00:00:00','2023-04-04 00:00:00','2023-04-20 19:00:47','2023-04-20 19:52:28'),(19,'123','yaming2','2023-03-29 00:00:00','2023-04-04 00:00:00','2023-04-20 19:02:06','2023-04-20 19:52:28'),(21,'cs5200','yaming','2023-04-06 00:00:00','2023-04-05 00:00:00','2023-04-21 17:07:59','2023-04-21 17:07:59');
/*!40000 ALTER TABLE `t_trip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trip_city`
--

DROP TABLE IF EXISTS `t_trip_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_trip_city` (
  `id` int NOT NULL AUTO_INCREMENT,
  `trip_id` int NOT NULL DEFAULT '0',
  `city_id` int NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trip_id` (`trip_id`,`city_id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `t_trip_city_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `t_trip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_trip_city_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `t_city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trip_city`
--

LOCK TABLES `t_trip_city` WRITE;
/*!40000 ALTER TABLE `t_trip_city` DISABLE KEYS */;
INSERT INTO `t_trip_city` VALUES (1,1,1,'2020-02-02 00:00:00','2023-04-21 01:24:46','2023-04-21 01:24:46'),(2,1,2,'2020-02-02 00:00:00','2023-04-21 01:24:46','2023-04-21 01:24:46'),(3,1,7,'2023-04-06 00:00:00','2023-04-21 16:44:18','2023-04-21 16:44:18'),(4,2,10,'2023-04-21 00:00:00','2023-04-21 16:56:03','2023-04-21 16:56:03'),(5,1,5,'2023-04-19 00:00:00','2023-04-21 17:11:36','2023-04-21 17:11:36');
/*!40000 ALTER TABLE `t_trip_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trip_company`
--

DROP TABLE IF EXISTS `t_trip_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_trip_company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `trip_id` int NOT NULL DEFAULT '0',
  `company` varchar(64) NOT NULL DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trip_id` (`trip_id`,`company`),
  KEY `company` (`company`),
  CONSTRAINT `t_trip_company_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `t_trip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_trip_company_ibfk_2` FOREIGN KEY (`company`) REFERENCES `t_user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trip_company`
--

LOCK TABLES `t_trip_company` WRITE;
/*!40000 ALTER TABLE `t_trip_company` DISABLE KEYS */;
INSERT INTO `t_trip_company` VALUES (1,3,'yaming','2023-04-20 02:06:06','2023-04-20 02:06:06'),(5,17,'yaming','2023-04-20 18:59:28','2023-04-20 18:59:28'),(6,18,'yaming','2023-04-20 19:00:47','2023-04-20 19:00:47'),(11,2,'yaming2','2023-04-20 20:07:30','2023-04-20 20:07:30'),(12,21,'check','2023-04-21 17:07:59','2023-04-21 17:07:59'),(13,21,'yaming2','2023-04-21 17:07:59','2023-04-21 17:07:59');
/*!40000 ALTER TABLE `t_trip_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trip_images`
--

DROP TABLE IF EXISTS `t_trip_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_trip_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `trip_id` int NOT NULL DEFAULT '0',
  `url` varchar(256) NOT NULL DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_trip_id` (`trip_id`),
  CONSTRAINT `t_trip_images_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `t_trip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trip_images`
--

LOCK TABLES `t_trip_images` WRITE;
/*!40000 ALTER TABLE `t_trip_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_trip_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trip_meal`
--

DROP TABLE IF EXISTS `t_trip_meal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_trip_meal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `trip_id` int NOT NULL DEFAULT '0',
  `restaurant_id` int NOT NULL DEFAULT '0',
  `review` varchar(64) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `trip_id` (`trip_id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `t_trip_meal_ibfk_1` FOREIGN KEY (`trip_id`) REFERENCES `t_trip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_trip_meal_ibfk_2` FOREIGN KEY (`restaurant_id`) REFERENCES `t_restaurant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trip_meal`
--

LOCK TABLES `t_trip_meal` WRITE;
/*!40000 ALTER TABLE `t_trip_meal` DISABLE KEYS */;
INSERT INTO `t_trip_meal` VALUES (3,1,1,'','2023-02-02 00:00:00','2023-04-21 01:27:24','2023-04-21 01:27:24'),(4,1,10,'','2020-02-02 00:00:00','2023-04-21 01:27:24','2023-04-21 01:27:24');
/*!40000 ALTER TABLE `t_trip_meal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(64) NOT NULL,
  `username` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL DEFAULT '',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES (1,'zhang.yam@northeastern.edu','yaming','123456','2023-04-19 19:59:15','2023-04-19 19:59:15'),(3,'zhangyaming0726@gmail.com','yaming2','123456','2023-04-20 01:02:30','2023-04-20 01:02:30'),(4,'123@456.com','check','123456','2023-04-21 17:06:52','2023-04-21 17:06:52');
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_trip'
--
/*!50003 DROP PROCEDURE IF EXISTS `get_itinerary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_itinerary`(id_p INT(11))
BEGIN
select a.date, b.name
from t_trip_city a join t_city b on a.city_id = b.id and a.trip_id = id_p
order by a.date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_my_part_trips` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_my_part_trips`(username VARCHAR(64))
BEGIN
SELECT a.id, name, group_concat(company), date_from, date_to
    FROM t_trip a join t_trip_company b
    on a.id = b.trip_id and a.id in (select trip_id from t_trip_company where company = username) group by a.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_my_trips` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_my_trips`(username VARCHAR(64))
BEGIN
SELECT a.id, name, group_concat(company), date_from, date_to
    FROM t_trip a left join t_trip_company b
    on a.id = b.trip_id where owner = username group by a.id order by a.id desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_ress` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_ress`()
BEGIN
SELECT a.id, b.name, a.name, address, cuisine
    FROM t_restaurant a join t_city b
    on a. city_id = b.id
    order by a.id desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_trip_meals` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_trip_meals`(id_p INT(11))
BEGIN
select a.date, b.name
from t_trip_meal a join t_restaurant b on a.restaurant_id = b.id and a.trip_id = id_p
order by a.date;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_trip` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insert_trip`(
name_p varchar(64),
owner_p varchar(64),
date_from datetime,
date_to datetime,
companies varchar(256)
)
BEGIN

start transaction;

insert into t_trip(name, owner, date_from, date_to) values (name_p, owner_p, date_from, date_to);
set @rowid = last_insert_id();

-- could optimize here cuz we should batch insert to reduce I/O
WHILE CHAR_LENGTH(companies) > 0 DO
  set @next_position = LOCATE(',', companies);
  SET @vv = SUBSTRING(companies, 1, @next_position - 1);
  insert into t_trip_company(trip_id, company) values (@rowid, @vv);
  SET companies = SUBSTRING(companies, @next_position + 1);
END WHILE;

commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_trip` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `update_trip`(
id_p INT(11),
name_p varchar(64),
date_from_p datetime,
date_to_p datetime,
companies varchar(256)
)
BEGIN

start transaction;

update t_trip set name = name_p, date_from = date_from_p, date_to = date_to_p where id = id_p;

delete from t_trip_company where trip_id = id_p;

-- could optimize here cuz we should batch insert to reduce I/O
WHILE CHAR_LENGTH(companies) > 0 DO
  set @next_position = LOCATE(',', companies);
  SET @vv = SUBSTRING(companies, 1, @next_position - 1);
  insert into t_trip_company(trip_id, company) values (id_p, @vv);
  SET companies = SUBSTRING(companies, @next_position + 1);
END WHILE;

commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-21 13:37:03
