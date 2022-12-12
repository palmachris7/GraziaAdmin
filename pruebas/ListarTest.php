<?php

class ListarTest extends \PHPUnit\Framework\TestCase {
    public function Test(){
        $prueba = new App\Prueba;
        $result = $prueba->listarr(3,2);
        $this->assertEquals(7,$result);
    }
 
}
