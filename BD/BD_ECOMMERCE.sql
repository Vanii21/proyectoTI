-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         11.3.1-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para ecommerce
DROP DATABASE IF EXISTS `ecommerce`;
CREATE DATABASE IF NOT EXISTS `ecommerce` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `ecommerce`;

-- Volcando estructura para tabla ecommerce.articulo
DROP TABLE IF EXISTS `articulo`;
CREATE TABLE IF NOT EXISTS `articulo` (
  `id_articulo` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `ruta` varchar(150) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `categoria_id_categoria` smallint(6) NOT NULL,
  PRIMARY KEY (`id_articulo`),
  KEY `articulo_categoria_fk` (`categoria_id_categoria`),
  CONSTRAINT `articulo_categoria_fk` FOREIGN KEY (`categoria_id_categoria`) REFERENCES `categoria` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla ecommerce.articulo: ~31 rows (aproximadamente)
INSERT INTO `articulo` (`id_articulo`, `nombre`, `precio`, `ruta`, `stock`, `descripcion`, `categoria_id_categoria`) VALUES
	(1, 'Batean', 400.95, '/img/articulos/img.jpg', 96, 'Un vestido elegante y atrevido', 1),
	(2, 'Zoxtrex Femina', 150.00, '/img/articulos/img1.jpg', 97, 'Ropa elegante para mujer', 1),
	(3, 'Luminaria Mystica', 250.00, '/img/articulos/img2.jpg', 97, 'Moda femenina de calidad', 1),
	(4, 'Astralium Damsel', 350.00, '/img/articulos/img3.jpg', 20, 'Estilo único para mujeres', 1),
	(5, 'Galactica Verve', 200.00, '/img/articulos/img4.jpg', 12, 'Ropa moderna para mujer', 1),
	(6, 'Phantom Garb', 120.00, '/img/articulos/img11.jpg', 12, 'Ropa casual para hombres', 2),
	(7, 'Nebulon Mode', 220.00, '/img/articulos/img12.jpg', 18, 'Estilo moderno para hombres', 2),
	(8, 'Vortex Attire', 320.00, '/img/articulos/img13.jpg', 24, 'Moda masculina de calidad', 2),
	(9, 'Apex Ensemble', 180.00, '/img/articulos/img14.jpg', 19, 'Conjunto moderno para hombre', 2),
	(10, 'Radiant Elegance', 240.00, '/img/articulos/img15.jpg', 16, 'Elegancia radiante para hombre', 2),
	(11, 'Blithe Whimsy', 180.00, '/img/articulos/img22.jpg', 14, 'Moda infantil cómoda', 3),
	(12, 'Frolicsome Peculiarity', 280.00, '/img/articulos/img23.jpg', 22, 'Estilo único para niños', 3),
	(13, 'Merry Melange', 120.00, '/img/articulos/img24.jpg', 16, 'Mezcla alegre para niños', 3),
	(14, 'Joyous Attire', 150.00, '/img/articulos/img25.jpg', 12, 'Ropa alegre para niños', 3),
	(15, 'Whimsical Charm', 200.00, '/img/articulos/img26.jpg', 18, 'Encanto caprichoso para niños', 3),
	(16, 'Cheerful Ensemble', 250.00, '/img/articulos/img27.jpg', 20, 'Conjunto alegre para niños', 3),
	(17, 'Celestia Attire', 180.00, '/img/articulos/img5.jpg', 18, 'Moda cómoda y elegante', 1),
	(18, 'Luminous Charm', 300.00, '/img/articulos/img6.jpg', 14, 'Ropa encantadora para mujer', 1),
	(19, 'Mystique Elegance', 280.00, '/img/articulos/img7.jpg', 16, 'Estilo misterioso para mujeres', 1),
	(20, 'Enigma Couture', 320.00, '/img/articulos/img8.jpg', 20, 'Moda enigmática para mujer', 1),
	(21, 'Eclipse Ensemble', 260.00, '/img/articulos/img9.jpg', 22, 'Conjunto elegante para mujer', 1),
	(22, 'Aurora Chic', 180.00, '/img/articulos/img10.jpg', 18, 'Estilo chic para mujer', 1),
	(23, 'Playful Gear', 180.00, '/img/articulos/img28.jpg', 14, 'Equipo juguetón para niños', 3),
	(24, 'Sprightly Fashion', 220.00, '/img/articulos/img29.jpg', 16, 'Moda vivaz para niños', 3),
	(25, 'Youthful Style', 200.00, '/img/articulos/img30.jpg', 18, 'Estilo juvenil para niños', 3),
	(26, 'Zenith Attire', 280.00, '/img/articulos/img16.jpg', 14, 'Ropa de calidad para hombre', 2),
	(27, 'Mystic Charm', 300.00, '/img/articulos/img17.jpg', 21, 'Encanto místico para hombre', 2),
	(28, 'Eclipse Elegance', 260.00, '/img/articulos/img18.jpg', 18, 'Elegancia eclipsante para hombre', 2),
	(29, 'Solaris Style', 340.00, '/img/articulos/img19.jpg', 24, 'Estilo solar para hombre', 2),
	(30, 'Lunar Ensemble', 280.00, '/img/articulos/img20.jpg', 20, 'Conjunto lunar para hombre', 2),
	(31, 'Jovial Sprite', 80.00, '/img/articulos/img21.jpg', 8, 'Ropa divertida para joven adulto', 2);

-- Volcando estructura para tabla ecommerce.categoria
DROP TABLE IF EXISTS `categoria`;
CREATE TABLE IF NOT EXISTS `categoria` (
  `id_categoria` smallint(6) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla ecommerce.categoria: ~2 rows (aproximadamente)
INSERT INTO `categoria` (`id_categoria`, `nombre`, `descripcion`) VALUES
	(1, 'Mujer', 'Para mujeres entre 18 y 50'),
	(2, 'Hombre', 'Para hombre entre 18 y 50'),
	(3, 'Niños', 'Para niños entre 3 y 13');

-- Volcando estructura para tabla ecommerce.departamento
DROP TABLE IF EXISTS `departamento`;
CREATE TABLE IF NOT EXISTS `departamento` (
  `id_departamento` smallint(6) NOT NULL,
  `nombre_departamento` varchar(50) NOT NULL,
  PRIMARY KEY (`id_departamento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla ecommerce.departamento: ~4 rows (aproximadamente)
INSERT INTO `departamento` (`id_departamento`, `nombre_departamento`) VALUES
	(1, 'Guatemala'),
	(2, 'Peten'),
	(3, 'Solola'),
	(4, 'Huehuetenango');

-- Volcando estructura para tabla ecommerce.detalle_venta
DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE IF NOT EXISTS `detalle_venta` (
  `articulo_id_articulo` int(11) NOT NULL,
  `venta_id_venta` int(11) NOT NULL,
  PRIMARY KEY (`articulo_id_articulo`,`venta_id_venta`),
  KEY `detalle_venta_venta_fk` (`venta_id_venta`),
  CONSTRAINT `detalle_venta_articulo_fk` FOREIGN KEY (`articulo_id_articulo`) REFERENCES `articulo` (`id_articulo`),
  CONSTRAINT `detalle_venta_venta_fk` FOREIGN KEY (`venta_id_venta`) REFERENCES `venta` (`id_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla ecommerce.detalle_venta: ~0 rows (aproximadamente)

-- Volcando estructura para tabla ecommerce.usuario
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(30) NOT NULL,
  `clave` varchar(8) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `departamento_id_departamento` smallint(6) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `usuario_departamento_fk` (`departamento_id_departamento`),
  CONSTRAINT `usuario_departamento_fk` FOREIGN KEY (`departamento_id_departamento`) REFERENCES `departamento` (`id_departamento`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla ecommerce.usuario: ~2 rows (aproximadamente)
INSERT INTO `usuario` (`id_usuario`, `usuario`, `clave`, `email`, `nombre`, `departamento_id_departamento`) VALUES
	(1, 'Vanii', '1234', 'vaniialcantara58@gmail.com', 'Vanii Alcantara', 1);

-- Volcando estructura para tabla ecommerce.venta
DROP TABLE IF EXISTS `venta`;
CREATE TABLE IF NOT EXISTS `venta` (
  `id_venta` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_venta` date NOT NULL,
  `total` decimal(11,2) NOT NULL,
  `usuario_id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `venta_usuario_fk` (`usuario_id_usuario`),
  CONSTRAINT `venta_usuario_fk` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla ecommerce.venta: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
