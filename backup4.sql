-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: valorant_tracker
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Table structure for table `favoritos`
--

DROP TABLE IF EXISTS `favoritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favoritos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `jogador_id` int(11) NOT NULL,
  `criado_em` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_favorite` (`usuario_id`,`jogador_id`),
  KEY `jogador_id` (`jogador_id`),
  CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`jogador_id`) REFERENCES `jogadores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jogadores`
--

DROP TABLE IF EXISTS `jogadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jogadores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `riot_name` varchar(100) NOT NULL,
  `riot_tag` varchar(50) NOT NULL,
  `puuid` varchar(120) DEFAULT NULL,
  `atualizado_em` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `criado_em` datetime DEFAULT current_timestamp(),
  `rank` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_player` (`riot_name`,`riot_tag`),
  UNIQUE KEY `puuid` (`puuid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jogadores`
--

LOCK TABLES `jogadores` WRITE;
/*!40000 ALTER TABLE `jogadores` DISABLE KEYS */;
INSERT INTO `jogadores` VALUES (1,'kenJI','eeeh','884cc8f6-e692-58b9-81a9-d7ee7594feaa','2026-05-16 16:56:00','2026-05-04 11:29:15','Silver 2'),(2,'Never','EMP','b9a37bb9-c564-5db7-90ee-6f94bfb7c900','2026-05-23 16:29:06','2026-05-16 16:57:38','Platinum 3'),(3,'Talonflame','69337','910d695f-1536-527d-bba7-73206de11e29','2026-05-25 00:25:53','2026-05-23 16:40:39','Platinum 1'),(4,'ayato_amagiri','SAO','4e8f52b2-34ab-51b6-9ac1-27d6d5df6746','2026-05-25 00:26:13','2026-05-25 00:26:13',NULL);
/*!40000 ALTER TABLE `jogadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partidas`
--

DROP TABLE IF EXISTS `partidas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partidas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jogador_id` int(11) NOT NULL,
  `match_id` varchar(100) NOT NULL,
  `mapa` varchar(100) DEFAULT NULL,
  `modo` varchar(50) DEFAULT NULL,
  `agente` varchar(100) DEFAULT NULL,
  `kills` int(11) DEFAULT NULL,
  `deaths` int(11) DEFAULT NULL,
  `assists` int(11) DEFAULT NULL,
  `kdr` decimal(4,2) DEFAULT NULL,
  `resultado` varchar(20) DEFAULT NULL,
  `data_partida` datetime DEFAULT NULL,
  `criado_em` datetime DEFAULT current_timestamp(),
  `headshot_percent` decimal(5,2) DEFAULT NULL,
  `acs` decimal(6,2) DEFAULT NULL,
  `dano_por_round` decimal(6,2) DEFAULT NULL,
  `first_bloods` int(11) DEFAULT 0,
  `aces` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `match_id` (`match_id`),
  KEY `jogador_id` (`jogador_id`),
  CONSTRAINT `partidas_ibfk_1` FOREIGN KEY (`jogador_id`) REFERENCES `jogadores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partidas`
--

LOCK TABLES `partidas` WRITE;
/*!40000 ALTER TABLE `partidas` DISABLE KEYS */;
INSERT INTO `partidas` VALUES (1,1,'a8c95dbf-afea-474c-b1f3-676f96a408e1','Ascent','Competitive','Chamber',17,16,5,1.06,'Derrota','2026-05-02 18:15:53','2026-05-04 11:29:15',17.07,189.61,132.39,0,0),(2,1,'bd686c2e-3a49-4777-98e0-0988fa9fef57','Fracture','Competitive','Deadlock',5,20,8,0.25,'Derrota','2026-05-02 17:29:49','2026-05-04 11:29:15',11.76,87.57,59.39,0,0),(3,1,'4273f604-4225-4de9-9fa8-c4abae1709f0','Breeze','Competitive','Gekko',6,18,3,0.33,'Derrota','2026-05-02 16:45:58','2026-05-04 11:29:15',9.09,94.79,67.54,0,0),(4,1,'6141b7a6-5170-4c66-9445-44ad2562ea7f','Split','Competitive','Omen',12,18,11,0.67,'Vitória','2026-05-01 22:51:16','2026-05-04 11:29:15',4.76,172.64,100.36,0,0),(5,1,'88950f63-5f6a-4705-a51b-05bc18eec473','Split','Competitive','Omen',13,14,6,0.93,'Derrota','2026-05-01 22:17:26','2026-05-04 11:29:15',13.46,180.56,107.00,0,0),(6,1,'53dc85c2-1a2c-4e7f-871c-314d8edc13cb','Lotus','Competitive','Chamber',12,12,3,1.00,'Vitória','2026-04-30 18:43:00','2026-05-04 11:29:15',14.29,157.84,111.16,0,0),(7,1,'38270f24-7e0d-4f74-950b-00e0b74e11e0','Breeze','Competitive','Omen',11,16,5,0.69,'Derrota','2026-04-30 17:50:51','2026-05-04 11:29:15',16.28,160.05,109.29,0,0),(8,1,'17b8f954-0bf5-4dad-9cad-f762e480a51d','Fracture','Competitive','KAY/O',24,20,8,1.20,'Vitória','2026-04-30 16:42:09','2026-05-04 11:29:15',14.12,247.14,139.89,0,0),(9,1,'b448ed0b-97a0-474f-be42-f06f6981eefb','Haven','Competitive','Sova',7,17,8,0.41,'Derrota','2026-04-29 22:11:23','2026-05-04 11:29:15',15.63,150.67,105.50,0,0),(10,1,'42eb6561-2325-414b-b368-765f15790236','Ascent','Competitive','Fade',12,5,8,2.40,'Vitória','2026-04-29 21:41:10','2026-05-04 11:29:15',15.00,197.44,120.50,0,0),(41,1,'287aa70c-15a0-4fca-b857-902e410e1ca6','Pearl','Competitive','Skye',16,18,9,0.89,'Derrota','2026-05-13 20:41:07','2026-05-16 16:27:38',7.22,211.50,127.08,3,0),(42,1,'bb249a5b-e873-42c1-8029-01721a6bea22','Split','Competitive','Chamber',11,15,6,0.73,'Vitória','2026-05-13 20:01:42','2026-05-16 16:27:38',8.51,152.45,101.15,0,0),(43,1,'ccb86980-26b7-4e7a-a53a-aa6f8ff88c6e','Lotus','Competitive','Skye',8,19,14,0.42,'Derrota','2026-05-13 19:23:04','2026-05-16 16:27:38',12.16,146.57,92.19,0,0),(44,1,'d1bbf23d-17ad-4216-bb36-0614cd73ae13','Pearl','Competitive','Phoenix',7,16,8,0.44,'Derrota','2026-05-13 00:23:36','2026-05-16 16:27:38',6.67,142.00,105.10,2,0),(45,1,'c9c408c3-063f-4718-9e6c-900827801e82','Split','Competitive','Sage',5,15,10,0.33,'Derrota','2026-05-12 23:50:19','2026-05-16 16:27:38',10.42,132.78,83.11,1,0),(46,1,'0bdf850d-a28b-430f-8095-ce4ab76a627c','Breeze','Competitive','Chamber',6,16,4,0.38,'Derrota','2026-05-12 23:17:34','2026-05-16 16:27:38',22.22,109.22,84.22,1,0),(47,1,'9a1a2943-d381-4cf4-8eb1-2736c54a960e','Lotus','Competitive','Chamber',14,14,2,1.00,'Vitória','2026-05-12 22:04:52','2026-05-16 16:27:38',12.90,158.48,107.74,1,0),(48,1,'a52e7566-8a69-4928-a219-4cb3d06ff98b','Pearl','Competitive','Phoenix',10,17,5,0.59,'Vitória','2026-05-12 21:27:21','2026-05-16 16:27:38',8.93,174.57,115.71,0,0),(49,1,'657823be-8804-48d8-b84d-c7548bd33ecc','Split','Competitive','KAY/O',8,15,3,0.53,'Vitória','2026-05-12 20:52:59','2026-05-16 16:27:38',25.81,132.71,100.35,1,0),(50,1,'b1566211-9c75-435b-ba6f-f3a6183085f5','Pearl','Competitive','Sova',9,16,15,0.56,'Derrota','2026-05-12 20:06:21','2026-05-16 16:27:38',10.00,154.13,119.88,0,0),(91,2,'bb4dfc96-a55b-4b03-8f2a-d8afb9588c36','Pearl','Competitive','Omen',29,18,6,1.61,'Derrota','2026-05-16 02:33:39','2026-05-16 16:57:38',31.71,313.27,193.08,3,0),(92,2,'a295b983-4cf3-4f65-8314-8efa4630b06c','Breeze','Competitive','Iso',18,14,0,1.29,'Vitória','2026-05-16 01:57:31','2026-05-16 16:57:38',27.27,272.84,176.42,4,0),(93,2,'431940e4-a3ec-4373-a684-057981bb00d5','Pearl','Competitive','Vyse',18,16,4,1.13,'Vitória','2026-05-16 01:14:55','2026-05-16 16:57:38',25.37,245.40,175.80,2,0),(94,2,'b155992f-daf6-4bda-8849-e1cb57bf0d7c','Fracture','Competitive','Killjoy',18,14,3,1.29,'Vitória','2026-05-16 00:35:26','2026-05-16 16:57:38',33.96,220.59,157.36,4,0),(95,2,'c02710e7-5cfc-4f57-affe-44a0fc90051b','Breeze','Competitive','Killjoy',19,10,5,1.90,'Vitória','2026-05-15 23:53:40','2026-05-16 16:57:38',17.11,279.84,172.74,5,0),(96,2,'fead65e1-cbe7-415a-8dd7-09220631f556','Fracture','Competitive','Iso',35,14,7,2.50,'Derrota','2026-05-15 23:11:19','2026-05-16 16:57:38',34.94,421.50,269.13,7,1),(97,2,'f26f78bc-e8a3-4b63-aa22-99b1aeb7e1ac','Pearl','Competitive','Jett',16,17,3,0.94,'Derrota','2026-05-15 22:35:58','2026-05-16 16:57:38',25.49,243.90,150.10,4,0),(98,2,'d34a0e55-06c1-4f5d-a144-49c39e1980a8','Lotus','Competitive','Reyna',19,16,8,1.19,'Vitória','2026-05-15 21:59:59','2026-05-16 16:57:38',26.32,278.67,173.33,1,0),(99,2,'2d6c8755-af8a-45e9-b52b-8b8910370fc7','Split','Competitive','Iso',15,18,6,0.83,'Vitória','2026-05-15 21:18:51','2026-05-16 16:57:38',15.00,194.70,140.48,3,0),(100,2,'1f6b90d1-e0af-4829-b803-af174d0d40bc','Breeze','Competitive','Chamber',19,14,4,1.36,'Derrota','2026-05-03 03:57:10','2026-05-16 16:57:38',27.59,248.18,156.09,3,0),(101,2,'71fa07aa-27c2-43b9-ab7b-91744b48f8cb','Lotus','Competitive','Reyna',14,14,4,1.00,'Vitória','2026-05-23 02:22:08','2026-05-23 16:18:32',27.27,228.11,158.67,4,0),(102,2,'76d28c78-4457-44b7-827a-8894706059b0','Split','Competitive','Sage',27,17,9,1.59,'Derrota','2026-05-23 01:42:56','2026-05-23 16:18:32',28.92,352.65,208.13,0,0),(103,2,'b1d9e8ef-476f-4ccf-af55-af5840e01854','Lotus','Competitive','Vyse',16,18,6,0.89,'Derrota','2026-05-23 00:59:25','2026-05-23 16:18:32',27.78,216.82,143.27,0,0),(104,2,'ef736d54-2264-4642-87b5-e9ffbe91b8f1','Pearl','Competitive','Harbor',14,16,7,0.88,'Derrota','2026-05-23 00:16:01','2026-05-23 16:18:32',34.48,179.04,127.43,3,0),(105,2,'4785358b-bdc9-4bd8-8780-b5c29aabd7b2','Ascent','Competitive','Omen',10,17,6,0.59,'Derrota','2026-05-22 23:38:16','2026-05-23 16:18:32',22.86,158.85,95.35,2,0),(106,2,'5abdbefe-5dad-4daf-9ff5-3c0c95a604dd','Haven','Competitive','Fade',29,19,10,1.53,'Derrota','2026-05-22 22:36:44','2026-05-23 16:18:32',34.25,295.68,198.57,4,0),(107,2,'4a11dbb5-d5b1-40d4-81c7-52f34e6bb847','Fracture','Competitive','Killjoy',16,14,2,1.14,'Vitória','2026-05-22 21:57:24','2026-05-23 16:18:32',32.61,202.48,132.48,2,0),(108,2,'0d8930e1-8155-4929-aedb-836657090097','Split','Competitive','Omen',17,15,3,1.13,'Derrota','2026-05-22 21:23:30','2026-05-23 16:18:32',25.93,251.84,154.37,1,0),(109,2,'af8cb32b-7d84-4f91-863e-588e0ff58b7e','Lotus','Competitive','Omen',28,15,3,1.87,'Derrota','2026-05-22 20:46:43','2026-05-23 16:18:32',35.94,332.91,224.14,1,0),(110,2,'c66bf1c1-ab38-404e-a113-55da611f57fc','Fracture','Competitive','Reyna',16,16,4,1.00,'Vitória','2026-05-22 20:06:47','2026-05-23 16:18:32',14.29,195.92,132.08,3,0),(142,3,'96172396-3a59-42c2-831d-e1a22b8b8417','Lotus','Competitive','Chamber',22,12,2,1.83,'Vitória','2026-05-03 03:21:21','2026-05-23 16:40:39',39.53,285.50,198.55,2,0),(143,3,'08e54804-2509-47a5-b8f2-c0653eeece79','Pearl','Competitive','Sage',16,21,14,0.76,'Vitória','2026-05-03 02:13:50','2026-05-23 16:40:39',31.37,150.63,113.03,3,0),(144,3,'fb583635-0742-4a7f-a668-d97c2d61d5bf','Split','Competitive','KAY/O',9,21,11,0.43,'Vitória','2026-05-03 01:24:38','2026-05-23 16:40:39',12.77,129.08,86.92,2,0),(145,3,'8b22d8d1-b70b-4cfc-845b-52c52d2d6333','Lotus','Competitive','Chamber',31,19,5,1.63,'Vitória','2026-05-03 00:35:15','2026-05-23 16:40:39',23.86,297.75,183.86,5,0),(146,3,'5322a6fa-2f32-46b8-a215-a7aec10c7ae4','Breeze','Competitive','Sage',12,15,8,0.80,'Derrota','2026-05-02 23:56:01','2026-05-23 16:40:39',14.63,157.77,103.32,2,0),(147,3,'c60dd266-1849-4409-9018-8c45d3675f31','Fracture','Competitive','Chamber',27,16,3,1.69,'Derrota','2026-05-02 01:13:39','2026-05-23 16:40:39',31.82,329.61,225.13,3,0),(148,3,'edf41eef-f2a7-43c2-a344-a2756ffd5eb4','Split','Competitive','Chamber',23,17,4,1.35,'Vitória','2026-05-02 00:29:57','2026-05-23 16:40:39',17.74,279.79,176.96,2,0),(149,3,'92e3cd8e-9391-4b78-bbe9-9b8221eb5386','Lotus','Competitive','Reyna',12,14,2,0.86,'Derrota','2026-05-01 23:59:44','2026-05-23 16:40:39',18.42,246.63,151.63,5,0),(150,3,'5397d739-5d45-462f-9168-1cf767e01975','Breeze','Competitive','Chamber',17,12,1,1.42,'Vitória','2026-04-25 20:41:51','2026-05-23 16:40:39',46.88,227.05,149.60,2,0),(161,4,'d1054693-3b54-402d-b47b-a42de3180f73','Split','Competitive','Cypher',11,20,6,0.55,'Vitória','2026-05-24 21:36:56','2026-05-25 00:26:13',9.68,155.30,93.43,3,0),(162,4,'b9cacbd7-5e4a-4c30-b865-c8537b8d0582','Lotus','Competitive','Skye',12,24,11,0.50,'Empate','2026-05-24 20:39:06','2026-05-25 00:26:13',15.22,112.57,69.57,1,0),(163,4,'569ec796-d039-4a91-a463-cc808c6297e5','Breeze','Competitive','Sage',8,12,11,0.67,'Vitória','2026-05-24 20:08:23','2026-05-25 00:26:13',17.24,141.71,80.59,2,0),(164,4,'802a8d98-f4b7-4821-82db-7c028d1dedd7','Split','Competitive','Gekko',22,21,6,1.05,'Empate','2026-05-24 18:46:55','2026-05-25 00:26:13',18.18,219.61,121.21,2,0),(165,4,'9b5102e6-03e1-469b-b25e-51928da59db1','Ascent','Competitive','Cypher',10,11,5,0.91,'Vitória','2026-05-24 18:11:22','2026-05-25 00:26:13',22.50,156.00,108.58,0,0),(166,4,'6375e816-1561-4aad-9e5d-43204e1d6a67','Lotus','Competitive','Cypher',15,15,6,1.00,'Vitória','2026-05-24 01:48:10','2026-05-25 00:26:13',8.45,188.87,123.48,3,0),(167,4,'102fbfa3-1e1c-4750-97f3-59365a717e0f','Ascent','Competitive','Skye',13,12,14,1.08,'Vitória','2026-05-24 01:16:17','2026-05-25 00:26:13',1.82,179.68,97.32,1,0),(168,4,'ff052e46-ed72-4206-baec-826a1d05d5e1','Split','Competitive','Skye',13,9,5,1.44,'Vitória','2026-05-24 00:47:20','2026-05-25 00:26:13',24.32,213.38,138.31,1,0),(169,4,'2e3c8134-8985-461e-8d44-888046e56d1f','Breeze','Competitive','Skye',7,9,11,0.78,'Vitória','2026-05-24 00:20:38','2026-05-25 00:26:13',3.23,122.94,69.06,0,0),(170,4,'e673a1c9-de1c-4859-83e3-6ea68f686357','Fracture','Competitive','Gekko',23,13,4,1.77,'Derrota','2026-05-23 23:33:17','2026-05-25 00:26:13',12.66,278.45,170.14,2,0);
/*!40000 ALTER TABLE `partidas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rank_snapshots`
--

DROP TABLE IF EXISTS `rank_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rank_snapshots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jogador_id` int(11) NOT NULL,
  `rank` varchar(50) DEFAULT NULL,
  `rr` int(11) DEFAULT NULL,
  `data_coleta` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `jogador_id` (`jogador_id`),
  CONSTRAINT `rank_snapshots_ibfk_1` FOREIGN KEY (`jogador_id`) REFERENCES `jogadores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rank_snapshots`
--

LOCK TABLES `rank_snapshots` WRITE;
/*!40000 ALTER TABLE `rank_snapshots` DISABLE KEYS */;
INSERT INTO `rank_snapshots` VALUES (1,1,'Silver 2',86,'2026-05-16 16:50:32'),(2,1,'Silver 2',86,'2026-05-16 16:51:04'),(3,1,'Silver 2',86,'2026-05-16 16:54:19'),(4,1,'Silver 2',86,'2026-05-16 16:56:00'),(5,2,'Platinum 3',10,'2026-05-23 16:18:32'),(6,2,'Platinum 3',10,'2026-05-23 16:25:44'),(7,2,'Platinum 3',10,'2026-05-23 16:27:03'),(8,2,'Platinum 3',10,'2026-05-23 16:29:06'),(9,3,'Platinum 1',1,'2026-05-25 00:25:53');
/*!40000 ALTER TABLE `rank_snapshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `criado_em` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-25  0:28:59
