<?php

class MarcaTest extends \PHPUnit\Framework\TestCase {
    public function testList(){
        $marca = array('pieers', 'marca de jeans', '1');
        list($nombre, $descripcion, $idmarca) = $marca;
        $esperado = $marca;
        $this->assertEquals($marca,$esperado);
    }
    public function testAdd(){
        $marca = array();
        $result = array_push($marca, 'pieers', 'marca de jeans', '1');
        $esperado = array('pieers', 'marca de jeans', '1');
        $this->assertEquals($marca,$esperado);
    }
    public function testEdit(){
        $marca = array('pieers', 'marca de jeans', '1');
        $replacements = array(0 => "pieers", 1 => "marca de jeans");
        $replacements2 = array(2 => "1");
        $marcanueva = array_replace($marca, $replacements, $replacements2);
        $esperado = array('pieers', 'marca de jeans', '1');
        $this->assertEquals($esperado,$marca);
    }

    public function testDelete(){
        $marca = array('pieers', 'marca de jeans', '1');
        $delete = array();
        $cant = 0;
        $esperado = sizeof($delete);
        $this->assertEquals($esperado,$cant);
    }
 
 
}
