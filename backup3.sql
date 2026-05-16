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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jogadores`
--

LOCK TABLES `jogadores` WRITE;
/*!40000 ALTER TABLE `jogadores` DISABLE KEYS */;
INSERT INTO `jogadores` VALUES (1,'kenJI','eeeh','884cc8f6-e692-58b9-81a9-d7ee7594feaa','2026-05-16 16:56:00','2026-05-04 11:29:15','Silver 2'),(2,'Never','EMP','b9a37bb9-c564-5db7-90ee-6f94bfb7c900','2026-05-16 16:57:38','2026-05-16 16:57:38',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partidas`
--

LOCK TABLES `partidas` WRITE;
/*!40000 ALTER TABLE `partidas` DISABLE KEYS */;
INSERT INTO `partidas` VALUES (1,1,'a8c95dbf-afea-474c-b1f3-676f96a408e1','Ascent','Competitive','Chamber',17,16,5,1.06,'Derrota','2026-05-02 18:15:53','2026-05-04 11:29:15',17.07,189.61,132.39,0,0),(2,1,'bd686c2e-3a49-4777-98e0-0988fa9fef57','Fracture','Competitive','Deadlock',5,20,8,0.25,'Derrota','2026-05-02 17:29:49','2026-05-04 11:29:15',11.76,87.57,59.39,0,0),(3,1,'4273f604-4225-4de9-9fa8-c4abae1709f0','Breeze','Competitive','Gekko',6,18,3,0.33,'Derrota','2026-05-02 16:45:58','2026-05-04 11:29:15',9.09,94.79,67.54,0,0),(4,1,'6141b7a6-5170-4c66-9445-44ad2562ea7f','Split','Competitive','Omen',12,18,11,0.67,'Vitória','2026-05-01 22:51:16','2026-05-04 11:29:15',4.76,172.64,100.36,0,0),(5,1,'88950f63-5f6a-4705-a51b-05bc18eec473','Split','Competitive','Omen',13,14,6,0.93,'Derrota','2026-05-01 22:17:26','2026-05-04 11:29:15',13.46,180.56,107.00,0,0),(6,1,'53dc85c2-1a2c-4e7f-871c-314d8edc13cb','Lotus','Competitive','Chamber',12,12,3,1.00,'Vitória','2026-04-30 18:43:00','2026-05-04 11:29:15',14.29,157.84,111.16,0,0),(7,1,'38270f24-7e0d-4f74-950b-00e0b74e11e0','Breeze','Competitive','Omen',11,16,5,0.69,'Derrota','2026-04-30 17:50:51','2026-05-04 11:29:15',16.28,160.05,109.29,0,0),(8,1,'17b8f954-0bf5-4dad-9cad-f762e480a51d','Fracture','Competitive','KAY/O',24,20,8,1.20,'Vitória','2026-04-30 16:42:09','2026-05-04 11:29:15',14.12,247.14,139.89,0,0),(9,1,'b448ed0b-97a0-474f-be42-f06f6981eefb','Haven','Competitive','Sova',7,17,8,0.41,'Derrota','2026-04-29 22:11:23','2026-05-04 11:29:15',15.63,150.67,105.50,0,0),(10,1,'42eb6561-2325-414b-b368-765f15790236','Ascent','Competitive','Fade',12,5,8,2.40,'Vitória','2026-04-29 21:41:10','2026-05-04 11:29:15',15.00,197.44,120.50,0,0),(41,1,'287aa70c-15a0-4fca-b857-902e410e1ca6','Pearl','Competitive','Skye',16,18,9,0.89,'Derrota','2026-05-13 20:41:07','2026-05-16 16:27:38',7.22,211.50,127.08,3,0),(42,1,'bb249a5b-e873-42c1-8029-01721a6bea22','Split','Competitive','Chamber',11,15,6,0.73,'Vitória','2026-05-13 20:01:42','2026-05-16 16:27:38',8.51,152.45,101.15,0,0),(43,1,'ccb86980-26b7-4e7a-a53a-aa6f8ff88c6e','Lotus','Competitive','Skye',8,19,14,0.42,'Derrota','2026-05-13 19:23:04','2026-05-16 16:27:38',12.16,146.57,92.19,0,0),(44,1,'d1bbf23d-17ad-4216-bb36-0614cd73ae13','Pearl','Competitive','Phoenix',7,16,8,0.44,'Derrota','2026-05-13 00:23:36','2026-05-16 16:27:38',6.67,142.00,105.10,2,0),(45,1,'c9c408c3-063f-4718-9e6c-900827801e82','Split','Competitive','Sage',5,15,10,0.33,'Derrota','2026-05-12 23:50:19','2026-05-16 16:27:38',10.42,132.78,83.11,1,0),(46,1,'0bdf850d-a28b-430f-8095-ce4ab76a627c','Breeze','Competitive','Chamber',6,16,4,0.38,'Derrota','2026-05-12 23:17:34','2026-05-16 16:27:38',22.22,109.22,84.22,1,0),(47,1,'9a1a2943-d381-4cf4-8eb1-2736c54a960e','Lotus','Competitive','Chamber',14,14,2,1.00,'Vitória','2026-05-12 22:04:52','2026-05-16 16:27:38',12.90,158.48,107.74,1,0),(48,1,'a52e7566-8a69-4928-a219-4cb3d06ff98b','Pearl','Competitive','Phoenix',10,17,5,0.59,'Vitória','2026-05-12 21:27:21','2026-05-16 16:27:38',8.93,174.57,115.71,0,0),(49,1,'657823be-8804-48d8-b84d-c7548bd33ecc','Split','Competitive','KAY/O',8,15,3,0.53,'Vitória','2026-05-12 20:52:59','2026-05-16 16:27:38',25.81,132.71,100.35,1,0),(50,1,'b1566211-9c75-435b-ba6f-f3a6183085f5','Pearl','Competitive','Sova',9,16,15,0.56,'Derrota','2026-05-12 20:06:21','2026-05-16 16:27:38',10.00,154.13,119.88,0,0),(91,2,'bb4dfc96-a55b-4b03-8f2a-d8afb9588c36','Pearl','Competitive','Omen',29,18,6,1.61,'Derrota','2026-05-16 02:33:39','2026-05-16 16:57:38',31.71,313.27,193.08,3,0),(92,2,'a295b983-4cf3-4f65-8314-8efa4630b06c','Breeze','Competitive','Iso',18,14,0,1.29,'Vitória','2026-05-16 01:57:31','2026-05-16 16:57:38',27.27,272.84,176.42,4,0),(93,2,'431940e4-a3ec-4373-a684-057981bb00d5','Pearl','Competitive','Vyse',18,16,4,1.13,'Vitória','2026-05-16 01:14:55','2026-05-16 16:57:38',25.37,245.40,175.80,2,0),(94,2,'b155992f-daf6-4bda-8849-e1cb57bf0d7c','Fracture','Competitive','Killjoy',18,14,3,1.29,'Vitória','2026-05-16 00:35:26','2026-05-16 16:57:38',33.96,220.59,157.36,4,0),(95,2,'c02710e7-5cfc-4f57-affe-44a0fc90051b','Breeze','Competitive','Killjoy',19,10,5,1.90,'Vitória','2026-05-15 23:53:40','2026-05-16 16:57:38',17.11,279.84,172.74,5,0),(96,2,'fead65e1-cbe7-415a-8dd7-09220631f556','Fracture','Competitive','Iso',35,14,7,2.50,'Derrota','2026-05-15 23:11:19','2026-05-16 16:57:38',34.94,421.50,269.13,7,1),(97,2,'f26f78bc-e8a3-4b63-aa22-99b1aeb7e1ac','Pearl','Competitive','Jett',16,17,3,0.94,'Derrota','2026-05-15 22:35:58','2026-05-16 16:57:38',25.49,243.90,150.10,4,0),(98,2,'d34a0e55-06c1-4f5d-a144-49c39e1980a8','Lotus','Competitive','Reyna',19,16,8,1.19,'Vitória','2026-05-15 21:59:59','2026-05-16 16:57:38',26.32,278.67,173.33,1,0),(99,2,'2d6c8755-af8a-45e9-b52b-8b8910370fc7','Split','Competitive','Iso',15,18,6,0.83,'Vitória','2026-05-15 21:18:51','2026-05-16 16:57:38',15.00,194.70,140.48,3,0),(100,2,'1f6b90d1-e0af-4829-b803-af174d0d40bc','Breeze','Competitive','Iso',24,15,3,1.60,'Derrota','2026-05-03 03:57:10','2026-05-16 16:57:38',30.77,300.91,192.00,7,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rank_snapshots`
--

LOCK TABLES `rank_snapshots` WRITE;
/*!40000 ALTER TABLE `rank_snapshots` DISABLE KEYS */;
INSERT INTO `rank_snapshots` VALUES (1,1,'Silver 2',86,'2026-05-16 16:50:32'),(2,1,'Silver 2',86,'2026-05-16 16:51:04'),(3,1,'Silver 2',86,'2026-05-16 16:54:19'),(4,1,'Silver 2',86,'2026-05-16 16:56:00');
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

-- Dump completed on 2026-05-16 17:10:06
