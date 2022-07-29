CREATE DATABASE  IF NOT EXISTS `jobsearchingdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jobsearchingdb`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: jobsearchingdb
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `apply_job`
--

DROP TABLE IF EXISTS `apply_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apply_job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `candidate_user_id` int NOT NULL,
  `job_id` int NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_job_idx` (`job_id`),
  KEY `fk_candidate_user_idx` (`candidate_user_id`),
  CONSTRAINT `fk_apply_job` FOREIGN KEY (`job_id`) REFERENCES `job_post` (`id`),
  CONSTRAINT `fk_candidate_user` FOREIGN KEY (`candidate_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apply_job`
--

LOCK TABLES `apply_job` WRITE;
/*!40000 ALTER TABLE `apply_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `apply_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate`
--

DROP TABLE IF EXISTS `candidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `years_experience` int DEFAULT NULL,
  `strengths` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `weaknesses` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `majoring` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `majoring_detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `language_certificate` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `informatics_certificate` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `cv` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate`
--

LOCK TABLES `candidate` WRITE;
/*!40000 ALTER TABLE `candidate` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employer_user_id` int NOT NULL,
  `candidate_user_id` int NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cmt_employer_idx` (`employer_user_id`),
  KEY `fk_cmt_user_idx` (`candidate_user_id`),
  CONSTRAINT `fk_cmt_candidate` FOREIGN KEY (`candidate_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_cmt_employer` FOREIGN KEY (`employer_user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employer`
--

DROP TABLE IF EXISTS `employer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `location` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `contact` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `website` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `majoring` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employer`
--

LOCK TABLES `employer` WRITE;
/*!40000 ALTER TABLE `employer` DISABLE KEYS */;
INSERT INTO `employer` VALUES (1,'Microsoft','Microsoft là một tập đoàn đa quốc gia của Hoa Kỳ','Redmond, Washington, Hoa Kỳ','support.microsoft.com/contactus','https://www.microsoft.com/vi-vn','software operating system'),(2,'Công ty cổ phần Hạ tầng Viễn thông CMC Telecom','CMC Telecom là một trong 8 công ty thành viên của Tập đoàn Công nghệ CMC. Với gần 9 năm xây dựng, phát triển, CMC Telecom là công ty hạ tầng viễn thông nằm trong TOP 4 các công ty viễn thông hàng đầu Việt Nam. CMC Telecom là nhà cung cấp đầu tiên áp dụng công nghệ GPON và sở hữu hạ tầng truyền dẫn 100% cáp quang.','Tầng 11 tòa nhà CMC, Đường Duy Tân, Q. Cầu Giấy, TP. Hà Nội','Tầng 11 tòa nhà CMC, Đường Duy Tân, Q. Cầu Giấy, TP. Hà Nội','https://cmctelecom.vn/','telecom'),(3,'Công ty TNHH Phương Nam Vina','Công ty Phương Nam Vina là doanh nghiệp uy tín với hơn 10 năm kinh nghiệm hoạt động trong lĩnh vực phần mềm website, thiết kế đồ họa, quảng cáo trực tuyến, thương mại điện tử. Đến với công ty chúng tôi, bạn sẽ được làm việc trong môi trường chuyên nghiệp, năng động, công việc ổn định, thu nhập cao và có cơ hội thăng tiến.','190 Bạch Đằng, Phường 24, Quận Bình Thạnh, TPHCM','190 Bạch Đằng, Phường 24, Quận Bình Thạnh, TPHCM','https://phuongnamvina.com','cntt it'),(4,'GrabDelivery','Grab là một công ty công nghệ có trụ sở tại Singapore cung cấp các dịch vụ vận chuyển và đi lại bằng xe hơi tại Singapore và các quốc gia Đông Nam Á khác như Malaysia, Indonesia, Philippines, Việt Nam, Thái Lan, Myanmar và Campuchia. Wikipedia','Tòa nhà Mapletree Business Center, Số 1060 Đại lộ Nguyễn Văn Linh, Phường Tân Phong, Quận 7, Thành phố Hồ Chí Minh, Việt Nam','https://www.grab.com/vn/','https://www.grab.com/vn/','GrabTaxi; GrabCar; GrabBike; GrabHitch; Grab Food; GrabExpress; GrabPay;'),(5,'Samsung Việt Nam','Samsung đi theo triết lý kinh doanh đơn giản: cống hiến tài năng và công nghệ của mình để tạo ra các sản phẩm và dịch vụ vượt trội đóng góp cho một xã hội toàn cầu tốt đẹp hơn. Để đạt được điều này, Samsung hết sức coi trọng con người và công nghệ của mình.','Số 2, đường Hải Triều, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh','+84-2839157310','https://www.samsung.com/vn/','phone tablet laptop cntt it'),(6,'SpaceX','Tập đoàn Công nghệ Khai phá Không gian, viết tắt theo tiếng Anh SpaceX, là một công ty tư nhân Mỹ chuyên sản xuất tên lửa đẩy và tàu vũ trụ có trụ sở tại Hawthorne, California. Công ty được thành lập năm 2002 bởi Elon Musk, một trong những doanh nhân đã sáng lập công ty PayPal và Tesla Motors.','Hawthorne, California, Hoa Kỳ','https://twitter.com/SpaceX','https://www.spacex.com/','SpaceX Starship and Super Heavy Booster rocket SpaceX Starship prototype and Super Heavy Booster Falcon 9 rocket launching Starlink L-23 payload'),(7,'TikTok','TikTok là nền tảng video âm nhạc và mạng xã hội của Trung Quốc được ra mắt vào năm 2017, dành cho các thị trường bên ngoài Trung Quốc. bởi Trương Nhất Minh, người sáng lập của ByteDance.','Trung Quốc','ByteDance','https://www.tiktok.com/vi-VN/','media video clip tiktok short dance');
/*!40000 ALTER TABLE `employer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_post`
--

DROP TABLE IF EXISTS `job_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `beginningSalary` decimal(10,0) NOT NULL,
  `endingSalary` decimal(10,0) NOT NULL,
  `location` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `expired_date` datetime DEFAULT NULL,
  `posted_by_employer_user` int NOT NULL,
  `job_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_jpost_user_idx` (`posted_by_employer_user`),
  KEY `fk_jpost_jtype_idx` (`job_type_id`),
  CONSTRAINT `fk_jpost_employer_user` FOREIGN KEY (`posted_by_employer_user`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_jpost_jtype` FOREIGN KEY (`job_type_id`) REFERENCES `job_type` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_post`
--

LOCK TABLES `job_post` WRITE;
/*!40000 ALTER TABLE `job_post` DISABLE KEYS */;
INSERT INTO `job_post` VALUES (25,'Pháp chế cho công ty luật','làm việc ko nghỉ',15000000,30000000,'Hà Nội','2022-05-05 00:00:00','2022-05-19 00:00:00',16,3),(30,'nhatuyendungtest date','nhatuyendungtest',123,1234,'nhatuyendungtest','2022-05-03 00:00:00','2022-05-19 00:00:00',51,13),(31,'sao ntn','sao ntn',123,1234,'sao ntn','2022-05-06 00:00:00','2022-05-31 00:00:00',51,15),(33,'Bán điện thoại','Tư vấn và bán hàng tại showroom Bitexco của Samsung',25000000,40000000,'2 Hải Triều, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh','2022-05-07 01:57:52',NULL,62,9),(34,'Bán hàng tại hiệu thuốc','8h/ngày',5000000,8000000,'Phú Nhuận, HCM','2022-05-06 00:00:00',NULL,49,9),(35,'Tài xế giao đồ ăn tại quận Bình Thạnh','giao đồ ăn',5000000,8000000,'Bình Thạnh','2022-05-07 02:12:28',NULL,16,14),(36,'CAD Drafter - Temporary Position','SpaceX was founded under the belief that a future where humanity is out exploring the stars is fundamentally more exciting than one where we are not. Today SpaceX is actively developing the technologies to make this possible, with the ultimate goal of enabling human life on Mars.',200000000,350000000,'Hoa Kỳ','2022-05-07 09:10:59',NULL,62,15),(37,'Bán cơm tấm','Bán buổi sáng trưa',3000000,4000000,'Gò Vấp','2022-05-07 11:51:52',NULL,16,14),(38,'Kỹ sư hàng không, tên lửa','Bảo trì tên lửa',150000000,200000000,'Hoa Kỳ','2022-05-07 19:51:07',NULL,66,19),(40,'Nhập sản phẩm lên Lazada','Nhập thông tin sản phẩm và upload lên sàn Lazada',2300000,3000000,'Online','2022-07-12 22:18:07','2022-07-16 00:00:00',62,14),(41,'Part-time tại KFC Nguyễn Gia Trí','Rán gà',4000000,6000000,'143 Nguyễn Gia Trí, Bình Thạnh, Hồ Chí Minh','2022-07-16 14:05:13','2022-07-22 00:00:00',62,14),(42,'con cac','con cac',3123213,2133435345,'Hà Nội','2022-07-16 17:29:27',NULL,62,1);
/*!40000 ALTER TABLE `job_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_type`
--

DROP TABLE IF EXISTS `job_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_type`
--

LOCK TABLES `job_type` WRITE;
/*!40000 ALTER TABLE `job_type` DISABLE KEYS */;
INSERT INTO `job_type` VALUES (1,'IT - Phần mềm'),(2,'Kế toán - Kiểm toán'),(3,'Luật'),(4,'Bảo hiểm'),(8,'Bất động sản'),(9,'Dược phẩm - Y tế - Công nghệ sinh học'),(10,'Internet - Online'),(11,'Marketing - Truyền thông - Quảng cáo'),(12,'Nhà hàng - Khách sạn'),(13,'In ấn - Xuất bản'),(14,'Bán lẻ - Hàng tiêu dùng'),(15,'Sản xuất'),(16,'Chứng khoán'),(17,'Xây dựng'),(18,'Logistics'),(19,'Kỹ sư hàng không');
/*!40000 ALTER TABLE `job_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `avatar` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `user_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '0',
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` tinyint DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `candidate_id` int DEFAULT NULL,
  `employer_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_candidate_idx` (`candidate_id`),
  KEY `fk_user_employer_idx` (`employer_id`),
  CONSTRAINT `fk_user_candidate` FOREIGN KEY (`candidate_id`) REFERENCES `candidate` (`id`),
  CONSTRAINT `fk_user_employer` FOREIGN KEY (`employer_id`) REFERENCES `employer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4,'admin','$2a$10$yobGID0c.PI/lVnHglCncey0TsjKUa/WMiUhImftHQCsPCEjCfGeC','','ROLE_ADMIN',0,NULL,'admin@gmail.com','014324325',NULL,0,NULL,NULL,NULL),(16,'tle115','$2a$10$epnfIs1WlRaj4k0GO8EWCObgQ.Y7RKrWt5fd56dJfJUN7XW4NY8iG','https://res.cloudinary.com/dxorabap0/image/upload/v1651835885/tad3sft0wskhbwbnjmuf.png','ROLE_NTD',1,'Lê Thị Thanh Thuỳ','lethuy01091997@gmail.com','0123456789','2000-05-11',1,'Bắc Kạn',NULL,2),(19,'testfilepicker','$2a$10$arZn3WwASMPuCoD3ODh58.2kO1NcymbBedp2Ig6m8INcJvi76oT/G','https://res.cloudinary.com/dxorabap0/image/upload/v1651133332/utoiwv8cxue63w0ag3vt.webp','ROLE_ADMIN',1,'testfilepicker','testfilepicker','testfilepicker','2001-08-17',1,'Ea Súp',NULL,NULL),(32,'ungvien1','$2a$10$16G2pK4Aq3BNFZMgfdfOAuXnPP6GoqSq6QENs/obTydBhj7/9BAv.','https://res.cloudinary.com/dxorabap0/image/upload/v1651647840/sabfg0rm32rm2voxgigm.jpg','ROLE_UV',1,'Ứng Viên 1','nguyenhoangn023@gmail.com','0123463573','1999-06-17',0,'Đà Nẵng',NULL,NULL),(34,'nhatuyendung1','$2a$10$Ou5IFFxv2Xhq4Iqy9DP24O01OYIl03yXXQQ.5/sXhiqQhev/IbCRK','https://res.cloudinary.com/dxorabap0/image/upload/v1651837183/izbrvjvf4wnbqybhu5cd.png','ROLE_NTD',1,'Nhà Tuyển Dụng 1','nhatuyendung1@gmail.com','0543753475','1995-08-06',0,'Hưng Yên',NULL,1),(41,'ungvien2','$2a$10$UQTK4lQY4afmqoHJj.DTpupZ16pZS58BG.BzjbwU4ukXOzdl/xfqm','https://res.cloudinary.com/dxorabap0/image/upload/v1651682182/vz1smubi4kvint0qznn2.jpg','ROLE_UV',1,'Ứng viên 2','ungvientest1@gmail.com','053536546','2005-05-09',0,'Hà Nội',NULL,NULL),(49,'nhatuyendung2','$2a$10$ikRZGxz3B/rpQMEXXvfSmOowZdbbMbLiBfuYey1gCDyS826VljZve','https://res.cloudinary.com/dxorabap0/image/upload/v1651837225/ojvvim2jmpflqgefxc7t.png','ROLE_NTD',1,'Nhatuyendung2','nhatuyendung2@gmail.com','075438534','1998-05-07',1,'nhatuyendung2',NULL,3),(51,'nhatuyendungtest','$2a$10$nQXlbN/6wowMEyB7a6j7NOs2arFqvMHOVYJu5nQFPs3EgTLGdPU82','https://res.cloudinary.com/dxorabap0/image/upload/v1651837322/tslkce327ci4n33bakug.jpg','ROLE_NTD',1,'Nhatuyendungtest','nhatuyendungtest@gmail.com','053874543','1995-09-08',0,'nhatuyendungtest',NULL,4),(62,'nhatuyendung','$2a$10$JOVb93BfJMvHrJunn7aJdeZjVrChfDmuEOTMTUIrVR2r0eJv.3zJW','https://res.cloudinary.com/dxorabap0/image/upload/v1651837336/v0uuuznv4ncflu3i8itl.webp','ROLE_NTD',1,'Nhatuyendung','nhatuyendung@gmail.com','057834785','2005-07-08',0,'nhatuyendung',NULL,5),(66,'spacex_elonmusk','$2a$10$mAaju0LrTWt4zkDwXjTUc.CBcBveFFpvr/4J2U9cfrxzDw17VAn86','https://res.cloudinary.com/dxorabap0/image/upload/v1651888409/ly3ymky09bwbqhxzuvso.jpg','ROLE_NTD',1,'Spacex Elon Musk','spacex_elon@gmail.com','017437534','2002-03-14',0,'Hawthorne, California, Hoa Kỳ',NULL,6),(75,'bamcailuuluon','$2a$10$3SM87OSTltc9RnP6NcqqSO7rtBUottCzEFA72MwaNg33pxNJV/G2O','https://res.cloudinary.com/dxorabap0/image/upload/v1651891143/mu84jtmnbmvilpqrmhfh.jpg','ROLE_NTD',1,'Bamcailuuluon','bamcailuuluon@gmail.com','0684856323','1978-05-06',0,'bamcailuuluon',NULL,7);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-29 16:37:43
