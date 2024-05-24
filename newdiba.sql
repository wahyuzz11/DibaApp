-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: newdiba
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.22-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addressbook`
--

DROP TABLE IF EXISTS `addressbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addressbook` (
  `id_users` varchar(16) NOT NULL,
  `account_number` varchar(10) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_users`,`account_number`),
  KEY `fk_users_has_savings_savings1_idx` (`account_number`),
  KEY `fk_users_has_savings_users1_idx` (`id_users`),
  CONSTRAINT `fk_users_has_savings_savings1` FOREIGN KEY (`account_number`) REFERENCES `savings` (`account_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_savings_users1` FOREIGN KEY (`id_users`) REFERENCES `users` (`nik`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbook`
--

LOCK TABLES `addressbook` WRITE;
/*!40000 ALTER TABLE `addressbook` DISABLE KEYS */;
INSERT INTO `addressbook` VALUES ('1234567891','20222123','gk tahu'),('1234567891','20222345','cantik :)'),('1234567891','20225678','test2'),('1234567891','20232111','dkaospksad'),('3456123478905674','20227891','basic'),('3456123478905674','20232111','test'),('89898989898998','20223456','Penghutang sementara'),('89898989898998','20232111','merchant'),('9878765654323456','20225678','test 1'),('9878765654323456','20232111','test 2');
/*!40000 ALTER TABLE `addressbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deposits`
--

DROP TABLE IF EXISTS `deposits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deposits` (
  `id_deposit` varchar(20) NOT NULL,
  `due_date` enum('1 Bulan','3 Bulan','6 Bulan','1 Tahun','2 Tahun','3 Tahun') NOT NULL,
  `nominal` double NOT NULL,
  `interest_rate` double NOT NULL,
  `status` enum('Unverified','Active','Closing','Closed') NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `account_number` varchar(10) NOT NULL,
  `open_verifikator` int(11) DEFAULT NULL,
  `close_verifikator` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_deposit`),
  KEY `fk_deposits_savings1_idx` (`account_number`),
  KEY `fk_deposits_employees1_idx` (`open_verifikator`),
  KEY `fk_deposits_employees2_idx` (`close_verifikator`),
  CONSTRAINT `fk_deposits_employees1` FOREIGN KEY (`open_verifikator`) REFERENCES `employees` (`id_employee`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_deposits_employees2` FOREIGN KEY (`close_verifikator`) REFERENCES `employees` (`id_employee`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_deposits_savings1` FOREIGN KEY (`account_number`) REFERENCES `savings` (`account_number`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deposits`
--

LOCK TABLES `deposits` WRITE;
/*!40000 ALTER TABLE `deposits` DISABLE KEYS */;
INSERT INTO `deposits` VALUES ('2022/12/9/3456/0001','1 Bulan',950000,0.03,'Closed','2022-12-16 16:00:07','2022-12-16 19:43:23','20223456',2,2),('2022/12/9/3456/0002','1 Bulan',952137.5,0.03,'Closed','2022-12-17 15:42:25','2022-12-17 16:37:13','20223456',2,2),('2022/12/9/3456/0003','1 Bulan',950000,0.03,'Closed','2022-12-17 19:48:19','2023-01-14 22:52:38','20223456',2,2),('2022/12/9/3456/0004','1 Bulan',1000000,3,'Active','2022-12-17 21:21:01','2023-01-14 22:52:20','20223456',2,NULL),('2022/12/9/3456/0005','1 Bulan',1000000,0.03,'Active','2022-12-17 21:58:49','2023-01-14 22:52:25','20223456',2,NULL),('2023/1/14/8998/0001','1 Bulan',950000,0.03,'Closed','2023-01-14 22:51:41','2023-01-14 22:55:18','20238998',2,2),('2023/1/16/5674/0001','1 Bulan',475000,0.03,'Closed','2023-01-16 14:40:06','2023-01-16 14:49:37','20235674',2,2),('2023/1/16/5674/0002','6 Bulan',450000,0,'Active','2023-01-16 14:47:56','2023-01-16 14:49:40','20235674',2,NULL);
/*!40000 ALTER TABLE `deposits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `id_employee` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `nik` varchar(16) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(128) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `id_position` int(11) NOT NULL,
  PRIMARY KEY (`id_employee`),
  KEY `fk_employees_positions1_idx` (`id_position`),
  CONSTRAINT `fk_employees_positions1` FOREIGN KEY (`id_position`) REFERENCES `positions` (`id_position`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Ratna','Ratih','0987655654343212','ratih@gmail.com','e59dde71355883670442a7573959afc1cf39669755e4dfefe87e9441b910c75d3a6d1c04cd196ee17906ffe512a0d46fface7560b64654650f7bfba455b3f318','2022-11-23 21:37:09','2022-11-23 22:01:39',2),(2,'Agus','Wibowo','0987876543323456','agus@gmail.com','386f483bbd4c67c7ebe912c6f17ea35d0098357bae5325daed7d970fed740262509d4548b0eddf5224856fc90ba9c545c0fcef2be694142e7a1d50a7bd0a4a72','2022-11-29 23:18:25','2022-12-09 14:15:58',1),(3,'john','cena','5643212567835514','john@gmail.com','b7fcc6e612145267d2ffea04be754a34128c1ed8133a09bfbbabd6afe6327688aa71d47343dd36e719f35f30fa79aec540e91b81c214fddfe0bedd53370df46d','2023-01-14 23:54:21','2023-01-14 23:54:21',1),(4,'Son ','Goku','123124124141313','son@gmail.com','6cb6a9482f68fe7049dbe8fb97dd49694f6dcd3dc79bc40fd7e86f9ae54fc4411aae6780d7fae2382116223256200370d5fb97dea51b127f6cfc49024a73ad35','2023-01-15 21:04:41','2023-01-15 21:04:41',1),(5,'Donald','Grump','565656512345','donald@yahoo.com','39818fb2d074d0f356392539d68b67afbc4e3768e78b6375936b63555c6928452dcc96e50aeefbf01a56a01d958ad518d29aa9b5c46a6162363cf2438eab5066','2023-01-16 14:12:32','2023-01-16 14:12:32',2);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inboxs`
--

DROP TABLE IF EXISTS `inboxs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inboxs` (
  `id_message` int(11) NOT NULL AUTO_INCREMENT,
  `message_content` longtext DEFAULT NULL,
  `send_date` datetime DEFAULT NULL,
  `status` enum('Unread','Read') DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `users_nik` varchar(16) NOT NULL,
  PRIMARY KEY (`id_message`,`users_nik`),
  KEY `fk_inboxs_users1_idx` (`users_nik`),
  CONSTRAINT `fk_inboxs_users1` FOREIGN KEY (`users_nik`) REFERENCES `users` (`nik`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inboxs`
--

LOCK TABLES `inboxs` WRITE;
/*!40000 ALTER TABLE `inboxs` DISABLE KEYS */;
INSERT INTO `inboxs` VALUES (1,'Pesan transfer','2022-11-29 22:59:44','Read','2022-11-29 22:59:44','0987654321234567'),(2,'Test Pengumuman','2022-12-01 21:06:10','Read','2022-12-01 21:06:10','0987654321234567'),(3,'Test Pengumuman','2022-12-01 21:06:10','Read','2022-12-01 21:06:10','1234567890123456'),(4,'Status transfer berhasil \nTanggal : 22/12/2022\nSumber Rekening : 20227891\nPemilik Rekening : wahyuSri adijaya\nNominal Transfer : Rp100.000','2022-12-22 16:48:24','Read','2022-12-22 16:48:24','1234567891'),(5,'pembayaran loan berhasil \nNominal hutang = Rp 1000000','2023-01-14 18:29:36','Read','2023-01-14 18:29:36','89898989898998'),(6,'pembayaran loan berhasil \nNominal hutang = Rp 100000','2023-01-14 18:44:32','Unread','2023-01-14 18:44:32','1234567891'),(7,'pembayaran loan berhasil \nNominal hutang = Rp 1000000','2023-01-14 19:06:53','Read','2023-01-14 19:06:53','89898989898998'),(8,'pembayaran loan berhasil \nNominal hutang = Rp 1000000','2023-01-14 22:56:11','Unread','2023-01-14 22:56:11','89898989898998'),(9,'Status transfer berhasil \nTanggal : 14/01/2023\nSumber Rekening : 20238998\nPemilik Rekening : SulettaMercury\nNominal Transfer : Rp1.000.000','2023-01-14 23:02:27','Unread','2023-01-14 23:02:27','89898989898998'),(10,'Status transfer berhasil \nTanggal : 14/01/2023\nSumber Rekening : 20238998\nPemilik Rekening : SulettaMercury\nNominal Transfer : Rp900.000','2023-01-14 23:36:03','Unread','2023-01-14 23:36:03','89898989898998'),(11,'Status transfer berhasil \nTanggal : 14/01/2023\nSumber Rekening : 20238998\nPemilik Rekening : SulettaMercury\nNominal Transfer : Rp100.000','2023-01-14 23:41:38','Read','2023-01-14 23:41:38','89898989898998'),(12,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','0987654321234567'),(13,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','0987876545345678'),(14,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','0987876565432123'),(15,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','0987876565432345'),(16,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','0989876545432345'),(17,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','123456789'),(18,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','1234567890123456'),(19,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','1234567891'),(20,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','3456786745633434'),(21,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','4444444444444444'),(22,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','7878787878778'),(23,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','897865432111'),(24,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','89898989898998'),(25,'Untuk tipe user basic, akan ada pengurangan biaya administrasi mulai bulan depan','2023-01-15 21:21:43','Unread','2023-01-15 21:21:43','9878765654323456'),(26,'Status transfer berhasil \nTanggal : 15/01/2023\nSumber Rekening : 20238998\nPemilik Rekening : SulettaMercury\nNominal Transfer : Rp11.000','2023-01-15 23:43:44','Unread','2023-01-15 23:43:44','89898989898998'),(27,'Status transfer berhasil \nTanggal : 16/01/2023\nSumber Rekening : 20238998\nPemilik Rekening : SulettaMercury\nNominal Transfer : Rp1.000.000','2023-01-16 00:04:00','Unread','2023-01-16 00:04:00','89898989898998'),(28,'Status transfer berhasil \nTanggal : 16/01/2023\nSumber Rekening : 20238998\nPemilik Rekening : SulettaMercury\nNominal Transfer : Rp1.000.000','2023-01-16 00:04:07','Unread','2023-01-16 00:04:07','89898989898998'),(29,'Status transfer berhasil \nTanggal : 16/01/2023\nSumber Rekening : 20238998\nPemilik Rekening : SulettaMercury\nNominal Transfer : Rp1.000.000','2023-01-16 00:04:12','Unread','2023-01-16 00:04:12','89898989898998'),(30,'Status transfer berhasil \nTanggal : 16/01/2023\nSumber Rekening : 20238998\nPemilik Rekening : SulettaMercury\nNominal Transfer : Rp1.000.000','2023-01-16 00:05:47','Unread','2023-01-16 00:05:47','89898989898998'),(31,'konfirmasi loan berhasil \r\n\nNominal Hutang = Rp 1500000','2023-01-16 13:27:01','Unread','2023-01-16 13:27:01','89898989898998'),(32,'pembayaran loan berhasil \r\n\nNominal hutang = Rp 1500000','2023-01-16 13:34:53','Unread','2023-01-16 13:34:53','89898989898998'),(33,'Status transfer berhasil \r\n\nTanggal : 16/01/2023\r\n\nSumber Rekening : 20235674\r\n\nPemilik Rekening : JohnCena\r\n\nNominal Transfer : Rp100.000,00','2023-01-16 14:55:43','Unread','2023-01-16 14:55:43','3456123478905674'),(34,'Status transfer berhasil \r\n\nTanggal : 16/01/2023\r\n\nSumber Rekening : 20235674\r\n\nPemilik Rekening : JohnCena\r\n\nNominal Transfer : Rp40.000,00','2023-01-16 14:56:49','Unread','2023-01-16 14:56:49','3456123478905674'),(35,'Status transfer berhasil \r\n\nTanggal : 16/01/2023\r\n\nSumber Rekening : 20235674\r\n\nPemilik Rekening : JohnCena\r\n\nNominal Transfer : Rp40.000,00','2023-01-16 15:00:53','Read','2023-01-16 15:00:53','3456123478905674'),(36,'konfirmasi loan berhasil \r\n\nNominal Hutang = Rp 300000','2023-01-16 15:09:27','Unread','2023-01-16 15:09:27','3456123478905674'),(37,'pembayaran loan berhasil \r\n\nNominal hutang = Rp 300000','2023-01-16 15:09:54','Unread','2023-01-16 15:09:54','3456123478905674'),(38,'konfirmasi loan berhasil \r\n\nNominal Hutang = Rp 200000','2023-01-16 15:10:35','Unread','2023-01-16 15:10:35','3456123478905674'),(39,'pembayaran loan berhasil \r\n\nNominal hutang = Rp 200000','2023-01-16 15:11:13','Unread','2023-01-16 15:11:13','3456123478905674');
/*!40000 ALTER TABLE `inboxs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loans`
--

DROP TABLE IF EXISTS `loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loans` (
  `idloans` int(11) NOT NULL,
  `lender_account_number` varchar(10) NOT NULL,
  `verifikator` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `due_date` datetime NOT NULL,
  PRIMARY KEY (`idloans`),
  KEY `fk_loans_savings1_idx` (`lender_account_number`),
  KEY `fk_loans_employees1_idx` (`verifikator`),
  CONSTRAINT `fk_loans_employees1` FOREIGN KEY (`verifikator`) REFERENCES `employees` (`id_employee`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_loans_savings1` FOREIGN KEY (`lender_account_number`) REFERENCES `savings` (`account_number`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loans`
--

LOCK TABLES `loans` WRITE;
/*!40000 ALTER TABLE `loans` DISABLE KEYS */;
INSERT INTO `loans` VALUES (1,'20227891',2,100000,'2023-07-14 06:43:46');
/*!40000 ALTER TABLE `loans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchants`
--

DROP TABLE IF EXISTS `merchants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merchants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `promo_code` varchar(255) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchants`
--

LOCK TABLES `merchants` WRITE;
/*!40000 ALTER TABLE `merchants` DISABLE KEYS */;
INSERT INTO `merchants` VALUES (1,'Promo Piala Dunia','Jak671','2022-12-20 21:01:59','2023-01-05 21:01:59'),(2,'Promo Tahun Baru','year23','2023-01-01 12:26:10','2023-01-31 12:26:10'),(3,'Promo Imlek','23Im','2023-01-15 12:29:12','2023-02-01 12:29:12'),(4,'Promo Galungan & Kuningan','GalKun','2023-01-16 14:12:39','2023-01-16 14:12:39');
/*!40000 ALTER TABLE `merchants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `positions` (
  `id_position` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `keterangan` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_position`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` VALUES (1,'Admin','Mampu memverifikasi'),(2,'Teller','Melayani transfer'),(3,'Customer Service','Melayani keluhan nasabah DiBa');
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `savings`
--

DROP TABLE IF EXISTS `savings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `savings` (
  `account_number` varchar(10) NOT NULL,
  `balance` double NOT NULL,
  `status` enum('Unverified','Active','Suspended','Closing','Closed') NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `id_users` varchar(16) NOT NULL,
  `verifikator` int(11) DEFAULT NULL,
  `tipe` enum('basic','merchant') NOT NULL,
  PRIMARY KEY (`account_number`),
  KEY `fk_savings_users1_idx` (`id_users`),
  KEY `fk_savings_employees1_idx` (`verifikator`),
  CONSTRAINT `fk_savings_employees1` FOREIGN KEY (`verifikator`) REFERENCES `employees` (`id_employee`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_savings_users1` FOREIGN KEY (`id_users`) REFERENCES `users` (`nik`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `savings`
--

LOCK TABLES `savings` WRITE;
/*!40000 ALTER TABLE `savings` DISABLE KEYS */;
INSERT INTO `savings` VALUES ('20222123',100000,'Active','DiBa saving account','2022-12-09 13:34:54','2022-12-09 13:37:11','0987876565432123',2,'basic'),('20222345',1000000,'Active','DiBa saving account','2022-12-14 17:21:54','2022-12-14 17:24:36','0987876565432345',2,'basic'),('20223456',4963880,'Active','DiBa saving account','2022-12-09 14:29:10','2023-01-16 14:13:30','9878765654323456',2,'basic'),('20225678',0,'Active','DiBa saving account','2022-12-09 11:37:08','2022-12-09 12:41:33','0987876545345678',2,'basic'),('20226789',9998897120,'Active','DiBa Account','2022-12-22 15:36:55','2022-12-22 15:36:55','123456789',2,'basic'),('20227891',11110000,'Active','DiBa saving account','2022-12-22 16:46:54','2022-12-22 16:46:54','1234567891',2,'basic'),('20232111',10080000,'Active','DiBa saving account','2023-01-14 01:05:52','2023-01-14 01:09:45','897865432111',2,'merchant'),('20233434',0,'Active','DiBa saving account','2023-01-15 19:38:57','2023-01-16 14:37:41','3456786745633434',2,'basic'),('20235674',1285000,'Active','DiBa saving account','2023-01-16 14:36:30','2023-01-16 15:04:52','3456123478905674',2,'basic'),('20238778',1000000000,'Closed','DiBa saving account','2023-01-14 11:43:28','2023-01-14 11:44:10','7878787878778',2,'basic'),('20238998',6649000,'Active','DiBa saving account','2023-01-14 17:25:13','2023-01-15 00:16:27','89898989898998',3,'basic');
/*!40000 ALTER TABLE `savings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_types`
--

DROP TABLE IF EXISTS `transaction_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_types` (
  `id_transaction_type` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id_transaction_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_types`
--

LOCK TABLES `transaction_types` WRITE;
/*!40000 ALTER TABLE `transaction_types` DISABLE KEYS */;
INSERT INTO `transaction_types` VALUES (1,'DBT','Debit'),(2,'CRT','Credit'),(3,'TAX','Tax'),(4,'ITR','Interest');
/*!40000 ALTER TABLE `transaction_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id_transaction` varchar(45) NOT NULL,
  `transaction_date` datetime NOT NULL,
  `nominal` double NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `source_account_number` varchar(10) NOT NULL,
  `dest_account_number` varchar(10) NOT NULL,
  `id_transaction_type` int(11) NOT NULL,
  `merchants_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_transaction`,`source_account_number`),
  KEY `fk_transactions_savings1_idx` (`source_account_number`),
  KEY `fk_transactions_savings2_idx` (`dest_account_number`),
  KEY `fk_transactions_transaction_types1_idx` (`id_transaction_type`),
  KEY `fk_transactions_merchants1_idx` (`merchants_id`),
  CONSTRAINT `fk_transactions_merchants1` FOREIGN KEY (`merchants_id`) REFERENCES `merchants` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_savings1` FOREIGN KEY (`source_account_number`) REFERENCES `savings` (`account_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_savings2` FOREIGN KEY (`dest_account_number`) REFERENCES `savings` (`account_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_transaction_types1` FOREIGN KEY (`id_transaction_type`) REFERENCES `transaction_types` (`id_transaction_type`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES ('1','2022-12-22 16:24:57',1000000,'Menambah Loan','20226789','20223456',1,NULL),('10','2023-01-14 18:44:32',100000,'Menambah Loan','20226789','20227891',1,NULL),('11','2023-01-14 19:06:53',1000000,'Menambah Loan','20226789','20238998',1,NULL),('12','2023-01-14 22:52:20',1000000,'Konfirm Deposito','20223456','20223456',2,NULL),('13','2023-01-14 22:52:25',1000000,'Konfirm Deposito','20223456','20223456',2,NULL),('14','2023-01-14 22:52:38',950000,'Tutup Deposito','20223456','20223456',2,NULL),('15','2023-01-14 22:52:42',1000000,'Konfirm Deposito','20238998','20238998',2,NULL),('16','2023-01-14 22:55:18',950000,'Tutup Deposito','20238998','20238998',2,NULL),('17','2023-01-14 22:56:10',1000000,'Bayar Loan','20238998','20226789',1,NULL),('18','2023-01-14 23:02:27',1000000,'20227891','20238998','20227891',1,NULL),('19','2023-01-14 23:36:03',900000,'20222345','20238998','20222345',2,NULL),('2','2022-12-22 16:26:30',1000000,'Bayar Loan','20223456','20226789',1,NULL),('20','2023-01-14 23:39:39',10000,'Top up','20238998','20238998',1,NULL),('21','2023-01-14 23:40:23',10000000,'Top up','20238998','20238998',1,NULL),('22','2023-01-14 23:41:38',100000,'20222345','20238998','20222345',2,NULL),('23','2023-01-15 22:52:20',700000,'Top up','20238998','20238998',1,NULL),('24','2023-01-15 23:43:44',11000,'20223456','20238998','20223456',1,NULL),('25','2023-01-16 00:04:00',1000000,'20223456','20238998','20223456',2,NULL),('26','2023-01-16 00:04:07',1000000,'20223456','20238998','20223456',2,NULL),('27','2023-01-16 00:04:12',1000000,'20223456','20238998','20223456',2,NULL),('28','2023-01-16 00:05:47',1000000,'20223456','20238998','20223456',1,NULL),('29','2023-01-16 13:27:01',1500000,'Menambah Loan','20226789','20238998',1,NULL),('3','2022-12-22 16:31:11',500000,'Menambah Loan','20226789','20223456',1,NULL),('30','2023-01-16 13:34:53',1500000,'Bayar Loan','20238998','20226789',1,NULL),('31','2023-01-16 14:39:29',1900000,'Top up','20235674','20235674',1,NULL),('32','2023-01-16 14:40:41',500000,'Konfirm Deposito','20235674','20235674',2,NULL),('33','2023-01-16 14:49:37',475000,'Tutup Deposito','20235674','20235674',2,NULL),('34','2023-01-16 14:49:40',450000,'Konfirm Deposito','20235674','20235674',2,NULL),('35','2023-01-16 14:55:43',100000,'testing pembayaran','20235674','20227891',1,NULL),('36','2023-01-16 14:56:49',40000,'testing merchant 1','20235674','20232111',1,NULL),('37','2023-01-16 15:00:53',40000,'','20235674','20232111',1,2),('38','2023-01-16 15:09:26',300000,'Menambah Loan','20226789','20235674',1,NULL),('39','2023-01-16 15:09:54',300000,'Bayar Loan','20235674','20226789',1,NULL),('4','2022-12-22 16:31:58',500000,'Bayar Loan','20223456','20226789',1,NULL),('40','2023-01-16 15:10:35',200000,'Menambah Loan','20226789','20235674',1,NULL),('41','2023-01-16 15:11:13',200000,'Bayar Loan','20235674','20226789',1,NULL),('5','2022-12-22 16:47:58',10000000,'Top up','20227891','20227891',1,NULL),('6','2022-12-22 16:48:24',100000,'1','20227891','20222123',1,1),('7','2023-01-14 01:10:24',10000000,'Top up','20232111','20232111',1,NULL),('8','2023-01-14 17:29:39',1000000,'Top up','20238998','20238998',1,NULL),('9','2023-01-14 18:29:36',1000000,'Menambah Loan','20226789','20238998',1,NULL);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_types`
--

DROP TABLE IF EXISTS `user_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_types` (
  `iduser_types` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `initial_value` double NOT NULL,
  `end_value` double NOT NULL,
  `transaction_limit` double NOT NULL,
  PRIMARY KEY (`iduser_types`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_types`
--

LOCK TABLES `user_types` WRITE;
/*!40000 ALTER TABLE `user_types` DISABLE KEYS */;
INSERT INTO `user_types` VALUES (1,'Basic',0,50,1000000),(2,'Premium',51,1000000000,10000000);
/*!40000 ALTER TABLE `user_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `nik` varchar(16) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(128) NOT NULL,
  `handphone_num` varchar(45) NOT NULL,
  `password` varchar(128) NOT NULL,
  `pin` varchar(128) NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `iduser_types` int(11) NOT NULL,
  `points` double NOT NULL,
  `last_pin` varchar(128) NOT NULL,
  PRIMARY KEY (`nik`),
  KEY `fk_users_user_types_idx` (`iduser_types`),
  CONSTRAINT `fk_users_user_types` FOREIGN KEY (`iduser_types`) REFERENCES `user_types` (`iduser_types`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('0987654321234567','test','test','test','test','09876545678','ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff','1a33bb15daa9e600dce1cb506148a295a42606192980d17aa197d7d696eb22403b0c75ac94abee3951d3ac799771e3553298a0498100902adcb6d778c73b2b23','2022-11-25 19:51:17','2022-11-25 20:24:40',1,1,'1a33bb15daa9e600dce1cb506148a295a42606192980d17aa197d7d696eb22403b0c75ac94abee3951d3ac799771e3553298a0498100902adcb6d778c73b2b23'),('0987876545345678','Sully','Hudson','Hudson River','sully@gmail.com','09876567654','0dc730a52c1c5cb739f33ffc39d9b6960df28d72d7b37f0be0260529d570fec76d1b20b902fe1cfbea404e932a3fc663b33ac844b433ac16f8f3d53141ebfb7a','ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413','2022-12-09 11:37:08','2022-12-09 11:37:08',1,1,'8fb29448faee18b656030e8f5a8b9e9a695900f36a3b7d7ebb0d9d51e06c8569d81a55e39b481cf50546d697e7bde1715aa6badede8ddc801c739777be77f166'),('0987876565432123','Herman','Widianto','Tanggerang','herman@gmail.com','09898765454','666ed66a984adceb6be0bbafc490817cf0f5cf886aeb0098685edacad27a1d907c6ffd625ee33174601324bcd5bed3a76804faedd276fdc92a7ff075b4662fa1','ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413','2022-12-09 13:34:54','2022-12-09 13:34:54',1,1,'8fb29448faee18b656030e8f5a8b9e9a695900f36a3b7d7ebb0d9d51e06c8569d81a55e39b481cf50546d697e7bde1715aa6badede8ddc801c739777be77f166'),('0987876565432345','Sinyo','Rita','Texas','sinyo@gmail.com','09898767654','07e13ea396d549d0c3e295fe99ecf7c20ace58ab51d1f1c9deb737e2f2ce86d86babaee04a99be0f622c8490549d9a0a21945d99f5afd8a3f1f73132c6b27e47','ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413','2022-12-14 17:21:54','2022-12-14 17:21:54',1,0,'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'),('0989876545432345','Rick','Sanchez','Phily','rick@gmail.com','09898767654','53814a380c9d51ab76c08599a01239d994118b6b8cbd6abf1d7783ad2764fbe1be28f85e89ad00517422a798822d13757a618ec8e7965571c4afbd33c62221f0','cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e','2022-12-16 14:42:44','2022-12-16 14:42:44',1,0,'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'),('123456789','Akun','DiBa','Jakarta','diba@gmail.com','123456789','9506c1cd1aad60374c3da154d2cebb9b6f274805b9b6515a14f87f0ab43fd0404d2eaab564db7e503b0a71184d9036ac67ab18c9c69db48fcd3047cb4853b7f2','cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e','2022-12-22 15:36:53','2022-12-22 15:36:53',1,0,'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'),('1234567890123456','Marshall','Matters','Los Angeles','marshall@gmail.com','09876543212','d51524bb62a37dc99ed175186eb3768d7af911f0bd0b70d35981e68901b28bc5e5f50a6074911f2a983fe695c5e5cb749aac95db15e3684294e4939495f97c7b','cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e','2022-11-25 19:47:06','2022-11-25 19:47:06',1,0,'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'),('1234567891','wahyu','Sri adijaya','bali','wahyu@gmail.com','082144714882','f0f10d91c5a6e579eea5ef94519883c3c317f9c12229b417812478ba068e12abb37df2ff1f021ae913306971e1c3fb2f39a482ca5fe69bd378d14adb83104b57','12dfe9621346c4db705d8c909e28a4509fab47649b4bcf7e100e4f9d97a5c1dcf19e03be8c74fd30244a0a1764aad06fae673cdd04c408070efab1b4395dd61b','2022-12-22 16:46:53','2023-01-14 16:56:04',1,0,'d7901dac15fda6c4d45a19f8057bde312161d25520c32e96565b96460fc609054808b4ea6f65e6e6bb987f2e19f51ae0ed849dafaaed30739dd2cc67074b4d6f'),('3456123478905674','John','Cena','Bali','johncena@gmail.com','089166714545','b7ef049d51b492d0ae0bfee80c580a2b802a912f0309a0c6db02a634692dbb727fdb4fe6a22bf7e673b55b593d41c6c10c4337966057c3590ff8ca97cb0f127e','bb726f672c7516d2cccaef3246f8561ca715547a95b66f5389782d7777b582238ff8e128ac0515e798113c78a87e65bfbe0097daf7ea73f1b9d5537a812bb4b8','2023-01-16 14:36:27','2023-01-16 14:37:06',1,3,'0b14aba28095d950570ca8cf3a68f33a4d2c3b1aec2a5dcf85df45b0e7cf615bc3e1d4b8ebcf3ee95c9f7b8cee721cefd12f33b5a40db14634c969d77906bac4'),('3456786745633434','William','Cena','Jalan Tenggilis Raya no 78, Surabaya, Jawa Timur','william@gmail.com','092166453434','8d92cd360ec9cbda00dbec6e0de42a9a2a11aef9975e495700088c1126721f9d8f06c27e5ee6f5874a548b9230c971820f0dd492e3bfe6362916f2093848ff11','cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e','2023-01-15 19:38:39',NULL,1,0,'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'),('4444444444444444','Rick','Sanchez','Phily','rick@gmail.com','09898767654','53814a380c9d51ab76c08599a01239d994118b6b8cbd6abf1d7783ad2764fbe1be28f85e89ad00517422a798822d13757a618ec8e7965571c4afbd33c62221f0','cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e','2022-12-16 14:43:21','2022-12-16 14:43:21',1,0,'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'),('7878787878778','THOR','ODINSON','Asgard','thor.com','08211111111111','ac6126415e8804b0f9b40d190efdbe1732b81c1ae0a2c025b82c888d6ff07c4c6bebdf50c6811e4842e4355eeb4560aafe59f18227cb36151267c5533c157a70','4dff4ea340f0a823f15d3f4f01ab62eae0e5da579ccb851f8db9dfe84c58b2b37b89903a740e1ee172da793a6e79d560e5f7f9bd058a12a280433ed6fa46510a','2023-01-14 11:43:27',NULL,1,0,'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'),('897865432111','Agus','Wibowo','bali','messi@gmail.com','0821 4471 4882','88980fdbe55b2915d0db9e9b784a08b00b5d9a8a15d4769af848c0e0baa7228d22af598a82b1a3528dda15e75885e1f08f4b5ce41fdb0ab10a079408a378aeaf','d404559f602eab6fd602ac7680dacbfaadd13630335e951f097af3900e9de176b6db28512f2e000b9d04fba5133e8b1c6e8df59db3a8ab9d60be4b97cc9e81db','2023-01-14 01:05:51',NULL,1,0,'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e'),('89898989898998','Suletta','Mercury','Asgard','aerial@gmail.com','0821 4567 8989','873ec133ef3f42e92d224e2f99b9035c57344f53f257a5251f4d00ab5faa105e2a73876ca149c6b3c31c11eddad9101bf7b47d740f8aad0c20956ab6c1f2400b','3627909a29c31381a071ec27f7c9ca97726182aed29a7ddd2e54353322cfb30abb9e3a6df2ac2c20fe23436311d678564d0c8d305930575f60e2d3d048184d79','2023-01-14 17:25:12','2023-01-14 23:07:43',1,8,'c1d580d5d10dc8e5a1c11ddb38a3ec465785efd20ae045812271dc6ea1df7f20a3da830a4ccc1827521de811669a5a600643df3f87c297717283961ab506d911'),('9878765654323456','Supra','Geer','Jepang','supra@gmail.com','89098767765','d35202be0455f62ecc0333be1ed6bd5b713b19b99d6bb3c889f60cdebe588eac66e0032c40f5c16ee385b511b7fa03cc6fede66bd2e516bfd7f8c8daad9970aa','ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413','2022-12-09 14:29:10','2022-12-09 14:42:19',1,1,'cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e');
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

-- Dump completed on 2023-01-16 15:16:26
