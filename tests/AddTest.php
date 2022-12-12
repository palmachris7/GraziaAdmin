<?php

class AddTest extends \PHPUnit\Framework\TestCase {
    public function testAdd(){
        $marca = new App\Marca;
        $result = $marca->insertarr("Prueba","prueba");
        $this->assertEquals("false",$result);
    }
 
 
}
