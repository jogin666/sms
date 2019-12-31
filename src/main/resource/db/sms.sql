-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: smss
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `complain`
--

DROP TABLE IF EXISTS `complain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `complain` (
  `comp_id` varchar(32) NOT NULL,
  `id` varchar(32) DEFAULT NULL,
  `comp_dept` varchar(100) DEFAULT NULL,
  `comp_name` varchar(20) DEFAULT NULL,
  `comp_moblie` char(11) DEFAULT NULL,
  `is_NM` char(1) DEFAULT NULL,
  `comp_title` varchar(200) DEFAULT NULL,
  `comp_time` timestamp NULL DEFAULT NULL,
  `to_comp_name` varchar(20) DEFAULT NULL,
  `to_comp_dept` char(100) DEFAULT NULL,
  `comp_content` varchar(500) DEFAULT NULL,
  `state` char(1) DEFAULT NULL,
  PRIMARY KEY (`comp_id`),
  KEY `FK_Complain_idx` (`id`),
  CONSTRAINT `FK_Complain_User` FOREIGN KEY (`id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complain`
--

LOCK TABLES `complain` WRITE;
/*!40000 ALTER TABLE `complain` DISABLE KEYS */;
INSERT INTO `complain` VALUES ('1','20161113032','工学部','zy','13245678912','1','测试1','2019-04-25 10:23:14','cb','工学部','第一次测试','1'),('2','20161113032','工学部','zy','12345678998','0','测试2','2019-04-25 10:35:25','thq','工学部','第二次测试','1'),('2c9a2d616a5db3d2016a5db5024c0000',NULL,'工学部','zy','13457760487','0','测试3','2019-04-27 07:31:43','jcl','工学部','第三次测试','1'),('2c9a2d616a819f35016a81a150860000',NULL,'工学部','zy','13457760487','0','测试4','2019-05-04 06:56:34','cb','工学部','第四次测试','1'),('2c9a2d616a8237c6016a823946ca0000',NULL,'工学部','zy','13457760487','1','投诉测试','2019-05-04 09:42:33','hyt','体育部','投诉测试','1'),('2c9a2d616a9583a4016a958491f40000',NULL,'工学部','zy','13457760487','0','测试3','2019-05-08 03:37:34','cc','工学部','做后测试！','1'),('2c9a2d616ad828fa016ad82cd2900000',NULL,'工学部','zy','13457760487','0','测试10','2019-05-21 02:16:17','thq','工学部','第十个测试','1'),('2c9a2d616add4c0f016add8982a30000',NULL,'工学部','zy','13457760487','1','2','2019-05-22 03:15:38','lhg','工学部','12','0');
/*!40000 ALTER TABLE `complain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complain_reply`
--

DROP TABLE IF EXISTS `complain_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `complain_reply` (
  `reply_id` varchar(32) NOT NULL,
  `comp_id` varchar(32) DEFAULT NULL,
  `replyer` varchar(20) NOT NULL,
  `replyer_dept` varchar(30) DEFAULT NULL,
  `reply_time` timestamp NULL DEFAULT NULL,
  `reply_content` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`reply_id`),
  KEY `FK296pij5w6lguo8j9cy7hf90qa` (`comp_id`),
  CONSTRAINT `FK296pij5w6lguo8j9cy7hf90qa` FOREIGN KEY (`comp_id`) REFERENCES `complain` (`comp_id`),
  CONSTRAINT `FK_reply` FOREIGN KEY (`comp_id`) REFERENCES `complain` (`comp_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complain_reply`
--

LOCK TABLES `complain_reply` WRITE;
/*!40000 ALTER TABLE `complain_reply` DISABLE KEYS */;
INSERT INTO `complain_reply` VALUES ('1','1','cb','工学部','2019-04-26 09:48:00','测试测试'),('2c9a2d616a76603a016a766b26dd0002','2c9a2d616a5db3d2016a5db5024c0000',' zy',' 工学部','2019-05-02 02:40:26','检验测试1'),('2c9a2d616a76603a016a76725ce10003','2',' zy',' 工学部','2019-05-02 02:49:28','检验测试2'),('2c9a2d616a76603a016a7672db270004','2c9a2d616a5db3d2016a5db5024c0000',' zy',' 工学部','2019-05-02 02:50:00','检验测试3'),('2c9a2d616a76737a016a767502430000','2c9a2d616a5db3d2016a5db5024c0000',' zy',' 工学部','2019-05-02 02:52:19','检验测试'),('2c9a2d616a76737a016a76784a810001','2',' zy',' 工学部','2019-05-02 02:55:56','检验0\r\n'),('2c9a2d616a82133f016a822317a60008','1',' zy',' 工学部','2019-05-04 09:18:19','检验'),('2c9a2d616a8247e5016a824d634b0002','2c9a2d616a819f35016a81a150860000',' zy',' 工学部','2019-05-04 10:04:31','第四次测试'),('2c9a2d616a864687016a866638aa0000','2c9a2d616a8237c6016a823946ca0000',' zy',' 工学部','2019-05-05 05:10:07','测试'),('2c9a2d616ab967d2016ab979086f0000','1',' zy',' 工学部','2019-05-15 03:11:18',''),('2c9a2d616ab982f1016ab983faea0000','1',' zy',' 工学部','2019-05-15 03:23:16','检验。。。。。'),('2c9a2d616ab982f1016ab98667ab0001','2',' zy',' 工学部','2019-05-15 03:25:54','123'),('2c9a2d616ab9889d016ab989b8120000','2',' zy',' 工学部','2019-05-15 03:29:32','123'),('2c9a2d616ad828fa016ad84fbd550002','2c9a2d616a9583a4016a958491f40000',' zy',' 工学部','2019-05-21 02:54:26','5-21 再测试'),('2c9a2d616add4c0f016add8c22290001','2c9a2d616ad828fa016ad82cd2900000',' zy',' 工学部','2019-05-22 03:18:30','123');
/*!40000 ALTER TABLE `complain_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `course` (
  `course_id` varchar(32) NOT NULL,
  `course_name` varchar(30) DEFAULT NULL,
  `course_type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept`
--

DROP TABLE IF EXISTS `dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `dept` (
  `dept_id` varchar(32) NOT NULL,
  `dept_name` varchar(32) DEFAULT NULL,
  `dept_memo` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept`
--

LOCK TABLES `dept` WRITE;
/*!40000 ALTER TABLE `dept` DISABLE KEYS */;
INSERT INTO `dept` VALUES ('1','工学部',NULL),('2','文理学部',NULL),('3','体育部',NULL),('4','经济与管理学院',NULL);
/*!40000 ALTER TABLE `dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `info` (
  `info_id` varchar(32) NOT NULL,
  `dept_id` varchar(32) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `state` char(1) DEFAULT NULL,
  PRIMARY KEY (`info_id`),
  KEY `FK_publish` (`dept_id`),
  CONSTRAINT `FK_publish` FOREIGN KEY (`dept_id`) REFERENCES `dept` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
INSERT INTO `info` VALUES ('04','1','放假通知','工学部','五一放假安排','五一放四天假，星期三开始放！','zy','2019-05-01 06:26:00','1'),('2c9a2d616a731d45016a731ee73d0000',NULL,'通知公告','工学部','五一放假','五一放假','zy','2019-05-01 11:18:27','1'),('2c9a2d616a82133f016a821cfb0d0005',NULL,'通知公告','工学部','检修','五一大检修','zy','2019-05-04 09:11:01','1'),('2c9a2d616a82133f016a821ddd9b0006',NULL,'通知公告','工学部','用例','测试一下','zy','2019-05-04 09:12:26','0'),('2c9a2d616a8247e5016a824936ff0000',NULL,'通知公告','工学部','测试5','测试5。','zy','2019-05-04 09:59:46','0'),('2c9a2d616abb7e80016abb7f33c00000',NULL,'通知公告','工学部','用例','12','zy','2019-05-15 12:37:10','1');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `role` (
  `roleId` varchar(32) NOT NULL,
  `state` char(1) DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('1','1','管理员'),('2','1','教职工'),('3','1','学生');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_privilege`
--

DROP TABLE IF EXISTS `role_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `role_privilege` (
  `code` varchar(255) NOT NULL,
  `roleId` varchar(32) NOT NULL,
  PRIMARY KEY (`roleId`,`code`),
  KEY `FK_Role_Privilege` (`roleId`),
  CONSTRAINT `FK_possess` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleid`),
  CONSTRAINT `FKy4mfaobs8hxt5o1skv3ygtp0` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_privilege`
--

LOCK TABLES `role_privilege` WRITE;
/*!40000 ALTER TABLE `role_privilege` DISABLE KEYS */;
INSERT INTO `role_privilege` VALUES ('OA办公','1'),('在线学习','1'),('我的空间','1'),('教务系统','1'),('教师办公','1'),('管理员办公','1'),('OA办公','2'),('在线学习','2'),('我的空间','2'),('教务系统','2'),('教师办公','2'),('OA办公','3'),('在学校学习','3'),('我的空间','3');
/*!40000 ALTER TABLE `role_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `selecourse`
--

DROP TABLE IF EXISTS `selecourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `selecourse` (
  `course_id` varchar(32) NOT NULL,
  `id` varchar(32) NOT NULL,
  `grace` decimal(3,0) DEFAULT NULL,
  `course_date` date DEFAULT NULL,
  `account` varchar(11) NOT NULL,
  PRIMARY KEY (`course_id`,`id`),
  KEY `FK_Sele_Course2_idx` (`id`),
  CONSTRAINT `FK_Sele_Course1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  CONSTRAINT `FK_Sele_Course2` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `selecourse`
--

LOCK TABLES `selecourse` WRITE;
/*!40000 ALTER TABLE `selecourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `selecourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teach`
--

DROP TABLE IF EXISTS `teach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `teach` (
  `id` varchar(32) NOT NULL,
  `course_id` varchar(32) NOT NULL,
  `tea_date` date DEFAULT NULL,
  `account` varchar(11) NOT NULL,
  PRIMARY KEY (`id`,`course_id`),
  KEY `FK_Teach2_idx` (`course_id`),
  CONSTRAINT `FK_Teach1` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_Teach2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teach`
--

LOCK TABLES `teach` WRITE;
/*!40000 ALTER TABLE `teach` DISABLE KEYS */;
/*!40000 ALTER TABLE `teach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `test` (
  `id` varchar(32) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES ('2c9a2d616a34fbef016a34fc73380000','小芳',19);
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` varchar(32) NOT NULL,
  `dept_id` varchar(32) DEFAULT NULL,
  `account` varchar(11) NOT NULL,
  `password` varchar(20) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `headImg` varchar(150) DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `brithday` date DEFAULT NULL,
  `state` char(1) DEFAULT NULL,
  `dept_name` varchar(32) DEFAULT NULL,
  `memo` varchar(500) DEFAULT NULL,
  `className` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_belong` (`dept_id`),
  CONSTRAINT `FK_belong` FOREIGN KEY (`dept_id`) REFERENCES `dept` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('20161113001',NULL,'20161113001','123456','lhg','','男','user1@test.com','12345678912','1997-10-16','1','工学部','','16软工A1'),('20161113002',NULL,'20161113002','123456','xjy','','男','user2@test.com','13457700000','1997-10-16','1','工学部','','16软工A2'),('20161113017',NULL,'20161113017','123456','jy','upload/user/114446e43aad4a6f8b5a0f46c278886502.jpg','男','user5@test.com','13457700000','1997-10-16','1','文理学部',NULL,'16教育A2'),('20161113021',NULL,'20161113021','123456','szc','','女','user2@test.com','13888888888','1997-10-16','1','工学部','','16软工A1'),('20161113032','1','20161113032','123456','zy','upload/user/95fbd6f00db94b7a8a2e821a3310a7cc02.jpg','男','user3@test.com','13457760487','1997-10-16','1','工学部',NULL,'16软工A1'),('20161113037',NULL,'20161113037','123456','thq','','男','','17621603654','1997-10-16','1','工学部','','16软工A1'),('20161113120',NULL,'20161113120','123456','cb','upload/user/519fac9b714f4111b87c5e9b4598fb7e02.jpg','男','user1@test.com','13888888888','1997-10-16','1','工学部','','16软工A1'),('20161113122',NULL,'20161113122','123456','hyt','','女','user3@test.com','13888888888','1997-10-16','1','体育部',NULL,'16软工A1');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_role` (
  `id` varchar(32) NOT NULL,
  `roleId` varchar(32) NOT NULL,
  PRIMARY KEY (`id`,`roleId`),
  KEY `FK_User_Role3_idx` (`roleId`),
  CONSTRAINT `FK_User_Role2` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_User_Role3` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKfjlagks6xvf2uas035crflu75` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES ('20161113002','1'),('20161113032','1'),('20161113002','2'),('20161113001','3'),('20161113017','3'),('20161113021','3'),('20161113032','3'),('20161113037','3'),('20161113120','3'),('20161113122','3');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'smss'
--

--
-- Dumping routines for database 'smss'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-31 23:12:33
