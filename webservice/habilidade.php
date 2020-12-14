<?php
//===================================================================================================

	//Essa classe representa uma habilidade
	
//===================================================================================================
	
	class habilidade implements \JsonSerializable {
		private $idHabilidade;
		private $nome;
		private $descEfeito;
		private $descEfeitoOutside;
		private $listaIdsPokesFirst  = Array();
		private $listaIdsPokesSecond = Array();
		private $listaIdsPokesHidden = Array();
		
		
		public function setidHabilidade($_idHabilidade){
			$this->idHabilidade = $_idHabilidade;
		}
		
		public function setnome($_nome){
			$this->nome = $_nome;
		}
		
		public function setdescEfeito($_descEfeito){
			$this->descEfeito = $_descEfeito;
		}
		
		public function setdescEfeitoOutside($_descEfeitoOutside){
			$this->descEfeitoOutside = $_descEfeitoOutside;
		}
		
		
		public function addlistaIdsPokesFirst($_idPoke){ 
			array_push($this->listaIdsPokesFirst,$_idPoke);
		}
		
		public function addlistaIdsPokesSecond($_idPoke){ 
			array_push($this->listaIdsPokesSecond,$_idPoke);
		}
		
		public function addlistaIdsPokesHidden($_idPoke){ 
			array_push($this->listaIdsPokesHidden,$_idPoke);
		}		
		
		public function jsonSerialize(){
			$vars = get_object_vars($this);
			return $vars;
		}
		
	}
?>