 <?php
  //Activamos el almacenamiento en el buffer

  ob_start();
  session_start();

  if (!isset($_SESSION["nombre"])) {
    header("Location: login.html");
  } else {
    require 'header.php';

    if ($_SESSION['escritorio'] == 1) {
        require_once "../modelos/Consultas.php";
        $consulta = new Consultas();
        $rsptac = $consulta->totalcomprahoy();
        $regc = $rsptac->fetch_object();
        $totalc = $regc->total_compra;

        $rsptav = $consulta->totalventahoy();
        $regv = $rsptav->fetch_object();
        $totalv = $regv->total_venta;


        $rsptap = $consulta->numerocamisas();
        $regp = $rsptap->fetch_object();
        $totalp = $regp->total_productos;



        $rsptacli = $consulta->numeroclientes();
        $regcli = $rsptacli->fetch_object();
        $totalcli = $regcli->total_clientes;

        //Datos para mostrar el gráfico de barras de las compras
        $compras10 = $consulta->comprasultimos_12meses();
        $fechasc = '';
        $totalesc = '';
        while ($regfechac = $compras10->fetch_object()) {
            $fechasc = $fechasc . '"' . $regfechac->fecha . '",';
            $totalesc = $totalesc . $regfechac->total . ',';
        }


        $fechasc = substr($fechasc, 0, -1);
        $totalesc = substr($totalesc, 0, -1);

        //Datos para mostrar el gráfico de barras de las ventas
        $ventas12 = $consulta->ventasultimos_12meses();
        $fechasv = '';
        $totalesv = '';
        while ($regfechav = $ventas12->fetch_object()) {
            $fechasv = $fechasv . '"' . $regfechav->fecha . '",';
            $totalesv = $totalesv . $regfechav->total . ',';
        }


        $fechasv = substr($fechasv, 0, -1);
        $totalesv = substr($totalesv, 0, -1);





        ?>
     <!--Contenido-->
     <!-- Content Wrapper. Contains page content -->
     <div class="content-wrapper">
       <!-- Main content -->
       <section class="content">
         <div class="row">
           <div class="col-md-12">
             <div class="box">
               <div class="box-header with-border">
                 <h1 class="box-title">Escritorio </h1>
                 <div class="box-tools pull-right">
                 </div>
               </div>
               <!-- /.box-header -->
               <!-- centro -->



               <div class="panel-body">
                 <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                   <div class="small-box bg-orange">
                     <div class="inner">
                       <h4 style="font-size:20px;">
                         <p>Bienvenido</p>
                         <strong><?php echo $_SESSION['nombre']; ?></strong>
                       </h4>

                     </div>
                     <div class="icon">
                       <i class="fa-solid fa-user"></i>
                     </div>
                     <a href="usuario.php" class="small-box-footer"> <i class="fa fa-arrow-circle-right"></i></a>
                   </div>
                 </div>






                 <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6">
                   <div class="small-box bg-aqua">
                     <div class="inner">
                       <h4 style="font-size:17px;">
                         <i class="fa-solid fa-minus fa-2xl"></i> <strong>S/ <?php echo $totalc; ?></strong>
                       </h4>

                       <p>Compras de hoy</p>
                     </div>
                     <div class="icon">
                       <i class="fa-solid fa-minus"></i>
                     </div>
                     <a href="compra.php" class="small-box-footer"> Compras <i class="fa fa-arrow-circle-right"></i></a>
                   </div>
                 </div>

                 <div class="col-lg-3 col-md-6 col-sm-6 col-xs-6">
                   <div class="small-box bg-green">
                     <div class="inner">
                       <h4 style="font-size:17px;">
                         <i class="fa-solid fa-plus fa-2xl"></i> <strong>S/ <?php echo $totalv; ?></strong>
                       </h4>
                       <p>Ventas de hoy</p>
                     </div>
                     <div class="icon">
                       <i class="fa-solid fa-plus"></i>
                     </div>
                     <a href="venta.php" class="small-box-footer"> Ventas <i class="fa fa-arrow-circle-right"></i></a>
                   </div>
                 </div>

                 <div class="panel-body">
                   <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                     <div class="small-box bg-red">
                       <div class="inner">
                         <h4 style="font-size:20px;">
                           <i class='bx bx-male-female'></i> <strong><?php echo $totalcli; ?></strong>
                           <p>Cantidad de Clientes</p>
                         </h4>
                         <div class="icon">
                           <i class="bx bx-male-female"></i>
                         </div>
                       </div>

                       <a href="cliente.php" class="small-box-footer"> <i class="fa fa-arrow-circle-right"></i></a>
                     </div>

                   </div>
                   <div class="panel-body">
                     <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                       <div class="small-box bg-blue">
                         <div class="inner">
                           <h4 style="font-size:20px;">
                             <i class="bx bxs-t-shirt"></i> <strong><?php echo $totalp; ?></strong>
                             <p>Cantidad de Productos</p>
                           </h4>
                           <div class="icon">
                             <i class="bx bxs-t-shirt"></i>
                           </div>
                         </div>
                         <a href="producto.php" class="small-box-footer"> <i class="fa fa-arrow-circle-right"></i></a>
                       </div>
                     </div>

                   </div>












                 </div>
                 <div class="panel-body">
                   <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                     <div class="box box-primary">
                       <div class="box-header with-border">
                         Compras de los últimos meses
                         <div class="box-tools pull-right">
                           <button type="button" class="btn btn-box-tool" data-widget="collapse">
                             <i class="fa fa-minus"></i>
                         </div>
                       </div>

                       <div class="box-body">
                         <canvas id="compras" width="400" height="300"></canvas>
                       </div>
                     </div>
                   </div>
                   <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                     <div class="box box-primary">
                       <div class="box-header with-border">
                         Ventas de los últimos meses
                         <div class="box-tools pull-right">
                           <button type="button" class="btn btn-box-tool" data-widget="collapse">
                             <i class="fa fa-minus"></i>
                         </div>
                       </div>
                       <div class="box-body">
                         <canvas id="ventas" width="400" height="300"></canvas>
                       </div>
                     </div>
                   </div>
                 </div>


                 <div class="box box-primary">
                   <div class="box-header with-border">
                     <h3 class="box-title">Productos recien agregados</h3>
                     <div class="box-tools pull-right">
                       <button type="button" class="btn btn-box-tool" data-widget="collapse">
                         <i class="fa fa-minus"></i>
                       </button>
                     </div>
                   </div>



                   <div class="box-footer text-center">
                     <a href="producto.php" class="uppercase">Ver todos los productos</a>
                   </div>

                 </div>


                 <!--Fin centro -->
               </div><!-- /.box -->
             </div><!-- /.col -->
           </div><!-- /.row -->
       </section><!-- /.content -->

     </div><!-- /.content-wrapper -->
     <!--Fin-Contenido-->
   <?php
    } else {
      require 'noacceso.php';
    }

    require 'footer.php';
    ?>

   <script src="../public/js/chart.min.js"></script>
   <script src="../public/js/Chart.bundle.min.js"></script>
   <script type="text/javascript">
     var ctx = document.getElementById("compras").getContext('2d');
     var compras = new Chart(ctx, {
       type: 'bar',
       data: {
         labels: [<?php echo $fechasc; ?>],
         datasets: [{
           label: 'Compras en S/ de los últimos Meses',
           data: [<?php echo $totalesc; ?>],
           backgroundColor: [
             'rgba(26,78,84,0.2)',
             'rgba(162,111,107,0.2)',
             'rgba(19,36,100,0.2)',
             'rgba(169,123,50,0.2)',
             'rgba(153, 102, 255, 0.2)',
             'rgba(70,27,124,0.56)',
             'rgba(66,117,94,0.2)',
             'rgba(94,10,10,0.2)',
             'rgba(255, 206, 86, 0.2)',
             'rgba(48,112,16,0.2)'
           ],
           borderColor: [
               'rgb(26,78,84)',
               'rgb(162,111,107)',
               'rgb(19,36,100)',
               'rgb(169,123,50)',
               'rgb(153,102,255)',
               'rgb(70,27,124)',
               'rgb(66,117,94)',
               'rgb(94,10,10)',
               'rgb(255,206,86)',
               'rgb(48,112,16)'
           ],
           borderWidth: 1
         }]
       },
       options: {
         scales: {
           yAxes: [{
             ticks: {
               beginAtZero: true
             }
           }]
         }
       }
     });

     var ctx = document.getElementById("ventas").getContext('2d');
     var ventas = new Chart(ctx, {
       type: 'bar',
       data: {
         labels: [<?php echo $fechasv; ?>],
         datasets: [{
           label: 'Ventas en S/ de los últimos Meses',
           data: [<?php echo $totalesv; ?>],
           backgroundColor: [
             'rgba(255, 99, 132, 0.2)',
             'rgba(54, 162, 235, 0.2)',
             'rgba(255, 206, 86, 0.2)',
             'rgba(75, 192, 192, 0.2)',
             'rgba(153, 102, 255, 0.2)',
             'rgba(255, 159, 64, 0.2)',
             'rgba(255, 99, 132, 0.2)',
             'rgba(54, 162, 235, 0.2)',
             'rgba(255, 206, 86, 0.2)',
             'rgba(75, 192, 192, 0.2)'
           ],
           borderColor: [
             'rgba(255,99,132,1)',
             'rgba(54, 162, 235, 1)',
             'rgba(255, 206, 86, 1)',
             'rgba(75, 192, 192, 1)',
             'rgba(153, 102, 255, 1)',
             'rgba(255, 159, 64, 1)',
             'rgba(255,99,132,1)',
             'rgba(54, 162, 235, 1)',
             'rgba(255, 206, 86, 1)',
             'rgba(75, 192, 192, 1)'
           ],
           borderWidth: 1
         }]
       },
       options: {
         scales: {
           yAxes: [{
             ticks: {
               beginAtZero: true
             }
           }]
         }
       }
     });
   </script>


   </script>


 <?php
  }
  ob_end_flush();
  ?>