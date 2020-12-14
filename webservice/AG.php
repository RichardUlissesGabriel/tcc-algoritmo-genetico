<?php
	
	//Como o processamento demora um tempo, 
	//é alterado o tempo de execução para infinito 
	set_time_limit ( 0 );
    
    //Time inimigo
    $time = $_GET['time'];
    
    //Chamada da aplicação C++
    //echo exec("/Library/WebServer/Documents/AG/build/Debug/AG.exe ".$time);
	
	//Transformando o resultado do C++ em um array de inteiro
	$res = explode("-",exec("C:/AG/Debug/AG.exe $time".$time));
	
	
	for ($i = 0 ; $i < count($res);++$i){
		$res[$i] = (int)$res[$i];
	}
	
    echo json_encode($res);
?>





