-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: p2pfinal
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `collateral`
--

DROP TABLE IF EXISTS `collateral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collateral` (
  `collateral_id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`collateral_id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `collateral_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collateral`
--

LOCK TABLES `collateral` WRITE;
/*!40000 ALTER TABLE `collateral` DISABLE KEYS */;
/*!40000 ALTER TABLE `collateral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credithistory`
--

DROP TABLE IF EXISTS `credithistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credithistory` (
  `credit_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `credit_score` int DEFAULT NULL,
  `total_loans` int DEFAULT NULL,
  `defaults` int DEFAULT NULL,
  `last_default_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`credit_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `credithistory_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `credithistory_chk_1` CHECK ((`credit_score` between 300 and 850))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credithistory`
--

LOCK TABLES `credithistory` WRITE;
/*!40000 ALTER TABLE `credithistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `credithistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `investments`
--

DROP TABLE IF EXISTS `investments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `investments` (
  `investment_id` int NOT NULL AUTO_INCREMENT,
  `investor_id` int DEFAULT NULL,
  `loan_id` int DEFAULT NULL,
  `investment_amount` decimal(10,2) NOT NULL,
  `investment_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`investment_id`),
  KEY `investor_id` (`investor_id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `investments_ibfk_1` FOREIGN KEY (`investor_id`) REFERENCES `investors` (`investor_id`),
  CONSTRAINT `investments_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investments`
--

LOCK TABLES `investments` WRITE;
/*!40000 ALTER TABLE `investments` DISABLE KEYS */;
/*!40000 ALTER TABLE `investments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `investors`
--

DROP TABLE IF EXISTS `investors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `investors` (
  `investor_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`investor_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investors`
--

LOCK TABLES `investors` WRITE;
/*!40000 ALTER TABLE `investors` DISABLE KEYS */;
/*!40000 ALTER TABLE `investors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loanapplications`
--

DROP TABLE IF EXISTS `loanapplications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loanapplications` (
  `application_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `amount_requested` decimal(10,2) NOT NULL,
  `term_months` int NOT NULL,
  `purpose_id` int DEFAULT NULL,
  `status` enum('Submitted','Under Review','Approved','Rejected') DEFAULT 'Submitted',
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`application_id`),
  KEY `user_id` (`user_id`),
  KEY `purpose_id` (`purpose_id`),
  CONSTRAINT `loanapplications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `loanapplications_ibfk_2` FOREIGN KEY (`purpose_id`) REFERENCES `loanpurpose` (`purpose_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loanapplications`
--

LOCK TABLES `loanapplications` WRITE;
/*!40000 ALTER TABLE `loanapplications` DISABLE KEYS */;
/*!40000 ALTER TABLE `loanapplications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loanpurpose`
--

DROP TABLE IF EXISTS `loanpurpose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loanpurpose` (
  `purpose_id` int NOT NULL AUTO_INCREMENT,
  `purpose_name` varchar(100) NOT NULL,
  `description` varchar(45) NOT NULL,
  PRIMARY KEY (`purpose_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loanpurpose`
--

LOCK TABLES `loanpurpose` WRITE;
/*!40000 ALTER TABLE `loanpurpose` DISABLE KEYS */;
/*!40000 ALTER TABLE `loanpurpose` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loans`
--

DROP TABLE IF EXISTS `loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loans` (
  `loan_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `loan_amount` decimal(10,2) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `term_months` int NOT NULL,
  `start_date` date NOT NULL,
  `loan_status` enum('Pending','Active','Closed','Defaulted') DEFAULT 'Pending',
  `purpose_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`loan_id`),
  KEY `user_id` (`user_id`),
  KEY `purpose_id` (`purpose_id`),
  CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `loans_ibfk_2` FOREIGN KEY (`purpose_id`) REFERENCES `loanpurpose` (`purpose_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loans`
--

LOCK TABLES `loans` WRITE;
/*!40000 ALTER TABLE `loans` DISABLE KEYS */;
/*!40000 ALTER TABLE `loans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int DEFAULT NULL,
  `payment_amount` decimal(10,2) NOT NULL,
  `payment_date` date NOT NULL,
  `status` enum('Paid','Pending','Overdue') DEFAULT 'Pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riskassessments`
--

DROP TABLE IF EXISTS `riskassessments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riskassessments` (
  `assessment_id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int DEFAULT NULL,
  `risk_score` int DEFAULT NULL,
  `risk_level` enum('Low','Medium','High') DEFAULT NULL,
  `assessment_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`assessment_id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `riskassessments_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`loan_id`),
  CONSTRAINT `riskassessments_chk_1` CHECK ((`risk_score` between 0 and 100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riskassessments`
--

LOCK TABLES `riskassessments` WRITE;
/*!40000 ALTER TABLE `riskassessments` DISABLE KEYS */;
/*!40000 ALTER TABLE `riskassessments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `loan_id` int DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_type` enum('Disbursement','Repayment','Penalty','Fee') NOT NULL,
  `transaction_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `user_id` (`user_id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'User_1','user1@example.com','1995-04-05','Other','2025-04-05 05:35:31'),(2,'User_2','user2@example.com','1997-04-05','Female','2025-04-05 05:35:31'),(3,'User_3','user3@example.com','1983-04-05','Female','2025-04-05 05:35:31'),(4,'User_4','user4@example.com','1999-04-05','Female','2025-04-05 05:35:31'),(5,'User_5','user5@example.com','1981-04-05','Female','2025-04-05 05:35:31'),(6,'User_6','user6@example.com','2003-04-05','Other','2025-04-05 05:35:31'),(7,'User_7','user7@example.com','2002-04-05','Female','2025-04-05 05:35:31'),(8,'User_8','user8@example.com','1983-04-05','Male','2025-04-05 05:35:31'),(9,'User_9','user9@example.com','1982-04-05','Male','2025-04-05 05:35:31'),(10,'User_10','user10@example.com','1989-04-05','Male','2025-04-05 05:35:31'),(11,'User_11','user11@example.com','2001-04-05','Other','2025-04-05 05:35:31'),(12,'User_12','user12@example.com','1997-04-05','Other','2025-04-05 05:35:31'),(13,'User_13','user13@example.com','2005-04-05','Other','2025-04-05 05:35:31'),(14,'User_14','user14@example.com','1993-04-05','Female','2025-04-05 05:35:31'),(15,'User_15','user15@example.com','1998-04-05','Other','2025-04-05 05:35:32'),(16,'User_16','user16@example.com','1995-04-05','Female','2025-04-05 05:35:32'),(17,'User_17','user17@example.com','2005-04-05','Male','2025-04-05 05:35:32'),(18,'User_18','user18@example.com','1979-04-05','Female','2025-04-05 05:35:32'),(19,'User_19','user19@example.com','1994-04-05','Male','2025-04-05 05:35:32'),(20,'User_20','user20@example.com','1979-04-05','Other','2025-04-05 05:35:32'),(21,'User_21','user21@example.com','2006-04-05','Male','2025-04-05 05:35:32'),(22,'User_22','user22@example.com','1997-04-05','Other','2025-04-05 05:35:32'),(23,'User_23','user23@example.com','2004-04-05','Male','2025-04-05 05:35:32'),(24,'User_24','user24@example.com','1978-04-05','Other','2025-04-05 05:35:32'),(25,'User_25','user25@example.com','1991-04-05','Other','2025-04-05 05:35:32'),(26,'User_26','user26@example.com','1985-04-05','Other','2025-04-05 05:35:32'),(27,'User_27','user27@example.com','1996-04-05','Other','2025-04-05 05:35:32'),(28,'User_28','user28@example.com','1989-04-05','Other','2025-04-05 05:35:32'),(29,'User_29','user29@example.com','1995-04-05','Female','2025-04-05 05:35:32'),(30,'User_30','user30@example.com','2007-04-05','Other','2025-04-05 05:35:32'),(31,'User_31','user31@example.com','1984-04-05','Female','2025-04-05 05:35:32'),(32,'User_32','user32@example.com','1986-04-05','Other','2025-04-05 05:35:32'),(33,'User_33','user33@example.com','1990-04-05','Other','2025-04-05 05:35:32'),(34,'User_34','user34@example.com','1985-04-05','Female','2025-04-05 05:35:32'),(35,'User_35','user35@example.com','1978-04-05','Male','2025-04-05 05:35:32'),(36,'User_36','user36@example.com','2002-04-05','Other','2025-04-05 05:35:32'),(37,'User_37','user37@example.com','1984-04-05','Male','2025-04-05 05:35:32'),(38,'User_38','user38@example.com','1981-04-05','Other','2025-04-05 05:35:32'),(39,'User_39','user39@example.com','1980-04-05','Female','2025-04-05 05:35:32'),(40,'User_40','user40@example.com','1992-04-05','Male','2025-04-05 05:35:32'),(41,'User_41','user41@example.com','1983-04-05','Male','2025-04-05 05:35:32'),(42,'User_42','user42@example.com','1982-04-05','Female','2025-04-05 05:35:32'),(43,'User_43','user43@example.com','1980-04-05','Male','2025-04-05 05:35:32'),(44,'User_44','user44@example.com','1987-04-05','Male','2025-04-05 05:35:32'),(45,'User_45','user45@example.com','1981-04-05','Other','2025-04-05 05:35:32'),(46,'User_46','user46@example.com','1998-04-05','Male','2025-04-05 05:35:32'),(47,'User_47','user47@example.com','1978-04-05','Female','2025-04-05 05:35:32'),(48,'User_48','user48@example.com','2005-04-05','Male','2025-04-05 05:35:32'),(49,'User_49','user49@example.com','1992-04-05','Male','2025-04-05 05:35:32'),(50,'User_50','user50@example.com','2001-04-05','Female','2025-04-05 05:35:32'),(51,'User_51','user51@example.com','1993-04-05','Female','2025-04-05 05:35:32'),(52,'User_52','user52@example.com','1993-04-05','Female','2025-04-05 05:35:32'),(53,'User_53','user53@example.com','1990-04-05','Male','2025-04-05 05:35:32'),(54,'User_54','user54@example.com','1982-04-05','Other','2025-04-05 05:35:32'),(55,'User_55','user55@example.com','2005-04-05','Female','2025-04-05 05:35:32'),(56,'User_56','user56@example.com','1981-04-05','Female','2025-04-05 05:35:32'),(57,'User_57','user57@example.com','1999-04-05','Female','2025-04-05 05:35:32'),(58,'User_58','user58@example.com','2000-04-05','Female','2025-04-05 05:35:32'),(59,'User_59','user59@example.com','1998-04-05','Female','2025-04-05 05:35:32'),(60,'User_60','user60@example.com','1979-04-05','Female','2025-04-05 05:35:32'),(61,'User_61','user61@example.com','2003-04-05','Other','2025-04-05 05:35:32'),(62,'User_62','user62@example.com','1992-04-05','Female','2025-04-05 05:35:32'),(63,'User_63','user63@example.com','2002-04-05','Female','2025-04-05 05:35:32'),(64,'User_64','user64@example.com','2003-04-05','Other','2025-04-05 05:35:32'),(65,'User_65','user65@example.com','2006-04-05','Male','2025-04-05 05:35:32'),(66,'User_66','user66@example.com','1980-04-05','Other','2025-04-05 05:35:32'),(67,'User_67','user67@example.com','1978-04-05','Male','2025-04-05 05:35:32'),(68,'User_68','user68@example.com','2003-04-05','Other','2025-04-05 05:35:32'),(69,'User_69','user69@example.com','1978-04-05','Other','2025-04-05 05:35:32'),(70,'User_70','user70@example.com','1987-04-05','Female','2025-04-05 05:35:32'),(71,'User_71','user71@example.com','1978-04-05','Male','2025-04-05 05:35:32'),(72,'User_72','user72@example.com','1989-04-05','Other','2025-04-05 05:35:32'),(73,'User_73','user73@example.com','1984-04-05','Other','2025-04-05 05:35:32'),(74,'User_74','user74@example.com','1999-04-05','Male','2025-04-05 05:35:32'),(75,'User_75','user75@example.com','1999-04-05','Other','2025-04-05 05:35:32'),(76,'User_76','user76@example.com','2005-04-05','Male','2025-04-05 05:35:32'),(77,'User_77','user77@example.com','1979-04-05','Other','2025-04-05 05:35:32'),(78,'User_78','user78@example.com','1990-04-05','Other','2025-04-05 05:35:32'),(79,'User_79','user79@example.com','2000-04-05','Other','2025-04-05 05:35:32'),(80,'User_80','user80@example.com','1993-04-05','Other','2025-04-05 05:35:32'),(81,'User_81','user81@example.com','1980-04-05','Male','2025-04-05 05:35:32'),(82,'User_82','user82@example.com','1997-04-05','Other','2025-04-05 05:35:32'),(83,'User_83','user83@example.com','1997-04-05','Other','2025-04-05 05:35:32'),(84,'User_84','user84@example.com','1989-04-05','Other','2025-04-05 05:35:32'),(85,'User_85','user85@example.com','2001-04-05','Other','2025-04-05 05:35:32'),(86,'User_86','user86@example.com','1985-04-05','Other','2025-04-05 05:35:32'),(87,'User_87','user87@example.com','1999-04-05','Male','2025-04-05 05:35:32'),(88,'User_88','user88@example.com','1994-04-05','Female','2025-04-05 05:35:32'),(89,'User_89','user89@example.com','2007-04-05','Female','2025-04-05 05:35:32'),(90,'User_90','user90@example.com','1978-04-05','Male','2025-04-05 05:35:32'),(91,'User_91','user91@example.com','1979-04-05','Male','2025-04-05 05:35:32'),(92,'User_92','user92@example.com','2003-04-05','Male','2025-04-05 05:35:32'),(93,'User_93','user93@example.com','1997-04-05','Male','2025-04-05 05:35:32'),(94,'User_94','user94@example.com','2005-04-05','Other','2025-04-05 05:35:32'),(95,'User_95','user95@example.com','1993-04-05','Male','2025-04-05 05:35:32'),(96,'User_96','user96@example.com','1986-04-05','Other','2025-04-05 05:35:32'),(97,'User_97','user97@example.com','1982-04-05','Other','2025-04-05 05:35:32'),(98,'User_98','user98@example.com','1979-04-05','Other','2025-04-05 05:35:32'),(99,'User_99','user99@example.com','2005-04-05','Female','2025-04-05 05:35:32'),(100,'User_100','user100@example.com','2005-04-05','Male','2025-04-05 05:35:32');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-12 16:38:30
