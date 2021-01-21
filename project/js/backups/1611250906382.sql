-- MariaDB dump 10.18  Distrib 10.5.8-MariaDB, for osx10.15 (x86_64)
--
-- Host: localhost    Database: wedel
-- ------------------------------------------------------
-- Server version	10.5.8-MariaDB

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
-- Table structure for table `candies`
--

DROP TABLE IF EXISTS `candies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `candies` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `producer` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `flavour` varchar(50) DEFAULT NULL,
  `mass` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `candies_ibfk_1` FOREIGN KEY (`id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candies`
--

LOCK TABLES `candies` WRITE;
/*!40000 ALTER TABLE `candies` DISABLE KEYS */;
INSERT INTO `candies` VALUES (1,'Kukułki','Wawel','nadziewane','karmelowe',120),(2,'Fistaszkowe','Wawel','twarde','orzechowe',120),(6,'Raczki','Wawel','nadziewane','karmelowe',120),(7,'Orzeźwiające','Wawel','nadziewane','karmelowe',120),(8,'Orzechowy SuperKruchy','Wawel','nadziewane','czekoladowe',1000),(9,'Ice Up','Argo','nadziewane','lodowe',1000),(10,'Mint Fresh Karmelki','Argo','nadziewane','miętowe',1000),(11,'Vita-MIX','Argo','nadziewane','owocowe',90),(12,'Michałki Hanka','Hanka z Siemianowic','zwykłe','czekoladowe z orzechami',2000);
/*!40000 ALTER TABLE `candies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chocolateBars`
--

DROP TABLE IF EXISTS `chocolateBars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chocolateBars` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `producer` varchar(50) DEFAULT NULL,
  `flavour` varchar(50) DEFAULT NULL,
  `mass` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `chocolatebars_ibfk_1` FOREIGN KEY (`id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chocolateBars`
--

LOCK TABLES `chocolateBars` WRITE;
/*!40000 ALTER TABLE `chocolateBars` DISABLE KEYS */;
INSERT INTO `chocolateBars` VALUES (4,'Snikers','Mars','czekoladowy',50),(13,'3BIT','3BIT company','czekoladowy',46),(14,'3BIT','3BIT company','czekoladowy z orzechami',46),(15,'Chocapic','Nestle','czekoladowy',25),(16,'Cini Minis','Nestle','mleczny',25),(17,'Nesquik','Nestle','mleczny',25),(18,'Daim','Nestle','karmelowy',28),(19,'Bounty','Nestle','kokosowy',57),(20,'Kinder Bueno','Kinder','czekolada mleczna',43),(21,'Kinder Bueno Białe','Kinder','czekolada biała',43),(22,'Kinder Maxi King','Kinder','mleczno - karmelowy',43),(23,'B-ready','Kinder','czekoladowy',22),(24,'Grześki','Goplana','czekoladowy',22);
/*!40000 ALTER TABLE `chocolateBars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chocolates`
--

DROP TABLE IF EXISTS `chocolates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chocolates` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `producer` varchar(50) DEFAULT NULL,
  `type` enum('bitter','milky','white') DEFAULT NULL,
  `flavour` varchar(50) DEFAULT NULL,
  `mass` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `chocolates_ibfk_1` FOREIGN KEY (`id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chocolates`
--

LOCK TABLES `chocolates` WRITE;
/*!40000 ALTER TABLE `chocolates` DISABLE KEYS */;
INSERT INTO `chocolates` VALUES (3,'Milka','Mondelez','milky','truskawkowa',400),(25,'CZekolada Mleczna Goplana','Goplana','milky','czekoladowe',90),(26,'Czekolada Mleczna Goplana','Goplana','bitter','czekoladowe',90),(27,'Czekolada Krówka mleczna nadziewana','Goplana','bitter','mleczna',100),(28,'Czekolada Chilli Excellence','Lindt','bitter','chilli',100),(29,'Czekolada Chilli Excellence 70%','Lindt','bitter','kakao',100),(30,'Czekolada Chilli Excellence Milk','Lindt','milky','mleczna',100),(31,'Milka Bubbly White','Milka','white','biała',95),(32,'Milka Bubbly Cherry','Milka','milky','wiśniowa',95),(33,'Milka Bubbly Collage Fruit','Milka','milky','wiśniowa',93),(34,'Milka Daim','Milka','milky','karmelowa',100);
/*!40000 ALTER TABLE `chocolates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `clientId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `street_and_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`clientId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Mateusz','Miękinia','Letnia'),(2,'Piotrek','Legnica','Kibica');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jellyCandies`
--

DROP TABLE IF EXISTS `jellyCandies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jellyCandies` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `producer` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `flavour` varchar(50) DEFAULT NULL,
  `mass` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `jellycandies_ibfk_1` FOREIGN KEY (`id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jellyCandies`
--

LOCK TABLES `jellyCandies` WRITE;
/*!40000 ALTER TABLE `jellyCandies` DISABLE KEYS */;
INSERT INTO `jellyCandies` VALUES (5,'Misie','Haribo','misie','owocowwe',250),(35,'Roulette','Harino','mix','owocowe',120),(36,'Coca Cola','Haribo','cola','colacola',120),(37,'Lasso','Haribo','długie','owocowe',120),(38,'Smerfowe','Haribo','dropsy','owocowe',200),(39,'Frosche żaby','Haribo','dropsy','owocowe',1000),(40,'Cytrynki','Haribo','cytrynki','cytrynowe',200);
/*!40000 ALTER TABLE `jellyCandies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `mass` int(10) unsigned DEFAULT NULL,
  `type` enum('chocolate','candy','jelly candy','chocolate bar') DEFAULT NULL,
  `price` decimal(5,2) unsigned DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Kukułko',250,'candy',3.99,0),(2,'Fistaszki',250,'candy',3.99,0),(3,'Milka',400,'chocolate',2.99,0),(4,'Snikers',100,'chocolate bar',3.99,45),(5,'Misie',250,'jelly candy',3.99,0),(6,'Raczki',120,'candy',3.99,0),(7,'Orzeźwiające',120,'candy',3.99,0),(8,'Orzechowy SuperKruchy',1000,'candy',12.99,0),(9,'Ice Up',1000,'candy',14.39,0),(10,'Mint Fresh Karmelki',1000,'candy',14.39,0),(11,'Vita-MIX',90,'candy',2.49,0),(12,'Michałki Hanka',2000,'candy',29.99,0),(13,'3BIT',46,'chocolate bar',1.80,0),(14,'3BIT',46,'chocolate bar',1.76,0),(15,'Chocapic',25,'chocolate bar',1.42,0),(16,'Cini Minis',25,'chocolate bar',1.32,0),(17,'Nesquik',25,'chocolate bar',1.42,0),(18,'Daim',28,'chocolate bar',2.11,0),(19,'Bounty',57,'chocolate bar',2.59,0),(20,'Kinder Bueno',43,'chocolate bar',2.63,0),(21,'Kinder Bueno Białe',43,'chocolate bar',3.03,0),(22,'Kinder Maxi King',43,'chocolate bar',2.67,0),(23,'B-ready',22,'chocolate bar',1.75,0),(24,'Grześki',22,'chocolate bar',1.22,0),(25,'CZekolada Mleczna Goplana',90,'chocolate',3.49,0),(26,'Czekolada Mleczna Goplana',90,'chocolate',3.49,0),(27,'Czekolada Krówka mleczna nadziewana',100,'chocolate',4.39,0),(28,'Czekolada Chilli Excellence',100,'chocolate',10.44,0),(29,'Czekolada Chilli Excellence 70%',100,'chocolate',9.30,0),(30,'Czekolada Chilli Excellence Milk',100,'chocolate',10.44,0),(31,'Milka Bubbly White',95,'chocolate',3.79,0),(32,'Milka Bubbly Cherry',95,'chocolate',3.79,0),(33,'Milka Bubbly Collage Fruit',93,'chocolate',3.69,0),(34,'Milka Daim',100,'chocolate',3.69,0),(35,'Roulette',120,'jelly candy',4.50,0),(36,'Coca Cola',120,'jelly candy',4.50,0),(37,'Lasso',120,'jelly candy',4.33,0),(38,'Smerfowe',200,'jelly candy',4.50,0),(39,'Frosche żaby',1000,'jelly candy',31.99,0),(40,'Cytrynki',200,'jelly candy',5.99,0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales` (
  `saleId` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `clientId` int(11) DEFAULT NULL,
  `done` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`saleId`),
  KEY `clientId` (`clientId`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `clients` (`clientId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,'2021-01-17',1,1);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesInfo`
--

DROP TABLE IF EXISTS `salesInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL,
  `saleId` int(11) DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `saleId` (`saleId`),
  CONSTRAINT `salesinfo_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`),
  CONSTRAINT `salesinfo_ibfk_2` FOREIGN KEY (`saleId`) REFERENCES `sales` (`saleId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesInfo`
--

LOCK TABLES `salesInfo` WRITE;
/*!40000 ALTER TABLE `salesInfo` DISABLE KEYS */;
INSERT INTO `salesInfo` VALUES (1,4,1,5);
/*!40000 ALTER TABLE `salesInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliers` (
  `supplierId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `nip` char(10) DEFAULT NULL,
  PRIMARY KEY (`supplierId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'Prawa Fabryka Twixa','5842751979'),(2,'Lewa Fabryka Twixa','5842751979'),(3,'SłodkoMi','5842751979');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplies`
--

DROP TABLE IF EXISTS `supplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplies` (
  `supplyId` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `supplierId` int(11) DEFAULT NULL,
  `done` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`supplyId`),
  KEY `supplierId` (`supplierId`),
  CONSTRAINT `supplies_ibfk_1` FOREIGN KEY (`supplierId`) REFERENCES `suppliers` (`supplierId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplies`
--

LOCK TABLES `supplies` WRITE;
/*!40000 ALTER TABLE `supplies` DISABLE KEYS */;
INSERT INTO `supplies` VALUES (1,'2021-01-17',2,1),(2,'2021-01-21',1,0);
/*!40000 ALTER TABLE `supplies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliesInfo`
--

DROP TABLE IF EXISTS `suppliesInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliesInfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productId` int(11) DEFAULT NULL,
  `supplyId` int(11) DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `supplyId` (`supplyId`),
  CONSTRAINT `suppliesinfo_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`),
  CONSTRAINT `suppliesinfo_ibfk_2` FOREIGN KEY (`supplyId`) REFERENCES `supplies` (`supplyId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliesInfo`
--

LOCK TABLES `suppliesInfo` WRITE;
/*!40000 ALTER TABLE `suppliesInfo` DISABLE KEYS */;
INSERT INTO `suppliesInfo` VALUES (1,4,1,50),(2,4,2,50);
/*!40000 ALTER TABLE `suppliesInfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `login` varchar(50) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `type` enum('admin','manager','worker') DEFAULT NULL,
  PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','$2a$10$a8pDUpNmxuC95bGiG1TOzu7qy1iqe5sCGzPnAAMru17.f1LCwEujW','admin'),('admintest','$2a$10$9MU8e2e1kVbL3pE7iPYsRu07.Of1zE4D1SGmwEP85GYJ74yNKqqJu','admin'),('manager','$2a$10$PdJbDHiIoaNAlNfmW/BUCenUbM5CgW9OQbI.plMmQxBhsnmOiWHKO','manager'),('test','$2a$10$PxNboMy3yF72hzGfiFjCXu9r7Hprz2/okkCgbcHuj9JW5Z9klJ4Tm','admin'),('user','$2a$10$oxMgrKGW0KxpzikCH4KLuuX9AxTbVgHDk0.Ja4lVE/aUNAX.hMpmC','worker'),('worker','$2a$10$ZyEGMxKsdhgOPU2ysWBLFuw1VW4VZY9KIz.YewKzwqcm1yniyV0MW','worker');
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

-- Dump completed on 2021-01-21 18:41:46
