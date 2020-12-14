<?php

//===================================================================================================

	//Essa classe representa um unico pokemon
	
//===================================================================================================
	
	class pokemon implements \JsonSerializable {
		
		private $idPokemon;
		private $nDex;
		private $nome;
		private $nomeImgMS;
		private $nomeImg;
		private $hp;
		private $ataque;
		private $defesa;
		private $ataqueEspecial;
		private $defesaEspecial;
		private $velocidade;
		private $idTipo1;
		private $idTipo2 = 0;
		private $idGeracao;
		
		//ids que representam as habilidades desse pokemon
		private $idHabilidade1;
		private $idHabilidade2 = 0;
		private $idHabilidadeHidden = 0;

		//id do pokemon para qual -esse- pokemon evolui
		private $idPokemonEvolucao = 0;
		private $levelEvo = "";//pode não existir levelEvo
		private $nomeImgEvo = "";
		
		private $idPreEvolucao = 0;//id do pokemon anterior
		
		//lista de ids dos egg groups ao qual esse pokemon pertence
		private $listaIdsEggGroups = Array();
		
		//lista de id de golpes que esse pokemon aprende
		private $listaIdsMovesLevelUp = Array();
		private $listaIdsMovesTm = Array();
		private $listaIdsMovesMoveTutor = Array();
		private $listaIdsMovesBreed = Array();
		
		//setters
		public function setidPokemon($_idPokemon){
			$this->idPokemon = $_idPokemon;
		}
		
		public function setnDex($_nDex){
			$this->nDex = $_nDex;
		}
		
		public function setnome($_nome){
			$this->nome = $_nome;
		}
		
		public function setnomeImgMS($_nomeImgMS){
			$this->nomeImgMS = $_nomeImgMS;
		}
		
		public function setnomeImg($_nomeImg){
			$this->nomeImg = $_nomeImg;
		}
		
		public function sethp($_hp){
			$this->hp = $_hp;
		}
		
		public function setataque($_ataque){
			$this->ataque = $_ataque;
		}
		
		public function setdefesa($_defesa){
			$this->defesa = $_defesa;
		}
		
		public function setataqueEspecial($_ataqueEspecial){
			$this->ataqueEspecial = $_ataqueEspecial;
		}  
		
		public function setdefesaEspecial($_defesaEspecial){
			$this->defesaEspecial = $_defesaEspecial;
		}  
		
		public function setvelocidade($_velocidade){
			$this->velocidade = $_velocidade;
		}
		
		public function setidTipo1($_idTipo1){
			$this->idTipo1 = $_idTipo1;
		}
		
		public function setidTipo2($_idTipo2){
			$this->idTipo2 = $_idTipo2;
		}
		
		public function setidGeracao($_idGeracao){
			$this->idGeracao = $_idGeracao;
		}
		
		public function setidHabilidade1($_idHabilidade1){
			$this->idHabilidade1 = $_idHabilidade1;
		}
		
		public function setidHabilidade2($_idHabilidade2){
			$this->idHabilidade2 = $_idHabilidade2;
		}
		
		public function setidHabilidadeHidden($_idHabilidadeHidden){
			$this->idHabilidadeHidden = $_idHabilidadeHidden;
		}   
		
		public function setidPokemonEvolucao($_idPokemonEvolucao){
			$this->idPokemonEvolucao = $_idPokemonEvolucao;
		}
		
		public function setlevelEvo($_levelEvo){
			$this->levelEvo = $_levelEvo;
		}
		
		public function setnomeImgEvo($_nomeImgEvo){
			$this->nomeImgEvo = $_nomeImgEvo;
		}
		
		public function setidPreEvolucao($_idPreEvolucao){
			$this->idPreEvolucao = $_idPreEvolucao;
		}

		public function setlistaIdsEggGroups($_listaIdsEggGroups){
			$this->listaIdsEggGroups = $_listaIdsEggGroups;
		}
		
		public function addIdsEggGroup($_idEggGroup){
			array_push($this->listaIdsEggGroups, $_idEggGroup);
		}
		
		public function setlistaIdsMovesLevelUp($_listaIdsMoves){
			$this->listaIdsMovesLevelUp = $_listaIdsMoves;
		}
		
		public function addIdsMovesLevelUp($_idMove,$_levelUp){
			$this->listaIdsMovesLevelUp[$_idMove] = $_levelUp;
		}
		
		public function setlistaIdsMovesTm($_listaIdsMoves){
			$this->listaIdsMovesTm = $_listaIdsMoves;
		}
		
		public function addIdsMovesTm($_idMove){
			array_push($this->listaIdsMovesTm, $_idMove);
		}

		public function setlistaIdsMovesMoveTutor($_listaIdsMoves){
			$this->listaIdsMovesMoveTutor = $_listaIdsMoves;
		}
		
		public function addIdsMovesMoveTutor($_idMove){
			array_push($this->listaIdsMovesMoveTutor, $_idMove);
		}

		public function setlistaIdsMovesBreed($_listaIdsMoves){
			$this->listaIdsMovesBreed = $_listaIdsMoves;
		}
		
		public function addIdsMovesBreed($_idMove){
			array_push($this->listaIdsMovesBreed, $_idMove);
		}		

		public function jsonSerialize(){
			$vars = get_object_vars($this);
			return $vars;
		}
	}
	
?>