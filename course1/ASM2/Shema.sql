-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `ID_COMMENT` int NOT NULL AUTO_INCREMENT,
  `NGUOI_COMMENT` int NOT NULL,
  `time_comment` date DEFAULT NULL,
  `noi_dung` text,
  PRIMARY KEY (`ID_COMMENT`),
  KEY `User_id_fk_idx` (`NGUOI_COMMENT`),
  CONSTRAINT `User_commnet_id_fk` FOREIGN KEY (`NGUOI_COMMENT`) REFERENCES `users` (`ID_USER`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,'2018-01-22',' TOI CUNG NGHI NHU VAY'),(2,4,'2018-01-22',' KHONG THE CHAP NHAN DUOC'),(3,10,'2018-01-23','QUAN DIM CUA TOI VAN LÀ 1 VO 1 CHONG'),(4,6,'2018-03-24',' RA LA VAY'),(5,8,'2018-03-25',' GIAO THONG DAO NAY CHAN QUA'),(6,3,'2018-03-22',' BUON THAT SU'),(7,8,'2018-03-24',' XA HOI GIO LOAN LAM MOI NGUOI A'),(8,9,'2018-03-26',' CHAN.......'),(9,5,'2018-03-12',' MOI NGUOI CO LEN'),(10,7,'2018-03-12',' CAC CHIEN SI TUYET VOI'),(11,2,'2018-03-12',' CHUC CAC CHIEN SI LUON KHO MANH DE PHUC VU DAN'),(12,3,'2018-04-10',' SAP TOI NGAY THUONG BINH LIET SI ROI'),(13,4,'2018-04-10',' NAM NAY DE THI SE KHO DAY'),(14,8,'2018-04-20','KHONG BIET VAN SE RA DE GI DAY'),(15,3,'2024-04-15','Siuuuuuuuuuuuuuuuuuuuuuuuuu'),(16,3,'2024-04-15','polotilo');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `handle_nums_of_comment_on_day` AFTER INSERT ON `comment` FOR EACH ROW begin
    if(exists(select * from comment_on_day where id_user = new.nguoi_comment and day = new.time_comment))
    then 
        update comment_on_day set number_of_comment = number_of_comment + 1 where id_user = new.nguoi_comment and day = new.time_comment;
    else
        insert into comment_on_day(id_user,day,number_of_comment) values (new.nguoi_comment, new.time_comment,1);
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `comment_on_day`
--

DROP TABLE IF EXISTS `comment_on_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_on_day` (
  `id_user` int NOT NULL,
  `day` date NOT NULL,
  `number_of_comment` int DEFAULT NULL,
  PRIMARY KEY (`id_user`,`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_on_day`
--

LOCK TABLES `comment_on_day` WRITE;
/*!40000 ALTER TABLE `comment_on_day` DISABLE KEYS */;
INSERT INTO `comment_on_day` VALUES (3,'2024-04-15',2);
/*!40000 ALTER TABLE `comment_on_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `get_comment`
--

DROP TABLE IF EXISTS `get_comment`;
/*!50001 DROP VIEW IF EXISTS `get_comment`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `get_comment` AS SELECT 
 1 AS `ID_COMMENT`,
 1 AS `NGUOI_COMMENT`,
 1 AS `time_comment`,
 1 AS `noi_dung`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managers` (
  `ID_MNG` int NOT NULL AUTO_INCREMENT,
  `TEN` varchar(45) NOT NULL,
  `NAM_SINH` year DEFAULT NULL,
  PRIMARY KEY (`ID_MNG`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
INSERT INTO `managers` VALUES (1,'HOANG ANH',1998),(2,'VIET ANH',1990),(3,'QUYNH NGUYEN',1995),(4,'THANH THAO',1996),(5,'HOANG ANH',1998),(6,'VIET ANH',1990),(7,'QUYNH NGUYEN',1995),(8,'THANH THAO',1996),(9,'HOANG ANH',1998),(10,'VIET ANH',1990),(11,'QUYNH NGUYEN',1995),(12,'THANH THAO',1996),(13,'HOANG ANH',1998),(14,'VIET ANH',1990),(15,'QUYNH NGUYEN',1995),(16,'THANH THAO',1996),(17,'HOANG ANH',1998),(18,'VIET ANH',1990),(19,'QUYNH NGUYEN',1995),(20,'THANH THAO',1996);
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `ID_POST` int NOT NULL AUTO_INCREMENT,
  `TIEU_DE` text NOT NULL,
  `NOI_DUNG` text NOT NULL,
  `IMAGEs` varchar(45) DEFAULT NULL,
  `TAC_GIA` int NOT NULL,
  `LUOT_XEM` int NOT NULL,
  `NGUOI_DUYET` int DEFAULT NULL,
  `thoi_gian_dang` date DEFAULT NULL,
  `xet_duyet` int DEFAULT NULL,
  PRIMARY KEY (`ID_POST`),
  KEY `Manager_id_fk_idx` (`NGUOI_DUYET`),
  KEY `Reposter_id_fk_idx` (`TAC_GIA`),
  KEY `post_heading_idx` (`TIEU_DE`(100)),
  KEY `post_day_inx` (`thoi_gian_dang`),
  CONSTRAINT `Manager_id_fk` FOREIGN KEY (`NGUOI_DUYET`) REFERENCES `managers` (`ID_MNG`),
  CONSTRAINT `Reposter_id_fk` FOREIGN KEY (`TAC_GIA`) REFERENCES `reposter` (`ID_REPOSTER`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (61,'LAO DONG','NGUOI LAO ĐONG ĐANG THAT NGHIEP NHIEU........',NULL,3,20,1,'2018-01-20',1),(62,'TIN AN NINH',' VAO HOI 12H ....',NULL,4,10,1,'2018-01-20',1),(63,'GIAO THONG VÀ BAI TOAN KET XE',' HOM NAY ....',NULL,1,16,1,'2018-01-21',0),(64,'LUAT HON NHAN GIA DINH',' THEO NGHI QUYET....',NULL,5,30,4,'2018-01-22',1),(65,'GIAO DUC',' KI THI THPT QUOC GIA NAM NAY ....',NULL,2,50,3,'2018-02-22',1),(66,'GIAO THONG ',' HOM NAY CÓ MO VU TAI NAN XE HOI ....',NULL,1,10,1,'2018-02-24',1),(67,'TIN QUOC TE',' BÔ NGOAI GIAO VIET NAM SANG THAM CHINH PHU CAMPUCHIA ....',NULL,5,100,4,'2018-01-24',1),(68,'SUC KHOE NGUOI DAN',' HOM NAY , BO CONG AN PHONG CHONG THUC PHAM DOC HAI ĐÃ  ....',NULL,5,10,2,'2018-03-25',1),(69,'PHAP LUAT ',' DU AN ALIBABA DA BỊ DNH CHI VI NGHI NGO CHU DOANH NGIEP NAY ....',NULL,1,50,1,'2018-05-26',1),(70,'AN NINH ',' VAO HOI 15H CHIEU NGAY HOM NAY, CONG AN DA BAT QUA TANG....',NULL,1,40,4,'2018-06-24',1);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reposter`
--

DROP TABLE IF EXISTS `reposter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reposter` (
  `ID_REPOSTER` int NOT NULL AUTO_INCREMENT,
  `TEN` varchar(45) NOT NULL,
  `TO_CHUC` varchar(45) DEFAULT NULL,
  `nam_sinh` year DEFAULT NULL,
  PRIMARY KEY (`ID_REPOSTER`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reposter`
--

LOCK TABLES `reposter` WRITE;
/*!40000 ALTER TABLE `reposter` DISABLE KEYS */;
INSERT INTO `reposter` VALUES (1,'TRANG NGUYEN','BAO THANH NIEN',1980),(2,'TUAN ANH','BAO THE THAO',1999),(3,'TRINH DUONG','BAO PHAP LUAT',1995),(4,'THU THAO','DAI TRUYEN HINH VTC',1997),(5,'VIET NGUYEN','BAO VOV GIAO THONG ',1990);
/*!40000 ALTER TABLE `reposter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `share`
--

DROP TABLE IF EXISTS `share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `share` (
  `ID_SHARE` int NOT NULL AUTO_INCREMENT,
  `NGUOI_SHARE` int NOT NULL,
  `time_share` date DEFAULT NULL,
  PRIMARY KEY (`ID_SHARE`),
  KEY `User_id_fk_idx` (`NGUOI_SHARE`),
  CONSTRAINT `User_id_fk` FOREIGN KEY (`NGUOI_SHARE`) REFERENCES `users` (`ID_USER`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `share`
--

LOCK TABLES `share` WRITE;
/*!40000 ALTER TABLE `share` DISABLE KEYS */;
INSERT INTO `share` VALUES (1,1,'2018-01-23'),(2,4,'2018-01-22'),(3,5,'2018-01-25'),(4,3,'2018-01-23'),(5,5,'2018-01-23'),(6,6,'2018-01-23'),(7,8,'2018-01-23'),(8,10,'2018-01-23'),(9,8,'2018-01-23'),(10,9,'2019-01-23'),(11,1,'2019-01-23'),(12,5,'2019-01-23'),(13,2,'2018-01-23'),(14,2,'2018-01-23'),(15,4,'2019-01-23'),(16,3,'2019-01-23'),(17,6,'2019-01-23'),(18,5,'2019-01-23');
/*!40000 ALTER TABLE `share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `ID_USER` int NOT NULL AUTO_INCREMENT,
  `ACCOUNT_NAME` varchar(45) NOT NULL,
  `PASSWORDs` varchar(45) DEFAULT NULL,
  `FACEBOOK_USER` varchar(100) DEFAULT NULL,
  `EMAIL_USER` varchar(100) DEFAULT NULL,
  `ID_MNG` int DEFAULT NULL,
  PRIMARY KEY (`ID_USER`),
  KEY `ID_MNG_fk` (`ID_MNG`),
  CONSTRAINT `ID_MNG_fk` FOREIGN KEY (`ID_MNG`) REFERENCES `managers` (`ID_MNG`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'THANG TRINH','12341235',NULL,'TRINHVANTHANG@GMAIL.COM',2),(2,'HOAI AN','12356789',NULL,'HOAIAN@GMAIL.COM',1),(3,'NGUYEN NAM','12345676','NGUYEN NAM ','NGUYENNAM@GMAIL.COM',4),(4,'DUNG NGUYEN','45678453','DUNG CHERRY','DUNGNGUYEN@GMAIL.COM',3),(5,'HOAN ANH TUAN','66668888','TUAN ANH HOANG','TUANANH@GMAIL.COM',1),(6,'NGUYEN HAI ANH','11112222',NULL,NULL,2),(7,'TRINH LONG','22221111',NULL,NULL,1),(8,'NGUYEN LONG','1111',NULL,'NGUYENLONG@GMAIL.COM',3),(9,'TRUONG THU THAO','88889999',NULL,NULL,1),(10,'LINH ANH','11116666','ANH BLACKPINK',NULL,4),(11,'THANG TRINH','12341235',NULL,'TRINHVANTHANG@GMAIL.COM',2),(12,'HOAI AN','12356789',NULL,'HOAIAN@GMAIL.COM',1),(13,'NGUYEN NAM','12345676','NGUYEN NAM ','NGUYENNAM@GMAIL.COM',4),(14,'DUNG NGUYEN','45678453','DUNG CHERRY','DUNGNGUYEN@GMAIL.COM',3),(15,'HOAN ANH TUAN','66668888','TUAN ANH HOANG','TUANANH@GMAIL.COM',1),(16,'NGUYEN HAI ANH','11112222',NULL,NULL,2),(17,'TRINH LONG','22221111',NULL,NULL,1),(18,'NGUYEN LONG','1111',NULL,'NGUYENLONG@GMAIL.COM',3),(19,'TRUONG THU THAO','88889999',NULL,NULL,1),(20,'LINH ANH','11116666','ANH BLACKPINK',NULL,4),(21,'THANG TRINH','12341235',NULL,'TRINHVANTHANG@GMAIL.COM',2),(22,'HOAI AN','12356789',NULL,'HOAIAN@GMAIL.COM',1),(23,'NGUYEN NAM','12345676','NGUYEN NAM ','NGUYENNAM@GMAIL.COM',4),(24,'DUNG NGUYEN','45678453','DUNG CHERRY','DUNGNGUYEN@GMAIL.COM',3),(25,'HOAN ANH TUAN','66668888','TUAN ANH HOANG','TUANANH@GMAIL.COM',1),(26,'NGUYEN HAI ANH','11112222',NULL,NULL,2),(27,'TRINH LONG','22221111',NULL,NULL,1),(28,'NGUYEN LONG','1111',NULL,'NGUYENLONG@GMAIL.COM',3),(29,'TRUONG THU THAO','88889999',NULL,NULL,1),(30,'LINH ANH','11116666','ANH BLACKPINK',NULL,4),(31,'THANG TRINH','12341235',NULL,'TRINHVANTHANG@GMAIL.COM',2),(32,'HOAI AN','12356789',NULL,'HOAIAN@GMAIL.COM',1),(33,'NGUYEN NAM','12345676','NGUYEN NAM ','NGUYENNAM@GMAIL.COM',4),(34,'DUNG NGUYEN','45678453','DUNG CHERRY','DUNGNGUYEN@GMAIL.COM',3),(35,'HOAN ANH TUAN','66668888','TUAN ANH HOANG','TUANANH@GMAIL.COM',1),(36,'NGUYEN HAI ANH','11112222',NULL,NULL,2),(37,'TRINH LONG','22221111',NULL,NULL,1),(38,'NGUYEN LONG','1111',NULL,'NGUYENLONG@GMAIL.COM',3),(39,'TRUONG THU THAO','88889999',NULL,NULL,1),(40,'LINH ANH','11116666','ANH BLACKPINK',NULL,4);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `verified_post`
--

DROP TABLE IF EXISTS `verified_post`;
/*!50001 DROP VIEW IF EXISTS `verified_post`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `verified_post` AS SELECT 
 1 AS `ID_POST`,
 1 AS `TIEU_DE`,
 1 AS `NOI_DUNG`,
 1 AS `IMAGEs`,
 1 AS `TAC_GIA`,
 1 AS `LUOT_XEM`,
 1 AS `NGUOI_DUYET`,
 1 AS `thoi_gian_dang`,
 1 AS `xet_duyet`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP FUNCTION IF EXISTS `max_month` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `max_month`() RETURNS int
begin
    declare res int;
    select timestampdiff(month,min(thoi_gian_dang),'2019-01-01') from post into res;
    return res;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_unverified_post_before` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_unverified_post_before`()
begin
    select * from post 
    where xet_Duyet = 0 and thoi_gian_dang < '2018-02-01';
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_verified_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_verified_post`()
begin
    select * from post 
    where xet_duyet = 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `get_comment`
--

/*!50001 DROP VIEW IF EXISTS `get_comment`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `get_comment` AS select `comment`.`ID_COMMENT` AS `ID_COMMENT`,`comment`.`NGUOI_COMMENT` AS `NGUOI_COMMENT`,`comment`.`time_comment` AS `time_comment`,`comment`.`noi_dung` AS `noi_dung` from `comment` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `verified_post`
--

/*!50001 DROP VIEW IF EXISTS `verified_post`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `verified_post` AS select `post`.`ID_POST` AS `ID_POST`,`post`.`TIEU_DE` AS `TIEU_DE`,`post`.`NOI_DUNG` AS `NOI_DUNG`,`post`.`IMAGEs` AS `IMAGEs`,`post`.`TAC_GIA` AS `TAC_GIA`,`post`.`LUOT_XEM` AS `LUOT_XEM`,`post`.`NGUOI_DUYET` AS `NGUOI_DUYET`,`post`.`thoi_gian_dang` AS `thoi_gian_dang`,`post`.`xet_duyet` AS `xet_duyet` from `post` where (`post`.`xet_duyet` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-15  0:22:21
