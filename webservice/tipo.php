<?php
//===================================================================================================

	//Essa classe representa um tipo
	
//===================================================================================================

	class tipo implements \JsonSerializable {
		private $idTipo;
		private $nome;
		private $nomeImg;
		private $nomeImgDamage;
		
		private $damageTipoTaken = Array();
		
		public function setidTipo($_idTipo){
			$this->idTipo = $_idTipo;
		}
		
		public function setnome($_nome){
			$this->nome = $_nome;
		}
		
		public function setnomeImg($_nomeImg){
			$this->nomeImg = $_nomeImg;
		}
		
		public function setnomeImgDamage($_nomeImgDamage){
			$this->nomeImgDamage = $_nomeImgDamage;
		}
		
		public function setdamageTipoTaken($_damageTipoTaken){
			$this->damageTipoTaken = $_damageTipoTaken;
		}
		
		public function adddamageTipoTaken($_damageTipoTaken){
			//$this->damageTipoTaken += [(int)$_damageTipoTaken->getidTipo2() => (float)$_damageTipoTaken->getdano()]; //[$_damageTipoTaken->getidTipo2()] = (float)$_damageTipoTaken->getdano();
			array_push($this->damageTipoTaken,(float)$_damageTipoTaken->getdano());
		}	
		
		public function jsonSerialize(){
			$vars = get_object_vars($this);
			return $vars;
		}
	}
	
	class danoTaken implements \JsonSerializable {
	
		private $idTipo2;
		private $dano;
		
		function __construct($_idTipo2, $_dano){
			$this->idTipo2 = $_idTipo2;
			$this->dano = $_dano;
		}
		
		public function getidTipo2(){return $this->idTipo2;}
		public function getdano(){return $this->dano;}
		
		public function jsonSerialize(){
			$vars = get_object_vars($this);
			return $vars;
		}
	}
	
?>