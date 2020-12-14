<?php
//===================================================================================================

	//Essa classe representa um move
	
//===================================================================================================

	class move implements \JsonSerializable {
		
		private $idMove;
		private $nome;
		private $prioridade;
		private $pp;
		private $ppMax;
		private $power;
		private $accuracy;
		private $descricao;
		
		private $categoriaMove;
		private $nomeImgCategoriaMove;
		private $contestMove = "";
		private $nomeImgContestMove = "";
		
		private $idTipo;
		private $efeito;
		private $chanceEfeito = 0.0;
		
		private $target;
		
		private $numeroTM = 0;
		
		private $locMoveTutor;
		private $valorMoveTutor;
		
		private $zCrystal;
		private $nomeImgzCrystal;
		private $idMoveRequerido = "";
		private $efeitoAdicional = "";
		
		private $listaIdsPokesLevelUp = Array();
		private $listaIdsPokesBreed = Array();
		private $listaIdsPokesTm = Array();
		private $listaIdsPokesMoveTutor = Array();
		
		
		public function setidMove($_idMove){
			$this->idMove = $_idMove;
		}
		
		public function setnome($_nome){
			$this->nome = $_nome;
		}		

		public function setprioridade($_prioridade){
			$this->prioridade = $_prioridade;
		}

		public function setpp($_pp){
			$this->pp = $_pp;
		}

		public function setppMax($_ppMax){
			$this->ppMax = $_ppMax;
		}

		public function setpower($_power){
			$this->power = $_power;
		}

		public function setaccuracy($_accuracy){
			$this->accuracy = $_accuracy;
		}

		public function setdescricao($_descricao){
			$this->descricao = $_descricao;
		}

		public function setcategoriaMove($_categoriaMove){                    
			$this->categoriaMove = $_categoriaMove;                           
		}                                                                     

		public function setnomeImgCategoriaMove($_nomeImgCategoriaMove){      
			$this->nomeImgCategoriaMove = $_nomeImgCategoriaMove;             
		}                                                                     

		public function setcontestMove($_contestMove){
			$this->contestMove = $_contestMove;
		}

		public function setnomeImgContestMove($_nomeImgContestMove){
			$this->nomeImgContestMove = $_nomeImgContestMove;
		}

		public function setidTipo($_idTipo){
			$this->idTipo = $_idTipo;
		}

		public function setefeito($_efeito){
			$this->efeito = $_efeito;
		}

		public function setchanceEfeito($_chanceEfeito){
			$this->chanceEfeito = $_chanceEfeito;
		}

		public function settarget($_target){														
			$this->target = $_target;                                                               
		}
		
		public function setnumeroTM($_numeroTM){
			$this->numeroTM = $_numeroTM;       
		}									
		
		public function setlocMoveTutor($_locMoveTutor){
			$this->locMoveTutor = $_locMoveTutor;       
		}									
		
		public function setvalorMoveTutor($_valorMoveTutor){
			$this->valorMoveTutor = $_valorMoveTutor;       
		}									
		
		public function setzCrystal($_zCrystal){
			$this->zCrystal = $_zCrystal;       
		}

		public function setnomeImgzCrystal($_nomeImgzCrystal){
			$this->nomeImgzCrystal = $_nomeImgzCrystal;       
		}

		public function setidMoveRequerido($_idMoveRequerido){
			$this->idMoveRequerido = $_idMoveRequerido;       
		}		
		
		public function setefeitoAdicional($_efeitoAdicional){
			$this->efeitoAdicional = $_efeitoAdicional;       
		}
		
		public function addlistaIdsPokesLevelUp($_novoIdPoke){ 
			array_push($this->listaIdsPokesLevelUp,$_novoIdPoke);
		}
		
		public function addlistaIdsPokesBreed($_novoIdPoke){ 
			array_push($this->listaIdsPokesBreed,$_novoIdPoke);
		}
		
		public function addlistaIdsPokesTm($_novoIdPoke){ 
			array_push($this->listaIdsPokesTm,$_novoIdPoke);
		}
		
		public function addlistaIdsPokesMoveTutor($_novoIdPoke){ 
			array_push($this->listaIdsPokesMoveTutor,$_novoIdPoke);
		}
		
		
		
		public function jsonSerialize(){
			$vars = get_object_vars($this);
			return $vars;
		}
	}
?>