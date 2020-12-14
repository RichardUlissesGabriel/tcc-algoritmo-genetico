<?php

	class dataBaseManager{
		
		private $servername="127.0.0.1";
		private $username="pokemon";
		private $password="pokemon";
		private $dbname="pokemonDataBase";
		private $conn;
		
		function openConnection(){
			
			//Crio a Conexão
			$this->conn = mysqli_connect($this->servername, $this->username, $this->password, $this->dbname);
			//Verifico se a conexão foi bem feita
			if (!$this->conn) {
				die("Falha de conexão com o banco de dados");
			}
		
		}
		
		function closeConnection(){
			//Funcao para finalizar somente
			mysqli_close($this->conn);
			
		}
		
		function getData($query){
			
			mysqli_set_charset($this->conn, "utf8");
			
			//Executo a consulta no banco
			$resultado = mysqli_query($this->conn, $query);
			
			//retorno o objeto que contem o resultado
			return $resultado;
			
		}
		
	}
	
	//Teste da Classe
	//	$dbManager = New dataBaseManager();
	//	
	//	$result = $dbManager->getData("SELECT nDex, nome FROM pokemon");
	//
	//	if (mysqli_num_rows($result) > 0) {
	//		// intero sobre todos os arrays
	//		while($row = mysqli_fetch_assoc($result)) {
	//			echo "id: " . $row["nDex"]. " - Name: " . $row["nome"]. "<br>";
	//		}
	//	} else {
	//		echo "0 results";
	//	}
	//=============================================================================
?>