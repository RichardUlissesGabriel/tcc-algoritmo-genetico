<?php
	//header('Content-Type: text/html;charset=utf-8');
	include_once 'dataBaseManager.php';
	include_once 'pokemon.php';
	include_once 'geracao.php';
	include_once 'tipo.php';
	include_once 'move.php';
	include_once 'habilidade.php';
	include_once 'eggGroup.php';
	
//===================================================================================================

	//Essa classe é responsavel por devolver a informacao da data base para o web service
	
//===================================================================================================

	class getData{
				
		static public function getListaPokemon(){
			
			//Array para comportar o resultado
			$pokeLista = Array();
			
			//inicializo a minha variavel responsavel por ligar o banco
			$dbManager = New dataBaseManager();
			
			$dbManager->openConnection();
			
			//Passo o select que eu quero para o metodo, no caso do pokemon um select simples
			$result = $dbManager->getData("SELECT 
												idPokemon, 
												nDex, 
												nome, 
												nomeImgMS, 
												nomeImg, 
												hp, 
												ataque, 
												defesa, 
												ataqueEspecial, 
												defesaEspecial, 
												velocidade, 
												idTipo1, 
												idTipo2, 
												idGeracao 
											FROM pokemon order by idPokemon"
			);
			
			// intero sobre todos os elemento do retorno da consulta
			while($poke = mysqli_fetch_assoc($result)) {
				
				$novoPokemon = new pokemon();
				
				$novoPokemon->setidPokemon((int)$poke['idPokemon']); 
				$novoPokemon->setnDex($poke['nDex']);
				$novoPokemon->setnome($poke['nome']); 
				$novoPokemon->setnomeImgMS($poke['nomeImgMS']);
				$novoPokemon->setnomeImg($poke['nomeImg']);
				$novoPokemon->sethp((int)$poke['hp']);
				$novoPokemon->setataque((int)$poke['ataque']);
				$novoPokemon->setdefesa((int)$poke['defesa']); 
				$novoPokemon->setataqueEspecial((int)$poke['ataqueEspecial']);
				$novoPokemon->setdefesaEspecial((int)$poke['defesaEspecial']);
				$novoPokemon->setvelocidade((int)$poke['velocidade']);
				$novoPokemon->setidTipo1((int)$poke['idTipo1']);
				$novoPokemon->setidTipo2((int)$poke['idTipo2']); 
				$novoPokemon->setidGeracao((int)$poke['idGeracao']);
				
				//conseguindo as habilidades Preciso corrigir os inserts do banco!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				$resHabilidade = $dbManager->getData("SELECT 
												(SELECT idHabilidade 
													FROM habilidadePokemon
													WHERE idTipoHabilidadePokemon = 1 AND idpokemon = " .$poke['idPokemon']. ") as 'Primary',
												(SELECT idHabilidade 
													FROM habilidadePokemon
													WHERE idTipoHabilidadePokemon = 2 AND idpokemon = " .$poke['idPokemon']. ") as 'Second',
												(SELECT idHabilidade 
													FROM habilidadePokemon 
													WHERE idTipoHabilidadePokemon = 3 AND idpokemon = " .$poke['idPokemon']. ") as 'Hidden'"
				);
				
				$habilidades = mysqli_fetch_assoc($resHabilidade);
				
				//conseguindo as habilidades
				$novoPokemon->setidHabilidade1((int)$habilidades['Primary']);
				$novoPokemon->setidHabilidade2((int)$habilidades['Second']);
				$novoPokemon->setidHabilidadeHidden((int)$habilidades['Hidden']);
				
				//conseguindo os eggGroups
				$resEggGroup = $dbManager->getData("SELECT idEggGroup FROM pokemonEggGroup WHERE idpokemon = " .$poke['idPokemon'] . " ORDER BY idEggGroup");
				
				while($eggG = mysqli_fetch_assoc($resEggGroup)) {
					$novoPokemon->addIdsEggGroup((int)$eggG['idEggGroup']);
				}
				
				
				//Conseguindo a proxima evolucao
				$resEvoPoke = $dbManager->getData("SELECT ep.idPokemonPosEvo, ep.levelEvolucao, e.imgFormaEvolucao 
													FROM evolucaopokemon ep INNER JOIN evolucao e ON e.idevolucao = ep.idevolucao WHERE ep.idPokemonPreEvo = ".$poke['idPokemon']
				);
				//echo "SELECT ep.idPokemonPosEvo, ep.levelEvolucao, e.imgFormaEvolucao 
													//FROM evolucaopokemon ep INNER JOIN evolucao e ON e.idevolucao = ep.idevolucao WHERE ep.idPokemonPreEvo = ".$poke['idPokemon'] . "<br>";
				
				if (mysqli_num_rows($resEvoPoke) > 0){
					$evoPoke = mysqli_fetch_assoc($resEvoPoke);
					
					$novoPokemon->setidPokemonEvolucao((int)$evoPoke['idPokemonPosEvo']);
					$novoPokemon->setlevelEvo($evoPoke['levelEvolucao']);
					$novoPokemon->setnomeImgEvo($evoPoke['imgFormaEvolucao']);
				}
				
				//conseguindo evolucao anterior
				$resPreEvoPoke = $dbManager->getData("SELECT ep.idPokemonPreEvo FROM evolucaopokemon ep WHERE ep.idPokemonPosEvo = ".$poke['idPokemon']);

				if (mysqli_num_rows($resPreEvoPoke) > 0){
					$evoPoke = mysqli_fetch_assoc($resPreEvoPoke);
					
					
					$novoPokemon->setidPreEvolucao((int)$evoPoke['idPokemonPreEvo']);
				}
				
				//Conseguindo a lista de movimento dos pokemons
				$idPoke = $poke['idPokemon'];
				
				//conseguindo os ids de moves de levelUp do pokemon 
				$resMove = $dbManager->getData("SELECT idMove, level FROM movePokemon WHERE idpokemon = " . $idPoke . " AND level IS NOT NULL ORDER BY idMove");
				
				//se verifiquei que o id selecionado nao possui golpes
				if(mysqli_num_rows($resMove) == 0){//Estou em um pokemon mega
					//Os str_replace são para limpar o nome do pokemon exemplo M. Mewtwo Y se torna Mewtwo 
					$resIdPokeBase = $dbManager->getData("SELECT idpokemon FROM pokemon WHERE nome = '" . str_replace(" Y","",str_replace(" X", "", str_replace("M. ","",$poke['nome']))) . "'");
					$idPokeBase = mysqli_fetch_assoc($resIdPokeBase);
					$idPoke = $idPokeBase['idpokemon'];
					
					//repito o select dos moves com o novo id
					$resMove = $dbManager->getData("SELECT idMove, level FROM movePokemon WHERE idpokemon = " .$idPoke . " AND level IS NOT NULL ORDER BY idMove"); 
				}
				
				//conseguindo os ids de moves de levelUp do pokemon 
				while($move = mysqli_fetch_assoc($resMove)) {
					$novoPokemon->addIdsMovesLevelUp((int)$move['idMove'],$move['level']);
				}
				
				//conseguindo os ids de moves de tm
				$resMove = $dbManager->getData("SELECT idMove FROM movePokemon WHERE idpokemon = " .$idPoke . " AND idTm IS NOT NULL ORDER BY idMove");
				
				while($move = mysqli_fetch_assoc($resMove)) {
					$novoPokemon->addIdsMovesTm((int)$move['idMove']);
				}

				//conseguindo os ids de moves de moveTutor
				$resMove = $dbManager->getData("SELECT idMove FROM movePokemon WHERE idpokemon = " .$idPoke . " AND idMoveTutor IS NOT NULL ORDER BY idMove");
				
				while($move = mysqli_fetch_assoc($resMove)) {
					$novoPokemon->addIdsMovesMoveTutor((int)$move['idMove']);
				}				
				
				//conseguindo os ids de moves de breed 
				$resMove = $dbManager->getData("SELECT idMove FROM movePokemon WHERE idpokemon = " .$idPoke . " AND breed IS NOT NULL ORDER BY idMove");
				
				while($move = mysqli_fetch_assoc($resMove)) {
					$novoPokemon->addIdsMovesBreed((int)$move['idMove']);
				}				
				
				array_push($pokeLista, $novoPokemon);
			}
			
			
			$dbManager->closeConnection();
			
			//Salvando o resultado em arquivo
			file_put_contents('pokemon.json', json_encode($pokeLista));
			//Converto para json e devolvo o resultado para o web service
			echo json_encode($pokeLista);

		}
		
		
		
		static public function getListaGeracao(){
			//Array para comportar o resultado
			$geracaoLista = Array();
			
			//inicializo a minha variavel responsavel por ligar o banco
			$dbManager = New dataBaseManager();
			
			$dbManager->openConnection();
			
			//Passo o select que eu quero para o metodo, no caso do pokemon um select simples
			$result = $dbManager->getData("SELECT 
												idGeracao, 
												numeroRomano, 
												nomeRegiao 
											FROM geracao"
			);
			
			// intero sobre todos os elemento do retorno da consulta
			while($geracao = mysqli_fetch_assoc($result)) {
				
				$novaGeracao = new geracao();
				$novaGeracao->setidGeracao((int)$geracao['idGeracao']);
				$novaGeracao->setnumeroRomano($geracao['numeroRomano']);
				$novaGeracao->setnome($geracao['nomeRegiao']);
				
				array_push($geracaoLista, $novaGeracao);
			}
			
			//Salvando o resultado em arquivo
			file_put_contents('geracao.json', json_encode($geracaoLista));
			
			echo json_encode($geracaoLista);
		}
		
		static public function getListaHabilidade(){
			//Array para comportar o resultado
			$habilidadeLista = Array();
			
			//inicializo a minha variavel responsavel por ligar o banco
			$dbManager = New dataBaseManager();
			
			$dbManager->openConnection();
			
			//Passo o select que eu quero para o metodo, no caso do pokemon um select simples
			$result = $dbManager->getData("SELECT 
												idHabilidade, 
												nome, 
												descEfeito,
												descEfeitoOutside
											FROM habilidade"
			);
			
			// intero sobre todos os elemento do retorno da consulta
			while($habilidade = mysqli_fetch_assoc($result)) {
				
				$novaHabilidade = new habilidade();
				$novaHabilidade->setidHabilidade((int)$habilidade['idHabilidade']);
				$novaHabilidade->setnome($habilidade['nome']);
				$novaHabilidade->setdescEfeito($habilidade['descEfeito']);
				$novaHabilidade->setdescEfeitoOutside(utf8_encode($habilidade['descEfeitoOutside']));
				
				
				
				$resultFirst = $dbManager->getData("SELECT idPokemon FROM habilidadepokemon WHERE idTipoHabilidadePokemon = 1 AND idHabilidade = ".$habilidade['idHabilidade']);
				
				while($habiFirst = mysqli_fetch_assoc($resultFirst)) {
					$novaHabilidade->addlistaIdsPokesFirst((int)$habiFirst['idPokemon']);
				}
				
				$resultSecond = $dbManager->getData("SELECT idPokemon FROM habilidadepokemon WHERE idTipoHabilidadePokemon = 2 AND idHabilidade = ".$habilidade['idHabilidade']);
				
				while($habiSecond = mysqli_fetch_assoc($resultSecond)) {
					$novaHabilidade->addlistaIdsPokesSecond((int)$habiSecond['idPokemon']);
				}
				
				$resultHidden = $dbManager->getData("SELECT idPokemon FROM habilidadepokemon WHERE idTipoHabilidadePokemon = 3 AND idHabilidade = ".$habilidade['idHabilidade']);
				
				while($habiHidden = mysqli_fetch_assoc($resultHidden)) {
					$novaHabilidade->addlistaIdsPokesHidden((int)$habiHidden['idPokemon']);
				}
				
				array_push($habilidadeLista, $novaHabilidade);
			}
			
			//Salvando o resultado em arquivo
			file_put_contents('habilidade.json', json_encode($habilidadeLista));
			
			echo json_encode($habilidadeLista);
		}
		
		static public function getListaTipo(){
			//Array para comportar o resultado
			$tipoLista = Array();
			
			//inicializo a minha variavel responsavel por ligar o banco
			$dbManager = New dataBaseManager();
			
			$dbManager->openConnection();
			
			//Passo o select que eu quero para o metodo, no caso do pokemon um select simples
			$result = $dbManager->getData("SELECT 
												idTipo, 
												nome, 
												nomeImg, 
												nomeImgDamage 
											FROM tipo"
			);
			
			// intero sobre todos os elemento do retorno da consulta
			while($tipo = mysqli_fetch_assoc($result)) {
				
				$novotipo = new tipo();
				$novotipo->setidTipo((int)$tipo['idTipo']);
				$novotipo->setnome($tipo['nome']);
				$novotipo->setnomeImg($tipo['nomeImg']);
				$novotipo->setnomeImgDamage($tipo['nomeImgDamage']);
				
				
				$resDanoRecebido = $dbManager->getData("SELECT 
														idTipo2, 
														dano 
														FROM danoRecebidoTipo WHERE idTipo1 = ". $tipo['idTipo']
				);
				
				
				
				while($danos = mysqli_fetch_assoc($resDanoRecebido)){					
					$novotipo->adddamageTipoTaken(new danoTaken((int)$danos['idTipo2'], (float)$danos['dano']));
				}
								
				array_push($tipoLista, $novotipo);
			}
			
			
			
			//Salvando o resultado em arquivo
			file_put_contents('tipo.json', json_encode($tipoLista));
			
			echo json_encode($tipoLista);
		}
		
		static public function getListaMove(){
		
			//Array para comportar o resultado
			$moveLista = Array();
			
			//inicializo a minha variavel responsavel por ligar o banco
			$dbManager = New dataBaseManager();
			
			$dbManager->openConnection();
			
			//Passo o select que eu quero para o metodo, no caso do pokemon um select simples
			$result = $dbManager->getData("SELECT 
											m.idMove idMove, 
											m.nome nome, 
											m.prioridade prioridade, 
											m.pp pp, 
											m.ppMax ppMax, 
											m.power power,
											m.accuracy accuracy,
											m.descricao descricao,
											cm.tipo tipoCat,
											cm.nomeImg nomeImgTipoCat,
											tc.tipo tipoCon,
											tc.nomeImg nomeImgTipoCon,
											m.idTipo idTipo,
											m.efeito efeito,
											m.chanceEfeito chanceEfeito,
											t.target target,
											tm.numeroTm numeroTm,
											mt.localizacao localizacao,
											mt.valor valor,
											zm.zCrystal zCrystal,
											zm.nomeImg nomeImgZcrystal,
											idMoveRequerido idMoveRequerido,
											zm.efeitoAdicional efeitoAdicional
										FROM move m
										INNER JOIN categoriaMove cm ON cm.idCategoriaMove = m.idCategoriaMove
										INNER JOIN target t ON t.idTarget = m.idTarget
										LEFT JOIN tipoContest tc ON tc.idTipoContest = m.idTipoContest                                                         
										LEFT JOIN tmMove tm ON tm.idMove = m.idMove AND tm.idGeracao = 7
										LEFT JOIN moveTutors mt ON mt.idMove = m.idMove and mt.idGeracao = 7
										LEFT JOIN zMove zm ON zm.idMove = m.idMove order by m.idMove"
			);
			
			// intero sobre todos os elemento do retorno da consulta
			while($move = mysqli_fetch_assoc($result)) {
				
				$novomove = new move();
				
				$novomove->setidMove((int)$move['idMove']);
				$novomove->setnome($move['nome']);
				$novomove->setprioridade((int)$move['prioridade']);
				$novomove->setpp((int)$move['pp']);
				$novomove->setppMax((int)$move['ppMax']);
				$novomove->setpower((int)$move['power']);
				$novomove->setaccuracy((float)$move['accuracy']);
				$novomove->setdescricao($move['descricao']);
				$novomove->setcategoriaMove($move['tipoCat']);
				$novomove->setnomeImgCategoriaMove($move['nomeImgTipoCat']);
				$novomove->setcontestMove($move['tipoCon']);
				$novomove->setnomeImgContestMove($move['nomeImgTipoCon']);
				$novomove->setidTipo((int)$move['idTipo']);
				$novomove->setefeito($move['efeito']);
				$novomove->setchanceEfeito((float)$move['chanceEfeito']);
				$novomove->settarget($move['target']);
				$novomove->setnumeroTM((int)$move['numeroTm']);
				$novomove->setlocMoveTutor($move['localizacao']);
				$novomove->setvalorMoveTutor($move['valor']);
				$novomove->setzCrystal($move['zCrystal']);
				$novomove->setnomeImgzCrystal($move['nomeImgZcrystal']);
				$novomove->setidMoveRequerido((int)$move['idMoveRequerido']);
				$novomove->setefeitoAdicional($move['efeitoAdicional']);
				
				$resultLv = $dbManager->getData("SELECT idPokemon FROM movepokemon WHERE level IS NOT NULL AND idMove = ".$move['idMove']);
				
				while($moveLv = mysqli_fetch_assoc($resultLv)) {
					$novomove->addlistaIdsPokesLevelUp((int)$moveLv['idPokemon']);
				}
				
				$resultTm = $dbManager->getData("SELECT idPokemon FROM movepokemon WHERE idTm IS NOT NULL AND idMove = ".$move['idMove']);
				
				while($moveTM = mysqli_fetch_assoc($resultTm)) {
					$novomove->addlistaIdsPokesTm((int)$moveTM['idPokemon']);
				}
				
				$resultMt = $dbManager->getData("SELECT idPokemon FROM movepokemon WHERE idMoveTutor IS NOT NULL AND idMove = ".$move['idMove']);
				
				while($moveMt = mysqli_fetch_assoc($resultMt)) {
					$novomove->addlistaIdsPokesMoveTutor((int)$moveMt['idPokemon']);
				}
				
				$resultBd = $dbManager->getData("SELECT idPokemon FROM movepokemon WHERE breed IS NOT NULL AND idMove = ".$move['idMove']);
				
				while($moveBd = mysqli_fetch_assoc($resultBd)) {
					$novomove->addlistaIdsPokesBreed((int)$moveBd['idPokemon']);
				}
				
				array_push($moveLista, $novomove);

			}
			
			//Salvando o resultado em arquivo
			file_put_contents('move.json', json_encode($moveLista));
			
			echo json_encode($moveLista);
		
		}
		
		static public function getListaEggGroup(){
			//Array para comportar o resultado
			$eggLista = Array();
			
			//inicializo a minha variavel responsavel por ligar o banco
			$dbManager = New dataBaseManager();
			
			$dbManager->openConnection();
			
			//Passo o select que eu quero para o metodo, no caso do pokemon um select simples
			$result = $dbManager->getData("SELECT 
												idEggGroup, 
												nome, 
												nomeImg 
											FROM eggGroup"
			);
			
			// intero sobre todos os elemento do retorno da consulta
			while($egg = mysqli_fetch_assoc($result)) {
				
				$novoeggG = new eggGroup();
				$novoeggG->setidEggGroup((int)$egg['idEggGroup']);
				$novoeggG->setnome($egg['nome']);
				$novoeggG->setnomeImg($egg['nomeImg']);	
				
				$resListaPokemon = $dbManager->getData("SELECT idPokemon FROM pokemonEgggroup WHERE idEggGroup =". $egg['idEggGroup']);

				while($poke = mysqli_fetch_assoc($resListaPokemon)){					
					$novoeggG->addlistaPokemon((int)$poke['idPokemon']);
				}
				
				array_push($eggLista, $novoeggG);
			}
			
			//Salvando o resultado em arquivo
			file_put_contents('eggGroup.json', json_encode($eggLista));
			
			echo json_encode($eggLista);
		}
		
	}
	
//===================================================================================================

	//Switch que executa o metodo de selecao que eu escolhi via requisicao get
	
//===================================================================================================
	
	if(isset($_GET['getData'])){
		switch ($_GET['getData']){
			case 1:
				getData::getListaPokemon();
				break;
			case 2:
				getData::getListaGeracao();
				break;
			case 3:
				getData::getListaTipo();
				break;
			case 4:
				getData::getListaMove();
				break;
			case 5:
				getData::getListaHabilidade();
				break;
			case 6:
				getData::getListaEggGroup();
				break;
		}
	}

?>