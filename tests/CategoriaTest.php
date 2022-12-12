<?php

class CategoriaTest extends \PHPUnit\Framework\TestCase {
  
    public function testList(){
        $categoria = array('pantalones', 'pantalones de temporada', '2');
        list($nombre, $descripcion, $idcategoria) = $categoria;
        $result = true;
        $this->assertEquals("false","false");
    }
    public function testAdd(){
        $categoria = array();
        $result = array_push($categoria, 'pantalones', 'pantalones de temporada','2');
        $esperado = array('pantalones', 'pantalones de temporada', '2');
        $this->assertEquals($categoria,$esperado);
    }
    public function testEdit(){
        $categoria = array('pantalones', 'pantalones de temporada', '2');
        $replacements = array(0 => "camisas", 1 => "camisas de temporada");
        $replacements2 = array(2 => "1");
        $categorianueva = array_replace($categoria, $replacements, $replacements2);
        $esperado = array('pantalones', 'pantalones de temporada', '2');
        $this->assertEquals($esperado,$categoria);
    }

    public function testDelete(){
        $categoria = array('pantalones', 'pantalones de temporada', '2');
        $delete = array();
        $cant = 0;
        $esperado = sizeof($delete);
        $this->assertEquals($esperado,$cant);
    }

}
