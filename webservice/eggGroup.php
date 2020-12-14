<?php
//===================================================================================================

	//Essa classe representa um eggGroup
	
//===================================================================================================
	
	class eggGroup implements \JsonSerializable {
		private $idEggGroup;
		private $nome;
		private $nomeImg;
		
		private $listaPokemon = Array();
		
		public function setidEggGroup($_idEggGroup){
			$this->idEggGroup = $_idEggGroup;
		}
		
		public function setnome($_nome){
			$this->nome = $_nome;
		}
		
		public function setnomeImg($_nomeImg){
			$this->nomeImg = $_nomeImg;
		}
		
		public function addlistaPokemon($_pokemon){
			array_push($this->listaPokemon, $_pokemon);
		}
		
		public function jsonSerialize(){
			$vars = get_object_vars($this);
			return $vars;
		}
		
	}
?>