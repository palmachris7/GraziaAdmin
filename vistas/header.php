<?php
if (strlen(session_id()) < 1)
  session_start();
?>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Sistema Ventas Spirella</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.5 -->
  <link rel="stylesheet" href="../public/css/bootstrap.min.css">
  <link rel="stylesheet" href="../public/css/slider.css">
  <!-- Boxicons -->
  <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
  <!-- Font Awesome -->
  <script src="https://kit.fontawesome.com/6239a86879.js" crossorigin="anonymous"></script>
  <!-- Theme style -->

  <link rel="stylesheet" href="../public/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="../public/css/_all-skins.min.css">
  <link rel="apple-touch-icon" href="../public/img/apple-touch-icon.png">
  <link rel="shortcut icon" href="../public/img/favicon.ico">

  <!-- DATATABLES -->
  <link rel="stylesheet" type="text/css" href="../public/datatables/jquery.dataTables.min.css">
  <link href="../public/datatables/buttons.dataTables.min.css" rel="stylesheet" />
  <link href="../public/datatables/responsive.dataTables.min.css" rel="stylesheet" />

  <link rel="stylesheet" type="text/css" href="../public/css/bootstrap-select.min.css">

</head>

<body class="hold-transition skin-blue-light sidebar-mini">
  <div class="wrapper">

    <header class="main-header">

      <!-- Logo -->
      <a href="" class="logo">
        <!-- mini logo for sidebar mini 50x50 pixels -->
        <span class="logo-mini"><b>S</b></span>
        <!-- logo for regular state and mobile devices -->
        <span class="logo-lg"><b>Spirella</b></span>
      </a>

      <!-- Header Navbar: style can be found in header.less -->
      <nav class="navbar navbar-static-top" role="navigation">
        <!-- Sidebar toggle button-->
        <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
          <span class="sr-only">Navegación</span>
        </a>
        <!-- Navbar Right Menu -->
        <div class="navbar-custom-menu">
          <ul class="nav navbar-nav">
            <!-- Messages: style can be found in dropdown.less-->

            <!-- User Account: style can be found in dropdown.less -->
            <li class="dropdown user user-menu">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <img src="../files/usuarios/<?php echo $_SESSION['imagen']; ?>" class="user-image" alt="User Image">
                <span class="hidden-xs"> <?php echo $_SESSION['nombre']; ?></span>

              </a>
              <ul class="dropdown-menu">
                <!-- User image -->
                <li class="user-header">
                  <img src="../files/usuarios/<?php echo $_SESSION['imagen']; ?>" class="img-circle" alt="User Image">
                  <p>
                    <small>Sistema de Ventas </small>

                  </p>
                </li>

                <!-- Menu Footer-->
                <li class="user-footer">

                  <div class="pull-right">
                    <a href="../ajax/usuario.php?op=salir" class="btn btn-default btn-flat" style="position: relative;">Cerrar Sesion</a>
                  </div>
                </li>
              </ul>
            </li>

          </ul>
        </div>

      </nav>
    </header>
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">
      <!-- sidebar: style can be found in sidebar.less -->
      <section class="sidebar">
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
          <li class="header"></li>
          <?php
          if ($_SESSION['escritorio'] == 1) {
            echo '<li id="mEscritorio">
              <a href="escritorio.php">
              <i class="fa-solid fa-house"></i> <span>INICIO</span>
              </a>
            </li>';
          }
          ?>

          <?php
          if ($_SESSION['almacen'] == 1) {
            echo '<li id="mAlmacen" class="treeview">
              <a href="#">
              <i class="fa-solid fa-boxes-stacked"></i>
                <span>PRODUCTOS</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lArticulos"><a href="producto.php"><i class="fa-solid fa-shirt"></i> Productos</a></li>
                <li id="lCategorias"><a href="categoria.php"><i class="fa-solid fa-tags"></i> Categorías</a></li>
                <li id="lCategorias"><a href="marca.php"><i class="fa-solid fa-shop"></i> Marcas</a></li>
              </ul>
            </li>';
          }
          ?>

          <?php
          if ($_SESSION['compras'] == 1) {
            echo '<li id="mCompras" class="treeview">
              <a href="#">
              <i class="fa-solid fa-truck-ramp-box"></i>
                <span>GESTION DE COMPRAS</span>
                 <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lIngresos"><a href="compra.php"><i class="fa-solid fa-basket-shopping"></i> Compras</a></li>
                <li id="lProveedores"><a href="proveedor.php"><i class="fa-solid fa-truck"></i> Proveedores</a></li>
              </ul>
            </li>';
          }
          ?>

          <?php
          if ($_SESSION['ventas'] == 1) {
            echo '<li id="mVentas" class="treeview">
              <a href="#">
              <i class="fa-solid fa-arrow-right-arrow-left"></i>
                <span>GESTION DE VENTAS</span>
                 <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lVentas"><a href="venta.php"><i class="fa-solid fa-cart-plus"></i> Ventas</a></li>
                <li id="lClientes"><a href="cliente.php"><i class="fa-solid fa-people-group"></i> Clientes</a></li>
              </ul>
            </li>';
          }
          ?>

          <?php
          if ($_SESSION['acceso'] == 1) {
            echo '<li id="mAcceso" class="treeview">
              <a href="#">
              <i class="fa-solid fa-user"></i> <span>EMPLEADOS</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lUsuarios"><a href="usuario.php"><i class="fa-solid fa-user-tie"></i> Usuarios</a></li>
                <li id="lPermisos"><a href="permiso.php"><i class="fa-solid fa-user-shield"></i> Permisos</a></li>
                
              </ul>
            </li>';
          }
          ?>
          <?php
          if ($_SESSION['consultav'] == 1) {
            echo '<li id="mConsultaV" class="treeview">
              <a href="#">
              <i class="fa-solid fa-scale-unbalanced-flip"></i> <span>CONSULTA VENTAS </span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lConsulasV"><a href="ventasfechacliente.php"><i class="fa-solid fa-magnifying-glass-dollar"></i> Consultar</a></li>                
              </ul>
            </li>';
          }
          ?>
          <?php
          if ($_SESSION['consultac'] == 1) {
            echo '<li id="mConsultaC" class="treeview">
              <a href="#">
              <i class="fa-solid fa-scale-unbalanced"></i> <span>CONSULTA COMPRAS</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lConsulasC"><a href="comprasfecha.php"><i class="fa-solid fa-magnifying-glass-arrow-right"></i> Consultar</a></li>                
              </ul>
              
            </li>';
          }
          ?>

         


      </section>
      <!-- /.sidebar -->
    </aside>