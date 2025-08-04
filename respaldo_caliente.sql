-- MySQL dump 10.13  Distrib 9.1.0, for Win64 (x86_64)
--
-- Host: localhost    Database: centro_tecnico_db
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aparatos`
--

DROP TABLE IF EXISTS `aparatos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aparatos` (
  `aparato_id` int NOT NULL AUTO_INCREMENT,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `cliente_id` int NOT NULL,
  `nombre_a` varchar(100) NOT NULL,
  `marca` varchar(100) NOT NULL,
  `modelo` varchar(100) NOT NULL,
  `color` varchar(100) NOT NULL,
  `estado` enum('Recibido','Reparado','Entregado') DEFAULT 'Recibido',
  PRIMARY KEY (`aparato_id`),
  KEY `idx_aparatos_estado` (`estado`),
  KEY `idx_aparatos_cliente_id` (`cliente_id`),
  CONSTRAINT `aparatos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aparatos`
--

LOCK TABLES `aparatos` WRITE;
/*!40000 ALTER TABLE `aparatos` DISABLE KEYS */;
INSERT INTO `aparatos` VALUES (1,'2025-08-03 22:16:46',1,'Licuadora','Oster','O123','Rojo','Recibido'),(2,'2025-08-03 22:16:46',2,'Celular','Samsung','Galaxy A21s','Negro','Recibido'),(3,'2025-08-03 22:16:46',3,'Impresora','Epson','XP 340','Negro','Recibido'),(4,'2025-08-03 22:16:46',4,'Laptop','HP','GalaxyAsus 56','Naranja','Recibido'),(5,'2025-08-03 22:16:46',5,'Lavadora','Samsung','lut5 68','Blanco','Recibido');
/*!40000 ALTER TABLE `aparatos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aparatos_domicilio`
--

DROP TABLE IF EXISTS `aparatos_domicilio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aparatos_domicilio` (
  `aparato_domi_id` int NOT NULL AUTO_INCREMENT,
  `nombre_aparato` varchar(100) NOT NULL,
  `marca` varchar(100) NOT NULL,
  `modelo` varchar(100) NOT NULL,
  `color` varchar(100) NOT NULL,
  `observación` text NOT NULL,
  PRIMARY KEY (`aparato_domi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aparatos_domicilio`
--

LOCK TABLES `aparatos_domicilio` WRITE;
/*!40000 ALTER TABLE `aparatos_domicilio` DISABLE KEYS */;
INSERT INTO `aparatos_domicilio` VALUES (1,'Refrigeradora','Samsung','CoolMax','Plateado','Hace ruido al encender'),(2,'Televisor','Sony','Bravia 32\"','Negro','No da imagen');
/*!40000 ALTER TABLE `aparatos_domicilio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aparatos_inventario`
--

DROP TABLE IF EXISTS `aparatos_inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aparatos_inventario` (
  `aparatos_ad_id` int NOT NULL AUTO_INCREMENT,
  `nombre_a` varchar(100) NOT NULL,
  `marca` varchar(100) NOT NULL,
  `modelo` varchar(100) NOT NULL,
  `color` varchar(100) NOT NULL,
  `observación` text,
  `tipo` enum('Adquirido','Remate') DEFAULT NULL,
  PRIMARY KEY (`aparatos_ad_id`),
  KEY `idx_aparatos_inventario_nombre` (`nombre_a`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aparatos_inventario`
--

LOCK TABLES `aparatos_inventario` WRITE;
/*!40000 ALTER TABLE `aparatos_inventario` DISABLE KEYS */;
INSERT INTO `aparatos_inventario` VALUES (1,'Microondas','LG','MH604','Gris','Funciona correctamente, sin uso reciente.','Adquirido'),(2,'Licuadora','Oster','Classic 3V','Blanco','Presenta ralladuras leves.','Remate');
/*!40000 ALTER TABLE `aparatos_inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditoria_reparaciones`
--

DROP TABLE IF EXISTS `auditoria_reparaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_reparaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reparacion_id` int DEFAULT NULL,
  `cliente_id` int DEFAULT NULL,
  `aparato_id` int DEFAULT NULL,
  `tecnico_id` int DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_bd` varchar(100) DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_reparaciones`
--

LOCK TABLES `auditoria_reparaciones` WRITE;
/*!40000 ALTER TABLE `auditoria_reparaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditoria_reparaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditoria_usuarios`
--

DROP TABLE IF EXISTS `auditoria_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_accion` enum('INSERT','UPDATE','DELETE') DEFAULT NULL,
  `usuario_afectado` varchar(100) DEFAULT NULL,
  `rol` varchar(50) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_bd` varchar(100) DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_usuarios`
--

LOCK TABLES `auditoria_usuarios` WRITE;
/*!40000 ALTER TABLE `auditoria_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditoria_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `cliente_id` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `cedula` varchar(20) NOT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion` text NOT NULL,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  PRIMARY KEY (`cliente_id`),
  KEY `idx_clientes_cedula` (`cedula`),
  KEY `idx_clientes_estado` (`estado`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Ivan Andres','Castillo Caiza','1718298156','ivan.castillo@gmail.com','0982158101','Av. Central 101','2025-08-03 22:16:45','Activo'),(2,'Daniel Jefferson','Guano Quilumba','7121546598',NULL,'0987273196','Av.Isidro Ayora','2025-08-03 22:16:45','Activo'),(3,'Edwin Alexander','Sarango Canar','1798546268','edwin.sarango@gmail.com','0968911731','Av. Central 102','2025-08-03 22:16:45','Activo'),(4,'Francesco','Chalaco Sarango','7148956230',NULL,'0963673666','Av. Central 106','2025-08-03 22:16:45','Activo'),(5,'Lucía Rocio','Vera Perez','1728956482','lucia.vera@hotmail.com','0901122334','Calle Falsa 123','2025-08-03 22:16:45','Activo');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes_domicilio`
--

DROP TABLE IF EXISTS `clientes_domicilio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes_domicilio` (
  `cliente_domi_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion` text NOT NULL,
  PRIMARY KEY (`cliente_domi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes_domicilio`
--

LOCK TABLES `clientes_domicilio` WRITE;
/*!40000 ALTER TABLE `clientes_domicilio` DISABLE KEYS */;
INSERT INTO `clientes_domicilio` VALUES (1,'Pedro','Quintana','0991234567','Av. 9 de Octubre y Rocafuerte'),(2,'María','López','0987456123','Cdla. Las Orquídeas, Mz 24, Solar 5');
/*!40000 ALTER TABLE `clientes_domicilio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnostico_tecnico`
--

DROP TABLE IF EXISTS `diagnostico_tecnico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnostico_tecnico` (
  `diagnostico_t_id` int NOT NULL AUTO_INCREMENT,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `cliente_id` int NOT NULL,
  `aparato_id` int NOT NULL,
  `ordenes_t_id` int DEFAULT NULL,
  `diagnostico_t` text,
  PRIMARY KEY (`diagnostico_t_id`),
  KEY `ordenes_t_id` (`ordenes_t_id`),
  KEY `aparato_id` (`aparato_id`),
  KEY `idx_diagnostico_tecnico_cliente_aparato` (`cliente_id`,`aparato_id`),
  CONSTRAINT `diagnostico_tecnico_ibfk_1` FOREIGN KEY (`ordenes_t_id`) REFERENCES `ordenes_tecnicos` (`ordenes_t_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `diagnostico_tecnico_ibfk_2` FOREIGN KEY (`aparato_id`) REFERENCES `aparatos` (`aparato_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `diagnostico_tecnico_ibfk_3` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnostico_tecnico`
--

LOCK TABLES `diagnostico_tecnico` WRITE;
/*!40000 ALTER TABLE `diagnostico_tecnico` DISABLE KEYS */;
INSERT INTO `diagnostico_tecnico` VALUES (1,'2025-08-03 22:16:46',1,1,1,'Se quemó el motor. Requiere cambio.'),(2,'2025-08-03 22:16:46',2,2,2,'Pantalla quebrada, batería inflada.'),(3,'2025-08-03 22:16:46',3,3,3,'Mantenimiento, recarga de tinta.'),(4,'2025-08-03 22:16:46',4,4,4,'Cambio de disco duro a una SSD, instalacion de sistema operativo.'),(5,'2025-08-03 22:16:46',5,5,5,'Cambio de bambas de agua, cambio de capacitor.');
/*!40000 ALTER TABLE `diagnostico_tecnico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnosticos`
--

DROP TABLE IF EXISTS `diagnosticos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnosticos` (
  `diagnostico_id` int NOT NULL AUTO_INCREMENT,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `cliente_id` int NOT NULL,
  `aparato_id` int NOT NULL,
  `diagnostico` text NOT NULL,
  PRIMARY KEY (`diagnostico_id`),
  KEY `idx_diagnosticos_aparato_id` (`aparato_id`),
  KEY `idx_diagnosticos_cliente_id` (`cliente_id`),
  KEY `idx_diagnostico_cliente_aparato` (`cliente_id`,`aparato_id`),
  CONSTRAINT `diagnosticos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `diagnosticos_ibfk_2` FOREIGN KEY (`aparato_id`) REFERENCES `aparatos` (`aparato_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnosticos`
--

LOCK TABLES `diagnosticos` WRITE;
/*!40000 ALTER TABLE `diagnosticos` DISABLE KEYS */;
INSERT INTO `diagnosticos` VALUES (1,'2025-08-03 22:16:46',1,1,'El motor no gira correctamente.'),(2,'2025-08-03 22:16:46',2,2,'Pantalla rota, no enciende.'),(3,'2025-08-03 22:16:46',3,3,'Mantenimiento, rellenar la tinta'),(4,'2025-08-03 22:16:46',4,4,'Formateo , esta muy lenta'),(5,'2025-08-03 22:16:46',5,5,'No sale agua, No arranca el motor');
/*!40000 ALTER TABLE `diagnosticos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidades`
--

DROP TABLE IF EXISTS `especialidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especialidades` (
  `especialidad_id` int NOT NULL AUTO_INCREMENT,
  `especialidad` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`especialidad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidades`
--

LOCK TABLES `especialidades` WRITE;
/*!40000 ALTER TABLE `especialidades` DISABLE KEYS */;
INSERT INTO `especialidades` VALUES (1,'Electrodomésticos'),(2,'Celulares'),(3,'Televisiones'),(4,'Laptop'),(5,'Linea Blanca'),(6,'Software'),(7,'PC');
/*!40000 ALTER TABLE `especialidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `herramientas`
--

DROP TABLE IF EXISTS `herramientas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `herramientas` (
  `herramientas_id` int NOT NULL AUTO_INCREMENT,
  `fecha_registros` datetime DEFAULT CURRENT_TIMESTAMP,
  `nombre` varchar(100) NOT NULL,
  `estado` enum('Bueno','Medio','Malo') DEFAULT NULL,
  PRIMARY KEY (`herramientas_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `herramientas`
--

LOCK TABLES `herramientas` WRITE;
/*!40000 ALTER TABLE `herramientas` DISABLE KEYS */;
INSERT INTO `herramientas` VALUES (1,'2025-08-03 22:16:46','Destornillador eléctrico','Bueno'),(2,'2025-08-03 22:16:46','Destornillador','Malo'),(3,'2025-08-03 22:16:46','Multímetro digital','Bueno'),(4,'2025-08-03 22:16:46','Soldador','Medio'),(5,'2025-08-03 22:16:46','Cable tipo mirco USB','Medio'),(6,'2025-08-03 22:16:46','Pinza de precisión','Bueno');
/*!40000 ALTER TABLE `herramientas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_ordenes_trabajo`
--

DROP TABLE IF EXISTS `historial_ordenes_trabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_ordenes_trabajo` (
  `historial_id` int NOT NULL AUTO_INCREMENT,
  `orden_id` int DEFAULT NULL,
  `personal_anterior` int DEFAULT NULL,
  `personal_nuevo` int DEFAULT NULL,
  `diagnostico_anterior` int DEFAULT NULL,
  `diagnostico_nuevo` int DEFAULT NULL,
  `fecha_cambio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_bd` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`historial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_ordenes_trabajo`
--

LOCK TABLES `historial_ordenes_trabajo` WRITE;
/*!40000 ALTER TABLE `historial_ordenes_trabajo` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_ordenes_trabajo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_precios`
--

DROP TABLE IF EXISTS `historial_precios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_precios` (
  `historial_id` int NOT NULL AUTO_INCREMENT,
  `precio_id` int DEFAULT NULL,
  `aparato_id` int DEFAULT NULL,
  `cliente_id` int DEFAULT NULL,
  `precio_anterior` decimal(10,2) DEFAULT NULL,
  `nuevo_precio` decimal(10,2) DEFAULT NULL,
  `fecha_cambio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`historial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_precios`
--

LOCK TABLES `historial_precios` WRITE;
/*!40000 ALTER TABLE `historial_precios` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_precios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones_simuladas`
--

DROP TABLE IF EXISTS `notificaciones_simuladas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificaciones_simuladas` (
  `notificacion_id` int NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `accion` text,
  `usuario` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`notificacion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones_simuladas`
--

LOCK TABLES `notificaciones_simuladas` WRITE;
/*!40000 ALTER TABLE `notificaciones_simuladas` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificaciones_simuladas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_reparacion`
--

DROP TABLE IF EXISTS `ordenes_reparacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes_reparacion` (
  `orden_r_id` int NOT NULL AUTO_INCREMENT,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `reparacion_id` int DEFAULT NULL,
  `ordenes_t_id` int DEFAULT NULL,
  `precio_id` int DEFAULT NULL,
  `forma_pago` enum('Efectivo','Trasferencia') DEFAULT NULL,
  `estado_pago` enum('Pagado','No Pagado') DEFAULT NULL,
  PRIMARY KEY (`orden_r_id`),
  KEY `ordenes_t_id` (`ordenes_t_id`),
  KEY `precio_id` (`precio_id`),
  KEY `idx_ordenes_reparacion_estado_pago` (`estado_pago`),
  KEY `idx_ordenes_reparacion_reparacion_precio` (`reparacion_id`,`precio_id`),
  CONSTRAINT `ordenes_reparacion_ibfk_1` FOREIGN KEY (`ordenes_t_id`) REFERENCES `ordenes_tecnicos` (`ordenes_t_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ordenes_reparacion_ibfk_2` FOREIGN KEY (`reparacion_id`) REFERENCES `reparaciones` (`reparacion_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ordenes_reparacion_ibfk_3` FOREIGN KEY (`precio_id`) REFERENCES `precio` (`precio_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_reparacion`
--

LOCK TABLES `ordenes_reparacion` WRITE;
/*!40000 ALTER TABLE `ordenes_reparacion` DISABLE KEYS */;
INSERT INTO `ordenes_reparacion` VALUES (1,'2025-08-03 22:16:46',1,1,1,'Efectivo','Pagado'),(2,'2025-08-03 22:16:46',2,2,2,NULL,'No Pagado'),(3,'2025-08-03 22:16:46',3,3,3,'Trasferencia','Pagado'),(4,'2025-08-03 22:16:46',4,4,4,NULL,'No Pagado'),(5,'2025-08-03 22:16:46',5,5,5,'Efectivo','Pagado');
/*!40000 ALTER TABLE `ordenes_reparacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `notificar_orden_pago` AFTER INSERT ON `ordenes_reparacion` FOR EACH ROW begin
    insert into notificaciones_simuladas(accion, usuario)
    values (concat('Se generó una orden de reparación para el cliente en orden ID: ', new.orden_r_id), current_user());
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ordenes_tecnicos`
--

DROP TABLE IF EXISTS `ordenes_tecnicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes_tecnicos` (
  `ordenes_t_id` int NOT NULL AUTO_INCREMENT,
  `orden_id` int DEFAULT NULL,
  `personal_id` int DEFAULT NULL,
  PRIMARY KEY (`ordenes_t_id`),
  KEY `personal_id` (`personal_id`),
  KEY `idx_ordenes_tecnicos_orden_personal` (`orden_id`,`personal_id`),
  CONSTRAINT `ordenes_tecnicos_ibfk_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes_trabajo` (`orden_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ordenes_tecnicos_ibfk_2` FOREIGN KEY (`personal_id`) REFERENCES `personal` (`personal_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_tecnicos`
--

LOCK TABLES `ordenes_tecnicos` WRITE;
/*!40000 ALTER TABLE `ordenes_tecnicos` DISABLE KEYS */;
INSERT INTO `ordenes_tecnicos` VALUES (1,1,5),(2,2,4),(3,3,1),(4,4,1),(5,5,5);
/*!40000 ALTER TABLE `ordenes_tecnicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_trabajo`
--

DROP TABLE IF EXISTS `ordenes_trabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes_trabajo` (
  `orden_id` int NOT NULL AUTO_INCREMENT,
  `fecha_orden` datetime DEFAULT CURRENT_TIMESTAMP,
  `cliente_id` int NOT NULL,
  `aparato_id` int NOT NULL,
  `personal_id` int DEFAULT NULL,
  `diagnostico_id` int DEFAULT NULL,
  PRIMARY KEY (`orden_id`),
  KEY `personal_id` (`personal_id`),
  KEY `diagnostico_id` (`diagnostico_id`),
  KEY `idx_ordenes_trabajo_cliente_id` (`cliente_id`),
  KEY `idx_ordenes_trabajo_aparato_id` (`aparato_id`),
  KEY `idx_ordenes_trabajo_cliente_aparato` (`cliente_id`,`aparato_id`),
  CONSTRAINT `ordenes_trabajo_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ordenes_trabajo_ibfk_2` FOREIGN KEY (`aparato_id`) REFERENCES `aparatos` (`aparato_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ordenes_trabajo_ibfk_3` FOREIGN KEY (`personal_id`) REFERENCES `personal` (`personal_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ordenes_trabajo_ibfk_4` FOREIGN KEY (`diagnostico_id`) REFERENCES `diagnosticos` (`diagnostico_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_trabajo`
--

LOCK TABLES `ordenes_trabajo` WRITE;
/*!40000 ALTER TABLE `ordenes_trabajo` DISABLE KEYS */;
INSERT INTO `ordenes_trabajo` VALUES (1,'2025-08-03 22:16:46',1,1,2,1),(2,'2025-08-03 22:16:46',2,2,3,2),(3,'2025-08-03 22:16:46',3,3,2,3),(4,'2025-08-03 22:16:46',4,4,3,4),(5,'2025-08-03 22:16:46',5,5,3,5);
/*!40000 ALTER TABLE `ordenes_trabajo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `historial_update_orden_trabajo` BEFORE UPDATE ON `ordenes_trabajo` FOR EACH ROW begin
    if old.personal_id <> new.personal_id or old.diagnostico_id <> new.diagnostico_id then
        insert into historial_ordenes_trabajo(
            orden_id,
            personal_anterior, personal_nuevo,
            diagnostico_anterior, diagnostico_nuevo,
            usuario_bd
        )
        values (
            old.orden_id,
            old.personal_id, new.personal_id,
            old.diagnostico_id, new.diagnostico_id,
            current_user()
        );
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pagos_ingresados`
--

DROP TABLE IF EXISTS `pagos_ingresados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos_ingresados` (
  `pagos_i_id` int NOT NULL AUTO_INCREMENT,
  `fecha_registros` datetime DEFAULT CURRENT_TIMESTAMP,
  `orden_r_id` int DEFAULT NULL,
  `pagos_i` decimal(10,2) DEFAULT NULL,
  `forma_pago` enum('Efectivo','Trasferencia') DEFAULT NULL,
  PRIMARY KEY (`pagos_i_id`),
  KEY `idx_pagos_ingresados_orden_r_id` (`orden_r_id`),
  CONSTRAINT `pagos_ingresados_ibfk_1` FOREIGN KEY (`orden_r_id`) REFERENCES `ordenes_reparacion` (`orden_r_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pagos_ingresados_chk_1` CHECK ((`pagos_i` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos_ingresados`
--

LOCK TABLES `pagos_ingresados` WRITE;
/*!40000 ALTER TABLE `pagos_ingresados` DISABLE KEYS */;
INSERT INTO `pagos_ingresados` VALUES (1,'2025-08-03 22:16:46',1,40.00,'Efectivo'),(2,'2025-08-03 22:16:46',3,55.00,'Trasferencia'),(3,'2025-08-03 22:16:46',5,75.00,'Efectivo');
/*!40000 ALTER TABLE `pagos_ingresados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal`
--

DROP TABLE IF EXISTS `personal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal` (
  `personal_id` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `rol` enum('Secretario','Tecnico') NOT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  PRIMARY KEY (`personal_id`),
  KEY `idx_personal_rol` (`rol`),
  KEY `idx_personal_estado` (`estado`),
  KEY `idx_personal_nombre_apellido` (`nombres`,`apellidos`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal`
--

LOCK TABLES `personal` WRITE;
/*!40000 ALTER TABLE `personal` DISABLE KEYS */;
INSERT INTO `personal` VALUES (1,'Ivan Andres','Castillo Caiza','09982158101','ivan.castillo@centrotecnico.com','Tecnico','Activo'),(2,'Rocio Elizabeth','Caiza Perez','0988123456','rocio.caiza@centrotecnico.com','Secretario','Activo'),(3,'Kerly Daniela','Catillo Caiza','0975178956','kerly.castillo@centrotecnico.com','Secretario','Activo'),(4,'Ismael Francisco','Castillo Caiza','0993728381','ismael.castillo@centrotecnico.com','Tecnico','Activo'),(5,'Norge Ivan','Castillo Nunez','0993728712','norge.castillo@centrotecnico.com','Tecnico','Activo');
/*!40000 ALTER TABLE `personal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_especialidades`
--

DROP TABLE IF EXISTS `personal_especialidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_especialidades` (
  `personal_id` int NOT NULL,
  `especialidad_id` int NOT NULL,
  PRIMARY KEY (`personal_id`,`especialidad_id`),
  KEY `especialidad_id` (`especialidad_id`),
  CONSTRAINT `personal_especialidades_ibfk_1` FOREIGN KEY (`personal_id`) REFERENCES `personal` (`personal_id`),
  CONSTRAINT `personal_especialidades_ibfk_2` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidades` (`especialidad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_especialidades`
--

LOCK TABLES `personal_especialidades` WRITE;
/*!40000 ALTER TABLE `personal_especialidades` DISABLE KEYS */;
INSERT INTO `personal_especialidades` VALUES (1,1),(5,1),(4,2),(1,3),(5,3),(1,4),(1,5),(5,5),(1,6),(4,6),(1,7);
/*!40000 ALTER TABLE `personal_especialidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peticion_a_domicilio`
--

DROP TABLE IF EXISTS `peticion_a_domicilio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peticion_a_domicilio` (
  `peticion_id` int NOT NULL AUTO_INCREMENT,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `cliente_domi_id` int DEFAULT NULL,
  `aparato_domi_id` int DEFAULT NULL,
  PRIMARY KEY (`peticion_id`),
  KEY `cliente_domi_id` (`cliente_domi_id`),
  KEY `aparato_domi_id` (`aparato_domi_id`),
  CONSTRAINT `peticion_a_domicilio_ibfk_1` FOREIGN KEY (`cliente_domi_id`) REFERENCES `clientes_domicilio` (`cliente_domi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `peticion_a_domicilio_ibfk_2` FOREIGN KEY (`aparato_domi_id`) REFERENCES `aparatos_domicilio` (`aparato_domi_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peticion_a_domicilio`
--

LOCK TABLES `peticion_a_domicilio` WRITE;
/*!40000 ALTER TABLE `peticion_a_domicilio` DISABLE KEYS */;
INSERT INTO `peticion_a_domicilio` VALUES (1,'2025-08-03 22:16:46',1,1),(2,'2025-08-03 22:16:46',2,2);
/*!40000 ALTER TABLE `peticion_a_domicilio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `precio`
--

DROP TABLE IF EXISTS `precio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `precio` (
  `precio_id` int NOT NULL AUTO_INCREMENT,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `cliente_id` int DEFAULT NULL,
  `aparato_id` int DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`precio_id`),
  KEY `idx_precio_aparato_id` (`aparato_id`),
  KEY `idx_precio_cliente_aparato` (`cliente_id`,`aparato_id`),
  CONSTRAINT `precio_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `precio_ibfk_2` FOREIGN KEY (`aparato_id`) REFERENCES `aparatos` (`aparato_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `precio_chk_1` CHECK ((`precio` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `precio`
--

LOCK TABLES `precio` WRITE;
/*!40000 ALTER TABLE `precio` DISABLE KEYS */;
INSERT INTO `precio` VALUES (1,'2025-08-03 22:16:46',1,1,40.00),(2,'2025-08-03 22:16:46',2,2,75.00),(3,'2025-08-03 22:16:46',3,3,55.00),(4,'2025-08-03 22:16:46',4,4,70.00),(5,'2025-08-03 22:16:46',5,5,75.00);
/*!40000 ALTER TABLE `precio` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `historial_cambios_precio` BEFORE UPDATE ON `precio` FOR EACH ROW begin
    if old.precio <> new.precio then
        insert into historial_precios(precio_id, aparato_id, cliente_id, precio_anterior, nuevo_precio, usuario)
        values (old.precio_id, old.aparato_id, old.cliente_id, old.precio, new.precio, current_user());
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reparaciones`
--

DROP TABLE IF EXISTS `reparaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reparaciones` (
  `reparacion_id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `aparato_id` int NOT NULL,
  `ordenes_t_id` int DEFAULT NULL,
  `diagnostico_t_id` int DEFAULT NULL,
  PRIMARY KEY (`reparacion_id`),
  KEY `ordenes_t_id` (`ordenes_t_id`),
  KEY `diagnostico_t_id` (`diagnostico_t_id`),
  KEY `idx_reparaciones_cliente_id` (`cliente_id`),
  KEY `idx_reparaciones_aparato_id` (`aparato_id`),
  KEY `idx_reparaciones_cliente_aparato` (`cliente_id`,`aparato_id`),
  CONSTRAINT `reparaciones_ibfk_1` FOREIGN KEY (`ordenes_t_id`) REFERENCES `ordenes_tecnicos` (`ordenes_t_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reparaciones_ibfk_2` FOREIGN KEY (`aparato_id`) REFERENCES `aparatos` (`aparato_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reparaciones_ibfk_3` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reparaciones_ibfk_4` FOREIGN KEY (`diagnostico_t_id`) REFERENCES `diagnostico_tecnico` (`diagnostico_t_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reparaciones`
--

LOCK TABLES `reparaciones` WRITE;
/*!40000 ALTER TABLE `reparaciones` DISABLE KEYS */;
INSERT INTO `reparaciones` VALUES (1,1,1,1,1),(2,2,2,2,2),(3,3,3,3,3),(4,4,4,4,4),(5,5,5,5,5);
/*!40000 ALTER TABLE `reparaciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `auditoria_insert_reparacion` AFTER INSERT ON `reparaciones` FOR EACH ROW begin
    insert into auditoria_reparaciones(
        reparacion_id, cliente_id, aparato_id, tecnico_id, usuario_bd, descripcion
    )
    values (
        new.reparacion_id, new.cliente_id, new.aparato_id, new.ordenes_t_id,
        current_user(),
        concat('Se registró una nueva reparación con ID ', new.reparacion_id)
    );
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `repuestos`
--

DROP TABLE IF EXISTS `repuestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repuestos` (
  `repuesto_id` int NOT NULL AUTO_INCREMENT,
  `fecha_ingreso_repuesto` datetime DEFAULT CURRENT_TIMESTAMP,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  PRIMARY KEY (`repuesto_id`),
  KEY `idx_repuestos_nombre` (`nombre`),
  KEY `idx_repuestos_stock` (`stock`),
  CONSTRAINT `repuestos_chk_1` CHECK ((`precio` >= 0)),
  CONSTRAINT `repuestos_chk_2` CHECK ((`stock` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repuestos`
--

LOCK TABLES `repuestos` WRITE;
/*!40000 ALTER TABLE `repuestos` DISABLE KEYS */;
INSERT INTO `repuestos` VALUES (1,'2025-08-03 22:16:46','Motor Oster','Motor compatible con licuadora Oster',25.50,10),(2,'2025-08-03 22:16:46','Pantalla Samsung A21s','Repuesto original',35.00,9),(3,'2025-08-03 22:16:46','Bateria Samsung A21s','Repuesto original',15.00,12),(4,'2025-08-03 22:16:46','Pack tintas de impresora','Repuesto original',20.00,8),(5,'2025-08-03 22:16:46','Disco Duro SSD','Repuesto original',45.00,7),(6,'2025-08-03 22:16:46','Bombas de Agua','Repuesto original',35.00,6),(7,'2025-08-03 22:16:46','Capacitor lg','Repuesto original',10.00,5);
/*!40000 ALTER TABLE `repuestos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repuestos_usados`
--

DROP TABLE IF EXISTS `repuestos_usados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repuestos_usados` (
  `id_repuesto_u` int NOT NULL AUTO_INCREMENT,
  `reparacion_id` int DEFAULT NULL,
  `repuesto_id` int DEFAULT NULL,
  `cantidad` int DEFAULT '1',
  PRIMARY KEY (`id_repuesto_u`),
  KEY `repuesto_id` (`repuesto_id`),
  KEY `idx_repuestos_usados_reparacion_repuesto` (`reparacion_id`,`repuesto_id`),
  CONSTRAINT `repuestos_usados_ibfk_1` FOREIGN KEY (`repuesto_id`) REFERENCES `repuestos` (`repuesto_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `repuestos_usados_ibfk_2` FOREIGN KEY (`reparacion_id`) REFERENCES `reparaciones` (`reparacion_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repuestos_usados`
--

LOCK TABLES `repuestos_usados` WRITE;
/*!40000 ALTER TABLE `repuestos_usados` DISABLE KEYS */;
INSERT INTO `repuestos_usados` VALUES (1,1,1,1),(2,2,2,1),(3,2,3,1),(4,3,4,1),(5,4,5,1),(6,5,6,1),(7,5,7,1);
/*!40000 ALTER TABLE `repuestos_usados` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `controlar_stock_repuestos` BEFORE INSERT ON `repuestos_usados` FOR EACH ROW begin
    declare stock_actual int;

    select stock into stock_actual from repuestos where repuesto_id = new.repuesto_id;

    if stock_actual < new.cantidad then
        signal sqlstate '45000' set message_text = 'Stock insuficiente para este repuesto.';
    else
        update repuestos set stock = stock - new.cantidad where repuesto_id = new.repuesto_id;
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `usuario_id` int NOT NULL AUTO_INCREMENT,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `usuario` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `rol` enum('Administrador','Tecnico','Secretario') NOT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  PRIMARY KEY (`usuario_id`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `idx_usuarios_usuario` (`usuario`),
  KEY `idx_usuarios_usuario_rol` (`usuario`,`rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'2025-08-03 22:16:46','admin','admin123','Administrador','Activo'),(2,'2025-08-03 22:16:46','ivan_tecnico','tecnicopass','Tecnico','Activo'),(3,'2025-08-03 22:16:46','rocio_secret','secretario123','Secretario','Activo');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `auditoria_insert_usuario` AFTER INSERT ON `usuarios` FOR EACH ROW begin
    insert into auditoria_usuarios(tipo_accion, usuario_afectado, rol, usuario_bd, descripcion)
    values ('INSERT', new.usuario, new.rol, current_user(), concat('Nuevo usuario agregado: ', new.usuario));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `auditoria_update_usuario` AFTER UPDATE ON `usuarios` FOR EACH ROW begin
    insert into auditoria_usuarios(tipo_accion, usuario_afectado, rol, usuario_bd, descripcion)
    values ('UPDATE', new.usuario, new.rol, current_user(), concat('Usuario actualizado: ', new.usuario));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `auditoria_delete_usuario` AFTER DELETE ON `usuarios` FOR EACH ROW begin
    insert into auditoria_usuarios(tipo_accion, usuario_afectado, rol, usuario_bd, descripcion)
    values ('DELETE', old.usuario, old.rol, current_user(), concat('Usuario eliminado: ', old.usuario));
end */;;
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

-- Dump completed on 2025-08-04  7:58:19
