CREATE DATABASE  IF NOT EXISTS `jobsearchingdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jobsearchingdb`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
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
  `majoring_detail` longtext COLLATE utf8mb4_unicode_520_ci,
  `language_certificate` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `informatics_certificate` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `cv` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_candidate_idx` (`user_id`),
  CONSTRAINT `fk_user_candidate` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate`
--

LOCK TABLES `candidate` WRITE;
/*!40000 ALTER TABLE `candidate` DISABLE KEYS */;
INSERT INTO `candidate` VALUES (1,7,'Ngu','Ngáo','Công nghệ thông tin','cntt it web software java python spring embed link data','TOEIC 750','lmao','https://res.cloudinary.com/dxorabap0/image/upload/v1651925510/hx8wyaebm6088wpmsqsr.jpg',32),(6,10,'ngáo','ngu','Công nghệ thông tin','phone','TOEIC 750','','',41),(7,10,'ngáo + ngu','','Ngôn ngữ Anh',NULL,'','',NULL,42),(8,100,'','già','',NULL,'','',NULL,43),(10,NULL,'hài hước bro','ngu','',NULL,'','',NULL,45),(12,18,'ngu','ko thông minh','Ăn chơi nhảy múa',NULL,'','','',47),(13,46,'test update redirect to add','','',NULL,'','',NULL,46),(15,19,'ngu','ko thông minh','',NULL,'','','',52),(16,NULL,'','','',NULL,'','','',57),(18,8,'Ngu','Khôn','Dược phẩm',NULL,'IELTS 8.5','Không có','https://res.cloudinary.com/dxorabap0/image/upload/v1651817887/faldsrp4ofhonfeiygkn.jpg',63),(19,NULL,'','','',NULL,'','','',79),(20,NULL,'','','',NULL,'','','',80),(21,NULL,'','','',NULL,'','','',81),(22,12,'finaltestuv','finaltestuv','','','','','',83),(23,2,'Sáng tạo, ham học hỏi','lười','công nghệ thông tin','cntt it software hardware code java python spring django','IELTS 6.5','không có','',85),(24,NULL,'','','','it','','','',86);
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
  `employer_id` int NOT NULL,
  `user_id` int NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cmt_employer_idx` (`employer_id`),
  KEY `fk_cmt_user_idx` (`user_id`),
  CONSTRAINT `fk_cmt_employer` FOREIGN KEY (`employer_id`) REFERENCES `employer` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (46,10,32,'test date','2022-05-07 00:00:00'),(49,10,32,'nhin ne','2022-05-07 01:03:20'),(51,10,32,'dungcho','2022-05-07 09:33:58'),(52,10,41,'ungvientest1 cmt nè','2022-05-07 13:03:26'),(53,10,41,'cmt tét','2022-05-07 13:04:27'),(54,14,32,'huhu','2022-05-07 18:03:26'),(55,10,32,'ko biet dau','2022-05-07 18:27:17'),(56,10,32,'yêu microsoft','2022-05-07 19:53:14'),(57,21,32,'samsung dinh qua','2022-05-07 21:36:45'),(58,15,32,'cntt ou','2022-05-07 21:40:14'),(59,10,86,'ungvienmoi comment','2022-05-07 22:15:34'),(60,14,86,'ungvienmoi comment nè','2022-05-07 22:15:46');
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
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_company_idx` (`user_id`),
  CONSTRAINT `fk_user_company` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employer`
--

LOCK TABLES `employer` WRITE;
/*!40000 ALTER TABLE `employer` DISABLE KEYS */;
INSERT INTO `employer` VALUES (10,'Microsoft','Microsoft là một tập đoàn đa quốc gia của Hoa Kỳ','Redmond, Washington, Hoa Kỳ','support.microsoft.com/contactus','https://www.microsoft.com/vi-vn','software operating system',51),(14,'Công ty cổ phần Hạ tầng Viễn thông CMC Telecom','CMC Telecom là một trong 8 công ty thành viên của Tập đoàn Công nghệ CMC. Với gần 9 năm xây dựng, phát triển, CMC Telecom là công ty hạ tầng viễn thông nằm trong TOP 4 các công ty viễn thông hàng đầu Việt Nam. CMC Telecom là nhà cung cấp đầu tiên áp dụng công nghệ GPON và sở hữu hạ tầng truyền dẫn 100% cáp quang.','Tầng 11 tòa nhà CMC, Đường Duy Tân, Q. Cầu Giấy, TP. Hà Nội','Tầng 11 tòa nhà CMC, Đường Duy Tân, Q. Cầu Giấy, TP. Hà Nội','https://cmctelecom.vn/','telecom',34),(15,'Công ty TNHH Phương Nam Vina','Công ty Phương Nam Vina là doanh nghiệp uy tín với hơn 10 năm kinh nghiệm hoạt động trong lĩnh vực phần mềm website, thiết kế đồ họa, quảng cáo trực tuyến, thương mại điện tử. Đến với công ty chúng tôi, bạn sẽ được làm việc trong môi trường chuyên nghiệp, năng động, công việc ổn định, thu nhập cao và có cơ hội thăng tiến.','190 Bạch Đằng, Phường 24, Quận Bình Thạnh, TPHCM','190 Bạch Đằng, Phường 24, Quận Bình Thạnh, TPHCM','https://phuongnamvina.com','cntt it',49),(16,'GrabDelivery','Grab là một công ty công nghệ có trụ sở tại Singapore cung cấp các dịch vụ vận chuyển và đi lại bằng xe hơi tại Singapore và các quốc gia Đông Nam Á khác như Malaysia, Indonesia, Philippines, Việt Nam, Thái Lan, Myanmar và Campuchia. Wikipedia','Tòa nhà Mapletree Business Center, Số 1060 Đại lộ Nguyễn Văn Linh, Phường Tân Phong, Quận 7, Thành phố Hồ Chí Minh, Việt Nam','https://www.grab.com/vn/','https://www.grab.com/vn/','GrabTaxi; GrabCar; GrabBike; GrabHitch; Grab Food; GrabExpress; GrabPay;',16),(21,'Samsung Việt Nam','Samsung đi theo triết lý kinh doanh đơn giản: cống hiến tài năng và công nghệ của mình để tạo ra các sản phẩm và dịch vụ vượt trội đóng góp cho một xã hội toàn cầu tốt đẹp hơn. Để đạt được điều này, Samsung hết sức coi trọng con người và công nghệ của mình.','Số 2, đường Hải Triều, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh','+84-2839157310','https://www.samsung.com/vn/','phone tablet laptop cntt it',62),(23,'SpaceX','Tập đoàn Công nghệ Khai phá Không gian, viết tắt theo tiếng Anh SpaceX, là một công ty tư nhân Mỹ chuyên sản xuất tên lửa đẩy và tàu vũ trụ có trụ sở tại Hawthorne, California. Công ty được thành lập năm 2002 bởi Elon Musk, một trong những doanh nhân đã sáng lập công ty PayPal và Tesla Motors.','Hawthorne, California, Hoa Kỳ','https://twitter.com/SpaceX','https://www.spacex.com/','SpaceX Starship and Super Heavy Booster rocket SpaceX Starship prototype and Super Heavy Booster Falcon 9 rocket launching Starlink L-23 payload',66),(25,'n/a',NULL,NULL,NULL,NULL,NULL,75),(26,'n/a ne','','','','','',76),(29,'TikTok','TikTok là nền tảng video âm nhạc và mạng xã hội của Trung Quốc được ra mắt vào năm 2017, dành cho các thị trường bên ngoài Trung Quốc. bởi Trương Nhất Minh, người sáng lập của ByteDance.','Trung Quốc','ByteDance','https://www.tiktok.com/vi-VN/','media video clip tiktok short dance',87);
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
  `posted_by_user` int NOT NULL,
  `job_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_jpost_user_idx` (`posted_by_user`),
  KEY `fk_jpost_jtype_idx` (`job_type_id`),
  CONSTRAINT `fk_jpost_jtype` FOREIGN KEY (`job_type_id`) REFERENCES `job_type` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_jpost_user` FOREIGN KEY (`posted_by_user`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_post`
--

LOCK TABLES `job_post` WRITE;
/*!40000 ALTER TABLE `job_post` DISABLE KEYS */;
INSERT INTO `job_post` VALUES (25,'Pháp chế cho công ty luật','làm việc ko nghỉ',15000000,30000000,'Hà Nội','2022-05-05 00:00:00','2022-05-19 00:00:00',16,3),(30,'nhatuyendungtest date','nhatuyendungtest',123,1234,'nhatuyendungtest','2022-05-03 00:00:00','2022-05-19 00:00:00',51,13),(31,'sao ntn','sao ntn',123,1234,'sao ntn','2022-05-06 00:00:00','2022-05-31 00:00:00',51,15),(33,'Bán điện thoại','Tư vấn và bán hàng tại showroom Bitexco của Samsung',25000000,40000000,'2 Hải Triều, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh','2022-05-07 01:57:52',NULL,62,9),(34,'Bán hàng tại hiệu thuốc','8h/ngày',5000000,8000000,'Phú Nhuận, HCM','2022-05-06 00:00:00',NULL,49,9),(35,'Tài xế giao đồ ăn tại quận Bình Thạnh','giao đồ ăn',5000000,8000000,'Bình Thạnh','2022-05-07 02:12:28',NULL,16,14),(36,'CAD Drafter - Temporary Position','SpaceX was founded under the belief that a future where humanity is out exploring the stars is fundamentally more exciting than one where we are not. Today SpaceX is actively developing the technologies to make this possible, with the ultimate goal of enabling human life on Mars.',200000000,350000000,'Hoa Kỳ','2022-05-07 09:10:59',NULL,62,15),(37,'Bán cơm tấm','Bán buổi sáng trưa',3000000,4000000,'Gò Vấp','2022-05-07 11:51:52',NULL,16,14),(38,'Kỹ sư hàng không, tên lửa','Bảo trì tên lửa',150000000,200000000,'Hoa Kỳ','2022-05-07 19:51:07',NULL,66,19),(39,'Tiktoker','Review đồ ăn và upload lên Tiktok',7000000,12000000,'Toàn quốc','2022-05-07 22:04:09','2022-06-03 00:00:00',87,11);
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4,'admin','$2a$10$yobGID0c.PI/lVnHglCncey0TsjKUa/WMiUhImftHQCsPCEjCfGeC','','ROLE_ADMIN',0,NULL,'admin@gmail.com','014324325',NULL,0,NULL),(16,'tle115','$2a$10$epnfIs1WlRaj4k0GO8EWCObgQ.Y7RKrWt5fd56dJfJUN7XW4NY8iG','https://res.cloudinary.com/dxorabap0/image/upload/v1651835885/tad3sft0wskhbwbnjmuf.png','ROLE_NTD',1,'Lê Thị Thanh Thuỳ','lethuy01091997@gmail.com','0123456789','2000-05-11',1,'Bắc Kạn'),(19,'testfilepicker','$2a$10$arZn3WwASMPuCoD3ODh58.2kO1NcymbBedp2Ig6m8INcJvi76oT/G','https://res.cloudinary.com/dxorabap0/image/upload/v1651133332/utoiwv8cxue63w0ag3vt.webp','ROLE_ADMIN',1,'testfilepicker','testfilepicker','testfilepicker','2001-08-17',1,'Ea Súp'),(32,'ungvien1','$2a$10$16G2pK4Aq3BNFZMgfdfOAuXnPP6GoqSq6QENs/obTydBhj7/9BAv.','https://res.cloudinary.com/dxorabap0/image/upload/v1651647840/sabfg0rm32rm2voxgigm.jpg','ROLE_UV',1,'Ứng Viên 1','ungvien1@gmail.com','0123463573','1999-06-17',0,'Đà Nẵng'),(34,'nhatuyendung1','$2a$10$Ou5IFFxv2Xhq4Iqy9DP24O01OYIl03yXXQQ.5/sXhiqQhev/IbCRK','https://res.cloudinary.com/dxorabap0/image/upload/v1651837183/izbrvjvf4wnbqybhu5cd.png','ROLE_NTD',1,'Nhà Tuyển Dụng 1','nhatuyendung1@gmail.com','0543753475','1995-08-06',0,'Hưng Yên'),(41,'ungvien2','$2a$10$UQTK4lQY4afmqoHJj.DTpupZ16pZS58BG.BzjbwU4ukXOzdl/xfqm','https://res.cloudinary.com/dxorabap0/image/upload/v1651682182/vz1smubi4kvint0qznn2.jpg','ROLE_UV',1,'Ungvientest1','ungvientest1@gmail.com','053536546','2005-05-09',0,'Hà Nội'),(42,'ungvientest2','$2a$10$TWt2D3GovLXXvmmCNXfPZe2yip/B/cyrx.0ruKPs0/YrzqLCPtISe','https://res.cloudinary.com/dxorabap0/image/upload/v1651682408/tiyhyvj8ibp8z8gm0bxu.jpg','ROLE_UV',1,'Ungvientest2','ungvientest2@gmil.com','042352541','2002-08-19',0,'ungvientest2'),(43,'ungvientest3','$2a$10$lkN8q1upSPznhDM6d7n2WuG/kkTQksnXa61hoMgyodiB6dzPE2Z7q','https://res.cloudinary.com/dxorabap0/image/upload/v1651682671/t7uiktmeolsvy8o0iutj.jpg','ROLE_UV',1,'Ungvientest3','ungvientest3@gmail.com','0534587346','2000-03-04',1,'ungvientest3'),(45,'ungvientest4','$2a$10$lV/Qkf3e455XMeOavIlfR.B5ygX1s6vDZ6PdCcDjF3WWHrvbuV72S','https://res.cloudinary.com/dxorabap0/image/upload/v1651684357/jtf3cm9urse044selfrm.jpg','ROLE_UV',1,'Ungvientest4','ungvientest4@gmail.com','0583457834','2004-08-06',0,'ungvientest4'),(46,'ungvientest5','$2a$10$LzOPkaHFX73wbYwPga8J0uu58R/f0XUOdJHjELZ44TXbwDXEnCeRe','https://res.cloudinary.com/dxorabap0/image/upload/v1651684725/d51vstyy0mneok1kmd5b.jpg','ROLE_UV',1,'Ungvientest5','ungvientest5@gmail.com','0534543','2004-05-06',0,'ungvientest5'),(47,'ungvientest6','$2a$10$szCkJUO37e688rL0Sx1Ife9T.5PzDrVZ3M/JQ9Sz/DpGBA1q52M9q','https://res.cloudinary.com/dxorabap0/image/upload/v1651684859/ftkbetrrlbm7xpmefowu.jpg','ROLE_UV',1,'Ungvientest6','ungvientest6@gmail.com','0435374','2004-06-08',1,'ungvientest6'),(49,'nhatuyendung2','$2a$10$ikRZGxz3B/rpQMEXXvfSmOowZdbbMbLiBfuYey1gCDyS826VljZve','https://res.cloudinary.com/dxorabap0/image/upload/v1651837225/ojvvim2jmpflqgefxc7t.png','ROLE_NTD',1,'Nhatuyendung2','nhatuyendung2@gmail.com','075438534','1998-05-07',1,'nhatuyendung2'),(51,'nhatuyendungtest','$2a$10$nQXlbN/6wowMEyB7a6j7NOs2arFqvMHOVYJu5nQFPs3EgTLGdPU82','https://res.cloudinary.com/dxorabap0/image/upload/v1651837322/tslkce327ci4n33bakug.jpg','ROLE_NTD',1,'Nhatuyendungtest','nhatuyendungtest@gmail.com','053874543','1995-09-08',0,'nhatuyendungtest'),(52,'ungviencapnhat','$2a$10$Bbtnk/PlkaQmWux0ctppde29ciZ3EHwjBCCgZX5BtitMXzFyq2c5q','https://res.cloudinary.com/dxorabap0/image/upload/v1651773071/zelvv30vv4zigurrufxk.jpg','ROLE_UV',1,'Ungviencapnhat','ungviencapnhat@gmail.com','0435345435','2004-09-07',0,'ungviencapnhat'),(57,'ungvienresss','$2a$10$71WpOu/N/8D8tdsgWep.CeLOCOSKJi5ZLIgtq/D7eF6d/zJqkKkhW','https://res.cloudinary.com/dxorabap0/image/upload/v1651814778/uvn41eskld6pu5r3r7ic.jpg','ROLE_UV',1,'Ungvienresss','ungvienresss@gmail.com','0543785654','2004-07-08',0,'ungvienresss'),(62,'nhatuyendung','$2a$10$JOVb93BfJMvHrJunn7aJdeZjVrChfDmuEOTMTUIrVR2r0eJv.3zJW','https://res.cloudinary.com/dxorabap0/image/upload/v1651837336/v0uuuznv4ncflu3i8itl.webp','ROLE_NTD',1,'Nhatuyendung','nhatuyendung@gmail.com','057834785','2005-07-08',0,'nhatuyendung'),(63,'ungvien3','$2a$10$JSBClZweVaYQTIZ4u4oYSev2QKADRrJky1qJkF4BfoVKymZByxL1q','https://res.cloudinary.com/dxorabap0/image/upload/v1651817853/jhbkgthrzsstknrkqhgv.jpg','ROLE_UV',1,'Ungvien11','ungvien3@gmail.com','05347867','1986-06-18',1,'ungvien11'),(66,'spacex_elonmusk','$2a$10$mAaju0LrTWt4zkDwXjTUc.CBcBveFFpvr/4J2U9cfrxzDw17VAn86','https://res.cloudinary.com/dxorabap0/image/upload/v1651888409/ly3ymky09bwbqhxzuvso.jpg','ROLE_NTD',1,'Spacex Elon Musk','spacex_elon@gmail.com','017437534','2002-03-14',0,'Hawthorne, California, Hoa Kỳ'),(75,'bamcailuuluon','$2a$10$3SM87OSTltc9RnP6NcqqSO7rtBUottCzEFA72MwaNg33pxNJV/G2O','https://res.cloudinary.com/dxorabap0/image/upload/v1651891143/mu84jtmnbmvilpqrmhfh.jpg','ROLE_NTD',1,'Bamcailuuluon','bamcailuuluon@gmail.com','0684856323','1978-05-06',0,'bamcailuuluon'),(76,'luucaintd','$2a$10$uChs7ALHE32YETSPuXWxvugJJBNGtj5HwfmzrzUq8k2tXXimxUEf.','https://res.cloudinary.com/dxorabap0/image/upload/v1651891765/obu8fjd4btkuzxjbtn1m.jpg','ROLE_NTD',1,'Luucaintd','luucaintd@gmail.com','035834538','2004-06-08',0,'luucaintd'),(79,'ungvienhuhu','$2a$10$BNkEA1zE5YCt6bRkESCyWuDXeCKDhjCTnVtAZWfepM02oOxTJyJde','https://res.cloudinary.com/dxorabap0/image/upload/v1651892422/spdawkffcjwfcy7pt6yj.jpg','ROLE_UV',1,'Ungvienhuhu','ungvienhuhu@gmail.com','058467465','2004-06-08',0,'ungvienhuhu'),(80,'dangkycaiuv','$2a$10$nJ9t9KbdKT6r531/MMf3zux0JUj6EcGzUqBVf0TObP7q51YFDgj8q','https://res.cloudinary.com/dxorabap0/image/upload/v1651894460/tj6xhoj6gtdiqmuhbezi.jpg','ROLE_UV',1,'Dangkycaiuv','dangkycaiuv@gmail.com','058734785','1998-06-27',0,'dangkycaiuv'),(81,'testflowdangky','$2a$10$GMA74rbasxo1sLJ4fQ5lT.Qw0V78egzn1Yibf1tjTWwH94mtgOBP2','https://res.cloudinary.com/dxorabap0/image/upload/v1651894865/kvcdhxxmn60pdrr8edbc.jpg','ROLE_UV',1,'Testflowdangky','testflowdangky@gmail.com','05734754384','1986-11-12',0,'testflowdangky'),(83,'finaltestuv','$2a$10$2Z6dP9D1PUS0w2a1G1KwQeylnIK.UmGueOhbmEPw3g4tmCClGMdFi','https://res.cloudinary.com/dxorabap0/image/upload/v1651927028/cipa6uebnz1xlno37mgt.jpg','ROLE_UV',1,'Finaltestuv','finaltestuv@gmail.com','0437857834','1993-06-17',0,'finaltestuv'),(85,'ungviencntt','$2a$10$KcN.AuFG2zFotq5A8U4bgeD9GaRitj2LGfSz2wPAY1V88hHI2sQfq','https://res.cloudinary.com/dxorabap0/image/upload/v1651931721/zioicg8vmtypkzzlhthy.png','ROLE_UV',1,'Ứng Viên Cntt','ungviencntt@gmail.com','0123432564','1998-05-06',0,'Vũng Tàu'),(86,'ungvienmoi','$2a$10$F8T1kVUeOQWvBQzWuomoYOCWS0Ot7Za2vWe1ZeUWn4cZSXtjyeMzS','https://res.cloudinary.com/dxorabap0/image/upload/v1651935230/jm8v4gjzcs5r6qymt1ps.png','ROLE_UV',1,'Ungvienmoi','ungvienmoi@gmail.com','0432785783','2005-08-16',1,'ungvienmoi'),(87,'tuyendungmoi','$2a$10$qN1IlkfMRwzm3xQ8qmDSzONlBHynBI57SfFVYb3c6P.7PO9voLJcm','https://res.cloudinary.com/dxorabap0/image/upload/v1651935625/ucaj5ifwxmrq1lkprhem.png','ROLE_NTD',1,'Tuyendungmoi','tuyendungmoi@gmail.com','05787847645','1995-06-27',1,'tuyendungmoi');
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

-- Dump completed on 2022-05-07 22:16:44
