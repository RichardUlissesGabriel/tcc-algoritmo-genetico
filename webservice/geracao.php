<?php
//===================================================================================================

	//Essa classe representa a geracao
	
//===================================================================================================
	
	class geracao implements \JsonSerializable {
		private $idGeracao;
		private $numeroRomano;
		private $nome;
		
		public function setidGeracao($_idGeracao){
			$this->idGeracao = $_idGeracao;
		}
		
		public function setnumeroRomano($_numeroRomano){
			$this->numeroRomano = $_numeroRomano;
		}
		
		public function setnome($_nome){
			$this->nome = $_nome;
		}
		
		public function jsonSerialize(){
			$vars = get_object_vars($this);
			return $vars;
		}
		
	}
?>