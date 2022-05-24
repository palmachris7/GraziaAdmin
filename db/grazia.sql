-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2022 at 07:20 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.5

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
-- Table structure for table `articulo`
--

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `articulo`
--

INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `codigo`, `nombre`, `stock`, `descripcion`, `imagen`, `condicion`) VALUES
(1, 1, '8523697412', 'Camisa Blanca', 102, 'Camisa Hombre Franela tejido suave, manga larga con botones en los puños, cuello clásico, bolsillo en el pecho con botón,faldón redondeado,diseño a cuadros.', '1651339305.png', 1),
(2, 1, '8523697412', 'Camisa Franela', 28, 'Camisa Hombre Franela tejido suave, manga larga con botones en los puños, cuello clásico, bolsillo en el pecho con botón,faldón redondeado,diseño a cuadros.', '1651357396.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'Camisa de Temporada', 'Camisas en oferta de esta temporada', 1);

-- --------------------------------------------------------

--
-- Table structure for table `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `iddetalle_ingreso` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detalle_ingreso`
--

INSERT INTO `detalle_ingreso` (`iddetalle_ingreso`, `idingreso`, `idarticulo`, `cantidad`, `precio_compra`, `precio_venta`) VALUES
(1, 1, 1, 10, '20.00', '30.00'),
(2, 2, 1, 1, '1.00', '1.00'),
(3, 3, 1, 1, '1.00', '1.00'),
(4, 4, 1, 1, '6.00', '1.00'),
(5, 5, 1, 100, '1.00', '1.00'),
(6, 5, 1, 1, '1.00', '1.00'),
(7, 5, 1, 1, '1.00', '1.00'),
(8, 5, 1, 1, '1.00', '1.00'),
(9, 5, 1, 1, '1.00', '1.00'),
(10, 6, 2, 10, '100.00', '120.00'),
(11, 6, 1, 10, '200.00', '240.00');

--
-- Triggers `detalle_ingreso`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockIngreso` AFTER INSERT ON `detalle_ingreso` FOR EACH ROW BEGIN
 UPDATE articulo SET stock = stock + NEW.cantidad 
 WHERE articulo.idarticulo = NEW.idarticulo;
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
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detalle_venta`
--

INSERT INTO `detalle_venta` (`iddetalle_venta`, `idventa`, `idarticulo`, `cantidad`, `precio_venta`, `descuento`) VALUES
(1, 1, 1, 1, '30.00', '0.00'),
(2, 2, 1, 1, '30.00', '1.00'),
(3, 3, 1, 1, '30.00', '0.00'),
(4, 4, 1, 1, '30.00', '0.00'),
(5, 5, 1, 10, '1.00', '0.00'),
(6, 6, 1, 1, '1.00', '0.00'),
(7, 6, 1, 1, '4.00', '0.00'),
(8, 6, 1, 1, '1.00', '0.00'),
(9, 6, 1, 1, '1.00', '0.00'),
(10, 6, 1, 1, '1.00', '0.00'),
(11, 7, 1, 6, '9.00', '1.00'),
(12, 8, 2, 1, '220.00', '1.00'),
(13, 9, 2, 1, '20.00', '10.00'),
(14, 9, 1, 1, '30.00', '2.00');

--
-- Triggers `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
 UPDATE articulo SET stock = stock - NEW.cantidad 
 WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ingreso`
--

CREATE TABLE `ingreso` (
  `idingreso` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_compra` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ingreso`
--

INSERT INTO `ingreso` (`idingreso`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_compra`, `estado`) VALUES
(1, 1, 1, 'Boleta', '001', '0001', '2020-09-13 00:00:00', '0.18', '200.00', 'Anulado'),
(2, 1, 1, 'Boleta', '12', '1212', '2022-04-28 00:00:00', '1.00', '1.00', 'Anulado'),
(3, 1, 1, 'Boleta', '12121', '10002120', '2022-04-30 00:00:00', '99.99', '1.00', 'Aceptado'),
(4, 1, 1, 'Boleta', '3239239', '10002120', '2022-04-07 00:00:00', '99.99', '6.00', 'Aceptado'),
(5, 1, 1, 'Factura', '12121', '222', '2022-04-30 00:00:00', '18.00', '104.00', 'Aceptado'),
(6, 8, 1, 'Factura', '3239239', '222', '2022-05-02 00:00:00', '18.00', '3000.00', 'Aceptado');

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
(4, 2, 'Jorge Gomez', 1, '23659874', 'av prueba', 1, '931742904', 'vendedero@prueba.com'),
(6, 1, 'Alex Vilchez', 1, '47715777', '0', 1, '98444737', 'vendedero@prueba.com'),
(7, 1, 'Luis  perez', 1, '47715777', 'juan g1260', 3, '916884456', 'vendedero@prueba.com'),
(8, 2, 'proveedor', 1, '7044438', 'Av 123 1260', 2, '98414737', 'vendedero@prueba.com'),
(9, 1, 'Juan Rodriguez', 2, '23659874', 'Calle las verdolagas s/n', 2, '98444737', 'palmachristopher7@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cargo` int(11) DEFAULT NULL,
  `login` varchar(20) NOT NULL,
  `clave` varchar(64) NOT NULL,
  `imagen` varchar(50) NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `cargo`, `login`, `clave`, `imagen`, `condicion`) VALUES
(1, 'Christopher Palma T', 'DNI', '47715777', 'Jose Gálvez 1320', '931742904', 'admin@prueba.com', 1, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1487132068.jpg', 1),
(2, 'Vendedor', 'DNI', '23659874', 'Jose Gálvez 1260', '98414737', 'vendedero@prueba.com', 3, 'vendedor', 'e8827f3c0bcc90509b7d6841d446b163a671cac807a5f1bf41218667546ce80b', '1651366987.png', 1),
(3, 'Almacenero', 'DNI', '7044438', 'Calle las verdolagas s/n', '98444737', 'palmachristopher7@gmail.com', 2, 'almacenero', '19b9e4b4b69db1c5c38ea802a1754b4059b4df98cf5213c9c566801b397a952a', '1651367032.JPG', 1),
(7, 'Christopher Palma', 'DNI', '47715777', 'Lima', '931742904', 'palmachristopher7@hotmail.com', 1, 'administrador', '5fc73b340a8de5b5b09f03e5f60461edb162290102621bc3fa6f0422bcc39192', '1487132068.jpg', 1),
(8, 'Prueba', 'OTROS', '47715777', 'Calle magnolias 123', '931742904', 'vendedero@prueba.com', 2, 'prueba', '655e786674d9d3e77bc05ed1de37b4b6bc89f788829f9f3c679e7687b410c89b', '1651476513.png', 0),
(9, 'prueba2', 'DNI', '7044438', 'Jose Gálvez 1260', '98444737', 'vendedero@prueba.com', 3, 'prueba2', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1651478436.png', 0);

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
(172, 7, 1),
(173, 7, 2),
(174, 7, 3),
(175, 7, 4),
(176, 7, 5),
(177, 7, 6),
(178, 7, 7),
(194, 1, 1),
(195, 1, 2),
(196, 1, 3),
(197, 1, 4),
(198, 1, 5),
(199, 1, 6),
(200, 1, 7),
(214, 3, 1),
(215, 3, 2),
(216, 3, 3),
(217, 3, 6),
(218, 2, 1),
(219, 2, 4),
(220, 2, 7),
(232, 8, 2),
(233, 8, 3),
(234, 8, 6);

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
(1, 2, 1, 1, '001', '0001', '2020-09-13 00:00:00', 1, '1.00', 'Aceptado'),
(2, 2, 1, 1, '3239239', '10002120', '2022-04-28 00:00:00', 1, '30.00', 'Aceptado'),
(3, 2, 1, 1, '211', '222', '2022-04-28 00:00:00', 2, '30.00', 'Aceptado'),
(4, 2, 1, 1, '232', '232', '2022-04-28 00:00:00', 1, '30.00', 'Aceptado'),
(5, 2, 1, 1, '12121', '121212', '2022-04-08 00:00:00', 1, '1.00', 'Aceptado'),
(6, 2, 1, 1, '12121', '10002120', '2022-04-30 00:00:00', 1, '8.00', 'Aceptado'),
(7, 2, 1, 1, '12121', '10002120', '2022-04-30 00:00:00', 1, '53.00', 'Aceptado'),
(8, 3, 1, 2, '1111', '111', '2022-05-02 00:00:00', 2, '219.00', 'Aceptado'),
(9, 2, 1, 1, '12121', '10002120', '2022-05-02 00:00:00', 1, '38.00', 'Aceptado');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD KEY `fk_articulo_categoria_idx` (`idcategoria`);

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indexes for table `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_ingreso_ingreso_idx` (`idingreso`),
  ADD KEY `fk_detalle_ingreso_articulo_idx` (`idarticulo`);

--
-- Indexes for table `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle_venta`),
  ADD KEY `fk_detalle_venta_venta_idx` (`idventa`),
  ADD KEY `fk_detalle_venta_articulo_idx` (`idarticulo`);

--
-- Indexes for table `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_ingreso_persona_idx` (`idproveedor`),
  ADD KEY `fk_ingreso_usuario_idx` (`idusuario`);

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
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`),
  ADD KEY `fk_cargo` (`cargo`);

--
-- Indexes for table `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD PRIMARY KEY (`idusuario_permiso`),
  ADD KEY `fk_usuario_permiso_permiso_idx` (`idpermiso`),
  ADD KEY `fk_usuario_permiso_usuario_idx` (`idusuario`);

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `permiso`
--
ALTER TABLE `permiso`
  MODIFY `idpermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  MODIFY `idusuario_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=235;

--
-- AUTO_INCREMENT for table `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `fk_detalle_ingreso_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_ingreso_ingreso` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fk_detalle_venta_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_venta_venta` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_persona` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingreso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `fk_tipo_documento` FOREIGN KEY (`tipo_documento`) REFERENCES `tipo_documento` (`id_tipo_documento`),
  ADD CONSTRAINT `fk_tipo_persona` FOREIGN KEY (`tipo_persona`) REFERENCES `tipo_persona` (`id_tipo_persona`),
  ADD CONSTRAINT `fk_zona` FOREIGN KEY (`zona`) REFERENCES `zona` (`id_zona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_cargo` FOREIGN KEY (`cargo`) REFERENCES `usuario_rol` (`id_rol`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
