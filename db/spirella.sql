-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 14, 2022 at 02:08 AM
-- Server version: 5.7.34
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grazia`
--

-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'Camisa de Temporada', 'Camisas en oferta de esta temporada', 1);

-- --------------------------------------------------------

--
-- Table structure for table `compra`
--

CREATE TABLE `compra` (
  `idcompra` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` int(11) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` int(11) NOT NULL,
  `total_compra` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `compra`
--

INSERT INTO `compra` (`idcompra`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_compra`, `estado`) VALUES
(20, 1, 1, 1, '1234', '233', '2022-05-23 00:00:00', 2, '1100.00', 'Aceptado'),
(21, 1, 1, 1, '23100', '23100', '2022-05-23 00:00:00', 2, '1200.00', 'Aceptado'),
(22, 1, 1, 1, '12', '234943', '2022-04-05 00:00:00', 1, '1300.00', 'Aceptado'),
(23, 1, 13, 2, '1', '2323', '2022-05-26 00:00:00', 2, '1200.00', 'Aceptado'),
(24, 1, 13, 3, '12', '1234', '2022-05-25 00:00:00', 1, '500.00', 'Aceptado');

-- --------------------------------------------------------

--
-- Table structure for table `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `iddetalle_compra` int(11) NOT NULL,
  `idcompra` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detalle_compra`
--

INSERT INTO `detalle_compra` (`iddetalle_compra`, `idcompra`, `idproducto`, `cantidad`, `precio_compra`, `precio_venta`) VALUES
(1, 21, 2, 10, '120.00', '130.00'),
(2, 22, 6, 10, '130.00', '140.00'),
(3, 23, 1, 10, '120.00', '130.00'),
(4, 24, 6, 5, '100.00', '110.00');

--
-- Triggers `detalle_compra`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockcompra` AFTER INSERT ON `detalle_compra` FOR EACH ROW BEGIN
 UPDATE producto SET stock = stock + NEW.cantidad 
 WHERE producto.idproducto = NEW.idproducto;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `iddetalle_venta` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detalle_venta`
--

INSERT INTO `detalle_venta` (`iddetalle_venta`, `idventa`, `idproducto`, `cantidad`, `precio_venta`, `descuento`) VALUES
(1, 31, 1, 2, '230.00', '10.00'),
(2, 43, 1, 2, '130.00', '10.00'),
(3, 43, 2, 1, '130.00', '9.00'),
(4, 50, 6, 1, '110.00', '0.00'),
(5, 50, 5, 10, '122.00', '0.00'),
(6, 51, 1, 1, '130.00', '0.00');

--
-- Triggers `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
 UPDATE producto SET stock = stock - NEW.cantidad 
 WHERE producto.idproducto = NEW.idproducto;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `impuesto`
--

CREATE TABLE `impuesto` (
  `id_impuesto` int(11) NOT NULL,
  `nombre_impuesto` varchar(30) NOT NULL,
  `monto_impuesto` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `impuesto`
--

INSERT INTO `impuesto` (`id_impuesto`, `nombre_impuesto`, `monto_impuesto`) VALUES
(1, 'IGV', '0.18'),
(2, 'RUS', '0.00');

-- --------------------------------------------------------

--
-- Table structure for table `marca`
--

CREATE TABLE `marca` (
  `idmarca` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `marca`
--

INSERT INTO `marca` (`idmarca`, `nombre`, `descripcion`, `condicion`) VALUES
(2, 'Lacoste', 'Empresa que fabrica prendas de calidad', 1),
(3, 'Hollister', 'Marca de ropa estilo americano', 1);

-- --------------------------------------------------------

--
-- Table structure for table `permiso`
--

CREATE TABLE `permiso` (
  `idpermiso` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `permiso`
--

INSERT INTO `permiso` (`idpermiso`, `nombre`) VALUES
(1, 'Escritorio'),
(2, 'Almacen'),
(3, 'Compras'),
(4, 'Ventas'),
(5, 'Acceso'),
(6, 'Consulta Compras'),
(7, 'Consulta Ventas');

-- --------------------------------------------------------

--
-- Table structure for table `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` int(11) NOT NULL,
  `num_documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(40) DEFAULT NULL,
  `zona` int(11) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `zona`, `telefono`, `email`) VALUES
(1, 2, 'Tiendas Gamarra', 1, '2047715777', 'Av 134', 2, '931742904', 'gamarra@gmail.com'),
(2, 1, 'Público en general', 1, '12345678', '0', 1, '96321478', 'publicogeneral@gmail.com'),
(3, 1, 'Pedro Gomez', 1, '299399239', '0', 1, '931742904', 'juaistopher7@hotmail.com'),
(4, 2, 'Jorge Gomez', 1, '23659874', 'av prueba', 1, '9168844500', 'vendedero@prueba.com'),
(6, 1, 'Juan Gomez', 1, '47715777', '0', 1, '9168844500', 'vendedero@prueba.com'),
(7, 1, 'Luis  perez', 1, '47715777', 'juan g1260', 3, '9168844500', 'vendedero@prueba.com'),
(8, 2, 'Proveedor', 1, '7044438', 'Av 123 1260', 1, '9168844500', 'proveedor@prueba.com'),
(9, 1, 'Juan Rodriguez', 2, '23659874', 'Calle las verdolagas s/n', 2, '98444737', 'palmachristopher7@gmail.com'),
(10, 1, 'Movil', 3, 'null', 'null', 0, 'null', 'null'),
(11, 1, 'preuba', 2, '70399349', 'av 3232', 1, '2828282828', 'a@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `producto`
--

CREATE TABLE `producto` (
  `idproducto` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1',
  `idmarca` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `producto`
--

INSERT INTO `producto` (`idproducto`, `idcategoria`, `codigo`, `nombre`, `stock`, `descripcion`, `imagen`, `condicion`, `idmarca`) VALUES
(1, 1, '8523697412', 'Camisa Azul', 105, 'Camisa Hombre Azul tejido suave, manga larga con botones en los puños, cuello clásico, bolsillo en el pecho con botón,faldón redondeado,diseño a cuadros.', '1653278687.png', 1, 2),
(2, 1, '8523697412', 'Camisa Franela', 32, 'Camisa Hombre Franela tejido suave, manga larga con botones en los puños, cuello clásico, bolsillo en el pecho con botón,faldón redondeado,diseño a cuadros.', '1651357396.png', 1, 2),
(3, 1, '121221', 'Camisa Blanca', 52, 'Camisa Hombre color blanco tejido suave, manga larga , estilo clásico, diseño a formal.', '1653278679.png', 1, 2),
(4, 1, '12929339k', 'Camisa Mujer a Cuadros', 50, 'Camisa mujer a cuadros color blanco, diseño moderno', '', 1, 2),
(5, 1, '2013232', 'Camisa ploma', 35, 'Camisa ploma diseño elegante formal', '1653271650.png', 1, 3),
(6, 1, '292392', 'Camisa Mujer a rayas', 44, 'Camisa mujer a rayas, tejido suave, manga larga , cuello clásico, diseño redondeado', '1653272076.png', 1, 2),
(24, 1, '34323232', 'prueba', 61, 'Camisas en oferta de esta temporada', '', 1, 3),
(25, 1, '32323', 'producto de prueba', 23, 'prueba', '', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tipo_comprobante`
--

CREATE TABLE `tipo_comprobante` (
  `id_tipo_comprobante` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tipo_comprobante`
--

INSERT INTO `tipo_comprobante` (`id_tipo_comprobante`, `nombre`) VALUES
(1, 'Boleta'),
(2, 'Factura'),
(3, 'Ticket');

-- --------------------------------------------------------

--
-- Table structure for table `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `id_tipo_documento` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tipo_documento`
--

INSERT INTO `tipo_documento` (`id_tipo_documento`, `nombre`) VALUES
(1, 'DNI'),
(2, 'RUC'),
(3, 'OTROS');

-- --------------------------------------------------------

--
-- Table structure for table `tipo_persona`
--

CREATE TABLE `tipo_persona` (
  `id_tipo_persona` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tipo_persona`
--

INSERT INTO `tipo_persona` (`id_tipo_persona`, `nombre`) VALUES
(1, 'Cliente'),
(2, 'Proveedor');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` int(11) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cargo` int(11) DEFAULT NULL,
  `login` varchar(20) NOT NULL,
  `clave` varchar(64) NOT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `cargo`, `login`, `clave`, `imagen`, `condicion`) VALUES
(1, 'movil', 1, 'movil', 'movil', 'movil', 'movil', 1, 'movil', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1653444502.png', 1),
(2, 'Vendedor', 1, '23659874', 'Jose Gálvez 1260', '98414737', 'vendedero@prueba.com', 3, 'vendedor', 'e8827f3c0bcc90509b7d6841d446b163a671cac807a5f1bf41218667546ce80b', '1651366987.png', 1),
(3, 'Almacenero', 1, '7044438', 'Calle las verdolagas s/n', '98444737', 'palmachristopher7@gmail.com', 2, 'almacenero', '19b9e4b4b69db1c5c38ea802a1754b4059b4df98cf5213c9c566801b397a952a', '1651367032.JPG', 1),
(7, 'Christopher', 1, '47715777', 'Lima', '931742904', 'alexvilchez2@hotmail.com', 1, 'administrador', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1653444900.png', 1),
(13, 'Christopher Palma', 1, '70222864', 'movil', 'movil', 'palmachristopher7@hotmail.com', 1, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1653444900.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `usuario_permiso`
--

CREATE TABLE `usuario_permiso` (
  `idusuario_permiso` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idpermiso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuario_permiso`
--

INSERT INTO `usuario_permiso` (`idusuario_permiso`, `idusuario`, `idpermiso`) VALUES
(214, 3, 1),
(215, 3, 2),
(216, 3, 3),
(217, 3, 6),
(241, 2, 1),
(242, 2, 4),
(243, 2, 7),
(257, 13, 1),
(258, 13, 2),
(259, 13, 3),
(260, 13, 4),
(261, 13, 5),
(262, 13, 6),
(263, 13, 7),
(285, 1, 1),
(286, 1, 2),
(287, 1, 3),
(288, 1, 4),
(289, 1, 5),
(290, 1, 6),
(291, 1, 7),
(320, 7, 1),
(321, 7, 2),
(322, 7, 3),
(323, 7, 4),
(324, 7, 5),
(325, 7, 6),
(326, 7, 7);

-- --------------------------------------------------------

--
-- Table structure for table `usuario_rol`
--

CREATE TABLE `usuario_rol` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usuario_rol`
--

INSERT INTO `usuario_rol` (`id_rol`, `nombre`, `descripcion`) VALUES
(1, 'Administrador', 'Todos los privilegios'),
(2, 'Almacenero', 'Encargado de almacen'),
(3, 'Vendedor', 'Encargado de la venta');

-- --------------------------------------------------------

--
-- Table structure for table `venta`
--

CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` int(11) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` int(11) NOT NULL,
  `total_venta` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `venta`
--

INSERT INTO `venta` (`idventa`, `idcliente`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_venta`, `estado`) VALUES
(16, 2, 2, 1, '122', '1223', '2022-05-23 00:00:00', 2, '115.00', 'Anulado'),
(27, 10, 1, 1, 'movil', 'movil', '2022-05-24 18:44:15', 1, '184.00', 'Aceptado'),
(28, 10, 1, 1, 'movil', 'movil', '2022-05-24 18:45:10', 1, '184.00', 'Aceptado'),
(29, 10, 1, 3, 'movil', 'movil', '2022-05-24 18:50:47', 1, '651.00', 'Aceptado'),
(30, 10, 1, 1, 'movil', 'movil', '2022-05-24 18:52:04', 1, '110.00', 'Aceptado'),
(31, 2, 1, 1, '12', '1223', '2022-06-15 00:00:00', 2, '450.00', 'Anulado'),
(34, 10, 1, 1, 'movil', 'movil', '2022-05-24 22:06:45', 1, '110.00', 'Anulado'),
(35, 10, 1, 1, 'movil', 'movil', '2022-05-26 19:01:23', 1, '210.00', 'Anulado'),
(36, 10, 1, 1, 'movil', 'movil', '2022-05-26 19:25:14', 1, '250.00', 'Aceptado'),
(39, 10, 1, 3, '63', '6334', '2022-05-29 10:46:52', 1, '9999.00', 'Aceptado'),
(42, 10, 1, 3, '105', '8945', '2022-05-29 11:21:02', 1, '256.00', 'Aceptado'),
(43, 9, 1, 1, '12', '23232', '2022-05-29 00:00:00', 2, '371.00', 'Aceptado'),
(45, 10, 1, 1, 'movil', 'movil', '2022-05-31 19:52:40', 1, '139.00', 'Aceptado'),
(47, 10, 1, 3, '25', '2457', '2022-05-31 19:56:39', 1, '141.00', 'Aceptado'),
(48, 10, 1, 3, '29', '1109', '2022-05-31 20:15:51', 1, '256.00', 'Aceptado'),
(49, 10, 1, 3, '83', '4920', '2022-05-31 20:20:15', 1, '268.00', 'Aceptado'),
(50, 9, 13, 2, '232', '12334', '2022-11-04 00:00:00', 2, '1330.00', 'Aceptado'),
(51, 2, 13, 1, '23232', '232323', '2022-11-19 00:00:00', 1, '130.00', 'Aceptado');

-- --------------------------------------------------------

--
-- Table structure for table `zona`
--

CREATE TABLE `zona` (
  `id_zona` int(11) NOT NULL,
  `nombre_zona` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `zona`
--

INSERT INTO `zona` (`id_zona`, `nombre_zona`) VALUES
(0, 'Movil'),
(1, 'Centro'),
(2, 'Norte'),
(3, 'Sur'),
(4, 'Este'),
(5, 'Oeste');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indexes for table `compra`
--
ALTER TABLE `compra`
  ADD PRIMARY KEY (`idcompra`),
  ADD KEY `fk_compra_persona_idx` (`idproveedor`),
  ADD KEY `fk_compra_usuario_idx` (`idusuario`),
  ADD KEY `fk_compra_tipo_comprobante` (`tipo_comprobante`),
  ADD KEY `fk_compra_impuesto` (`impuesto`);

--
-- Indexes for table `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`iddetalle_compra`),
  ADD KEY `fk_detalle_compra_compra_idx` (`idcompra`),
  ADD KEY `fk_detalle_compra_articulo_idx` (`idproducto`);

--
-- Indexes for table `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle_venta`),
  ADD KEY `fk_detalle_venta_venta_idx` (`idventa`),
  ADD KEY `fk_detalle_venta_producto_idx` (`idproducto`) USING BTREE;

--
-- Indexes for table `impuesto`
--
ALTER TABLE `impuesto`
  ADD PRIMARY KEY (`id_impuesto`);

--
-- Indexes for table `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`idmarca`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indexes for table `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`idpermiso`);

--
-- Indexes for table `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`),
  ADD KEY `fk_tipo_persona` (`tipo_persona`),
  ADD KEY `fk_tipo_documento` (`tipo_documento`),
  ADD KEY `fk_zona` (`zona`);

--
-- Indexes for table `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idproducto`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD KEY `fk_producto_categoria_idx` (`idcategoria`),
  ADD KEY `fk_producto_marca` (`idmarca`);

--
-- Indexes for table `tipo_comprobante`
--
ALTER TABLE `tipo_comprobante`
  ADD PRIMARY KEY (`id_tipo_comprobante`);

--
-- Indexes for table `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`id_tipo_documento`);

--
-- Indexes for table `tipo_persona`
--
ALTER TABLE `tipo_persona`
  ADD PRIMARY KEY (`id_tipo_persona`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`),
  ADD KEY `fk_cargo` (`cargo`),
  ADD KEY `fk_tipo_documento_usuario` (`tipo_documento`);

--
-- Indexes for table `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD PRIMARY KEY (`idusuario_permiso`),
  ADD KEY `fk_usuario_permiso_permiso_idx` (`idpermiso`),
  ADD KEY `fk_usuario_permiso_usuario_idx` (`idusuario`);

--
-- Indexes for table `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indexes for table `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `fk_venta_persona_idx` (`idcliente`),
  ADD KEY `fk_venta_usuario_idx` (`idusuario`),
  ADD KEY `fk_venta_tipo_coomprobante` (`tipo_comprobante`),
  ADD KEY `fk_impuesto` (`impuesto`);

--
-- Indexes for table `zona`
--
ALTER TABLE `zona`
  ADD PRIMARY KEY (`id_zona`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `compra`
--
ALTER TABLE `compra`
  MODIFY `idcompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `iddetalle_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `marca`
--
ALTER TABLE `marca`
  MODIFY `idmarca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `permiso`
--
ALTER TABLE `permiso`
  MODIFY `idpermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `producto`
--
ALTER TABLE `producto`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  MODIFY `idusuario_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=327;

--
-- AUTO_INCREMENT for table `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `compra`
--
ALTER TABLE `compra`
  ADD CONSTRAINT `fk_compra_impuesto` FOREIGN KEY (`impuesto`) REFERENCES `impuesto` (`id_impuesto`),
  ADD CONSTRAINT `fk_compra_persona` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_compra_tipo_comprobante` FOREIGN KEY (`tipo_comprobante`) REFERENCES `tipo_comprobante` (`id_tipo_comprobante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_compra_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `fk_detalle_compra_compra` FOREIGN KEY (`idcompra`) REFERENCES `compra` (`idcompra`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_compra_producto` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fk_detalle_venta_articulo` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_venta_venta` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `fk_tipo_documento` FOREIGN KEY (`tipo_documento`) REFERENCES `tipo_documento` (`id_tipo_documento`),
  ADD CONSTRAINT `fk_tipo_persona` FOREIGN KEY (`tipo_persona`) REFERENCES `tipo_persona` (`id_tipo_persona`),
  ADD CONSTRAINT `fk_zona` FOREIGN KEY (`zona`) REFERENCES `zona` (`id_zona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_articulo_marca` FOREIGN KEY (`idmarca`) REFERENCES `marca` (`idmarca`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_cargo` FOREIGN KEY (`cargo`) REFERENCES `usuario_rol` (`id_rol`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tipo_documento_usuario` FOREIGN KEY (`tipo_documento`) REFERENCES `tipo_documento` (`id_tipo_documento`);

--
-- Constraints for table `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD CONSTRAINT `fk_usuario_permiso_permiso` FOREIGN KEY (`idpermiso`) REFERENCES `permiso` (`idpermiso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_permiso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_impuesto` FOREIGN KEY (`impuesto`) REFERENCES `impuesto` (`id_impuesto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_venta_persona` FOREIGN KEY (`idcliente`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_venta_tipo_coomprobante` FOREIGN KEY (`tipo_comprobante`) REFERENCES `tipo_comprobante` (`id_tipo_comprobante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;