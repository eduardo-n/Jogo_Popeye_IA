
%                                            CENÁRIO                               %

garrafa([1,2]).
garrafa([1,8]).
garrafa([2,7]).
garrafa([3,6]).
garrafa([3,5]).
garrafa([4,4]).
garrafa([4,5]).
garrafa([4,9]).
garrafa([5,8]).

escada([[1,4],[2,5]]).
escada([[2,10],[3,9]]).
escada([[3,2],[4,1]]).
escada([[3,9],[4,10]]).
escada([[4,3],[5,2]]).
escada([[4,6],[5,7]]).

coracao([[1,10],[2,1],[2,2],[3,3],[3,7],[5,9]]).

espinafre([3,4]).

brutus([5,10]).





%                                       MOVIMENTAÇÃO                            %


/*--------Início do Bloco movimentacao sem espinafre, logo nao pode passar pelo brutus--------*/ 

/*movimentacao pra subir pela escada*/
movimentacaoSemEspinafre([X,Y],[X2,Y2],Brutus):-
	escada([[X,Y],[X2,Y2]]), 
	not(garrafa([X2,Y2])),
	[X2,Y2] \= Brutus.

/*movimentacao pra descer pela escada*/
movimentacaoSemEspinafre([X,Y],[X2,Y2],Brutus):- 
	escada([[X2,Y2],[X,Y]]), 
	not(garrafa([X2,Y2])),
	[X2,Y2] \= Brutus.

/*movimentacao para direita sem obstaculo*/
movimentacaoSemEspinafre([X,Y],[X,Y2],Brutus):- 
	Y<10, 
	Y2 is Y+1,
	not(garrafa([X,Y2])), 
	[X,Y2] \= Brutus.
	
/*movimentacao para direita com obstaculo*/
movimentacaoSemEspinafre([X,Y],[X,Y2],Brutus):- 
	Y<9, 
	Y1 is Y+1, 
	Y2 is Y+2, 
	garrafa([X,Y1]), 
	not(garrafa([X,Y2])), 
	[X,Y1] \= Brutus, 
	[X,Y2] \= Brutus.

/*movimentacao para esquerda sem obstaculo*/
movimentacaoSemEspinafre([X,Y],[X,Y2],Brutus):- 
	Y>1, 
	Y2 is Y-1, 
	not(garrafa([X,Y2])), 
	[X,Y2] \= Brutus.

/*movimentacao para esquerda com obstaculo*/
movimentacaoSemEspinafre([X,Y],[X,Y2],Brutus):- 
	Y>1, 
	Y1 is Y-1, 
	Y2 is Y-2, 
	garrafa([X,Y1]), 
	not(garrafa([X,Y2])), 
	[X,Y1] \= Brutus, 
	[X,Y2] \= Brutus.

/*---------Fim do Bloco movimentacao sem espinafre, logo nao pode passar pelo brutus---------*/ 



/*--------Início do Bloco de movimentacao com espinafre, logo pode passar pelo brutus--------*/ 

/*movimentacao pra subir pela escada*/
movimentacaoComEspinafre([X,Y],[X2,Y2]):-
	escada([[X,Y],[X2,Y2]]),
	not(garrafa([X2,Y2])).

/*movimentacao pra descer pela escada*/
movimentacaoComEspinafre([X,Y],[X2,Y2]):- 
	escada([[X2,Y2],[X,Y]]),
	not(garrafa([X,Y2])).

/*movimentacao para direita sem obstáculo*/
movimentacaoComEspinafre([X,Y],[X,Y2]):- 
	Y<10,
	Y2 is Y+1,
	not(garrafa([X,Y2])).

/*movimentacao para direita com obstáculo*/
movimentacaoComEspinafre([X,Y],[X,Y2]):- 
	Y<9, 
	Y1 is Y+1, 
	Y2 is Y+2, 
	garrafa([X,Y1]), 
	not(garrafa([X,Y2])).

/*movimentacao para esquerda sem obstáculo*/
movimentacaoComEspinafre([X,Y],[X,Y2]):- 
	Y>1, 
	Y2 is Y-1, 
	not(garrafa([X,Y2])).

/*movimentacao para esquerda com obstáculo*/
movimentacaoComEspinafre([X,Y],[X,Y2]):- 
	Y>2, 
	Y1 is Y-1, 
	Y2 is Y-2, 
	garrafa([X,Y1]), 
	not(garrafa([X,Y2])).

/*---------------------- Fim do Bloco de movimentacao com espinafre-------------------------*/





%                                       MANIPULAÇÃO DE LISTAS                             %


/*Verificar se o elemento pertence a lista*/
pertence(Elem,[Elem|_]).
pertence(Elem,[_|Cauda]):- 
	pertence(Elem,Cauda).

/*Concatenar lista*/
concatena([], L, L).
concatena([Cab|L1], L2,[Cab|L3]):-
	concatena(L1, L2, L3).

/*Inverter lista*/
inverter([],[]).
inverter([Elem|Cauda], Lista_Invertida):-
	inverter(Cauda,Cauda_Invertida),
	concatena(Cauda_Invertida,[Elem], Lista_Invertida).

/*Retirar um elemento da lista*/
retirar_elemento(Elem,[Elem|Cauda],Cauda).
retirar_elemento(Elem,[Elem1|Cauda],[Elem1|Cauda1]):- 
	retirar_elemento(Elem,Cauda,Cauda1).

/*exibir ultimo elemento da lista*/
retornar_ultimo(X,[X]).       
retornar_ultimo(X, [_|T]):- 
	retornar_ultimo(X,T).   

/*retorna o primeiro elemento da lista*/
retornar_primeiro(X,[X|_]).





%                                 FUNÇÃO DE BUSCA                                %


% Busca em largura

solucao_bl(Popeye,[Coracao|Cauda],Espinafre,Brutus,Solucao,Pontos):- 
	busca_em_largura_sem_espinafre([[Popeye]],Coracao,Solucao1,Brutus),
    (
		/*só tem 1 coracão*/
		Cauda = [] , 
		retornar_primeiro(PontosTemp,Coracao),
		Pontos is PontosTemp *100,
		busca_em_largura_sem_espinafre([[Coracao]],Espinafre,Solucao5,Brutus),
		concatena(Solucao5,Solucao1,Solucao6),
		retirar_elemento(Coracao,Solucao6,Solucao7)
	; 
		/*tem 2 ou mais corações*/
		recursivo(Coracao,Cauda,Solucao2,Brutus,[],[],Pontos,Pontos),
		concatena(Solucao2,Solucao1,Solucao3),
		retirar_elemento(Coracao,Solucao3,Solucao4),
		retornar_ultimo(X,Cauda),
		busca_em_largura_sem_espinafre([[X]],Espinafre,Solucao6,Brutus),
		retirar_elemento(X,Solucao4,Solucao5),
		concatena(Solucao6,Solucao5,Solucao7)
		
	),
    busca_em_largura_com_espinafre([[Espinafre]],Brutus,Solucao8),
    concatena(Solucao8,Solucao7,Solucao9),
    retirar_elemento(Espinafre,Solucao9,Solucao10),
    inverter(Solucao10,Solucao).



/*Regra recursiva para somar os caminhos de um coracao até o outro*/
recursivo(Elem,[Cauda|Cauda1],Solucao,Brutus,SomaSolucao,Cauda2,TotalPontos,SomaPontos):- 
    busca_em_largura_sem_espinafre([[Elem]],Cauda,Solucao0,Brutus),
	concatena(Solucao0,SomaSolucao,Solucao2),
	(
	/*a primeira vez cai aqui*/
	Cauda2 = [] ,
		/*se so tiver 2 coracoes*/
		(Cauda1 = [],
		concatena(Solucao2,[],Solucao),
		retornar_primeiro(PontosTemp1,Elem),
		PontosTemp is PontosTemp1 *100,
		retornar_primeiro(PontosTemp2,Cauda),
		TotalPontos is PontosTemp2 *100 + PontosTemp
		; 
		/*se tiver mais de 2 coracoes*/
		retornar_primeiro(PontosTemp1,Elem),
		PontosTemp is PontosTemp1 *100,
		recursivo(Cauda,Cauda1,Solucao,Brutus,Solucao2,Cauda,TotalPontos,PontosTemp))
	; 
	/*segunda vez em diante cai aqui*/
	retirar_elemento(Cauda2,Solucao2,Solucao3),
		/*se so restar 2 coracoes*/
		(Cauda1 = [],
		concatena(Solucao3,[],Solucao),
		retornar_primeiro(PontosTemp1,Elem),
		PontosTemp is PontosTemp1 *100 + SomaPontos,
		retornar_primeiro(PontosTemp3,Cauda),
		TotalPontos is PontosTemp3 *100 + PontosTemp
		; 
		/*se restar mais de 2 coracoes*/
		retornar_primeiro(PontosTemp1,Elem),
		PontosTemp is PontosTemp1 *100 + SomaPontos,
		PontosTemp2 is PontosTemp,
		recursivo(Cauda,Cauda1,Solucao,Brutus,Solucao3,Cauda,TotalPontos,PontosTemp2))
	).




/* -------Início de regras de busca para quando o espinafre ainda não foi encontrado ---------*/


busca_em_largura_sem_espinafre([[Estado|Caminho]|_],Destino,[Estado|Caminho],Brutus):- 
	Destino=Estado,Brutus=Brutus.

busca_em_largura_sem_espinafre([Primeiro|Outros],Destino,Solucao,Brutus):- 
	estende_sem_espinafre(Primeiro,Sucessores,Brutus),
	concatena(Outros,Sucessores,NovaFronteira),
	busca_em_largura_sem_espinafre(NovaFronteira,Destino,Solucao,Brutus).

estende_sem_espinafre([Estado|Caminho],ListaSucessores,Brutus):- 
	bagof([Sucessor,Estado|Caminho],(movimentacaoSemEspinafre(Estado,Sucessor,Brutus),not(pertence(Sucessor,[Estado|Caminho]))),ListaSucessores),
	!.

estende_sem_espinafre(_,[],_).


/* --------Fim de regras de busca para quando o espinafre ainda não foi encontrado -----------*/



/*-------------- Início de busca para quando o espinafre já foi encontrado ------------------ */


busca_em_largura_com_espinafre([[Estado|Caminho]|_],Destino,[Estado|Caminho]):- 
	Destino=Estado.

busca_em_largura_com_espinafre([Primeiro|Outros],Destino,Solucao):- 
	estende_com_espinafre(Primeiro,Sucessores),
	concatena(Outros,Sucessores,NovaFronteira),
	busca_em_largura_com_espinafre(NovaFronteira,Destino,Solucao).

estende_com_espinafre([Estado|Caminho],ListaSucessores):- 
	bagof([Sucessor,Estado|Caminho],(movimentacaoComEspinafre(Estado,Sucessor),not(pertence(Sucessor,[Estado|Caminho]))),ListaSucessores),
	!.

estende_com_espinafre(_,[]).


/* ---------------Fim de busca para quando o espinafre já foi encontrado ------------------ */





%                                FUNÇÃO MAIN                                    %

main(Popeye):- 
	coracao(X),
	espinafre(Y),
	brutus(Z),
	solucao_bl(Popeye,X,Y,Z,Solucao,Pontos),
	write("
	Caminho total percorrido por Popeye :   
	"), write(Solucao),
	write("

	Localizacao do Coracao : "),write(X),
	write("

	Localizacao do Espinafre : "),write(Y),
	write("

	Localizacao do Brutus : "),write(Z),
	write("

	Pontuacao : "),write(Pontos),
	write("
	"),
	!.