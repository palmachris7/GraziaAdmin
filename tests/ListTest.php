<?php

class ListTest extends \PHPUnit\Framework\TestCase {
    public function testList(){
        
        $marca = new App\Marca;
        $result = $marca->listarr();
        $this->assertEquals("false",$result);
    }
 
}
