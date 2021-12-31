%EJERCICIO 2
%prof(L,P) P es el producto de los elementos de la lista de enteros L
enteros(0).
enteros(N):- enteros(N1), N is N1 + 1.
enteros(N):- enteros(N1), N is N1 - 1.


prod([P], P).
prod([L1|LN],P):- prod(LN,R), P is L1 * R.

%1 10 5 9 11 8 3 20 18 14 12 15 2 7 13 19 6 17 16 4 1
%1 10 4 8 3 20 12 15 18 14 7 13 19 6 17 16 2 5 9 11 1
%EJERCICIO 3
% pescalar(L1,L2,P) P es el producto escalar de L1,L2
pescalar([],[],0).
pescalar([],_,_):- fail .
pescalar(_,[],_):- fail .
pescalar([X|L1], [Y|L2], P):- pescalar(L1,L2,Rest) , P is X*Y + Rest.



%EJERCICIO 4
%interseccion y union de dos conjuntos
in(X, [X|_]).
in(X, [_|L]):- in(X,L).

not(P) :- P, !, fail.
not(_).

not_in(X, Y) :- not(in(X, Y)).

%interseccion(X,Y,X&Y)
interseccion([],_,[]).
interseccion([X1|X] ,Y, [X1|XY]) :- in(X1,Y) , !, interseccion(X,Y,XY) .
interseccion([X1|X], Y, XY) :- not_in(X1,Y), interseccion(X,Y,XY).
%union(X,Y, XUY).
union([],Y,Y).
union([X1|X],Y, XY):- in(X1, Y),!, union(X,Y,XY).
union([X1|X],Y, [X1|XY]):- union(X,Y,XY).

%EJERCICIO 5
%usando concat, implementar:
%ultimo(L,X) donde X es el ultimo elemento de una lista
%reverse(L,RL) donde RL es L invertida

%concat (A , B , A+B)
concat([],L,L).
concat([X |L1],L2,[X|L3]):- concat(L1,L2,L3).

ultimo(L,X):- concat(_,[X],L).

reverse([],[]).
reverse(L, [R1|R]):- concat(R2,[R1],L), reverse(R,R2).


%EJERCICIO 6
%fib(N,F) f es el N-esimo fibonacci
fib(1,1):-!.
fib(2,1):-!.
fib(N,F):-
  N>2,
  N1 is N-1,
  N2 is N-2,
  fib(N1,F1), fib(N2,F2), F is F1+F2.

%EJERCICIO 7
%dados(P,N,L) L es una lista de combinaciones de sumar P con N dados

dados(0,0,[]).
dados(P,N,X|L):-
  N > 0, in(X,[1,2,3,4,5,6]),
  N1 is N-1,P1 is P - X,
  dados(P1,N1,L).

%EJERCICIO 8
%suma_demas(L) funciona solo si uno de los elementos es la suma de los demas

suma([],0).
suma([X|L],S) :- suma(L,S1), S is S1+X.

%generamos todos los elementos posibles, miramos si la suma del resto= X
suma_demas(L) :- pert_con_resto(X,L,R), suma(R,X), !.

%EJERCICIO 9
%suma_ants(L) funciona solo si uno de los elementos es la suma de los anteriore
suma_ants(L):- concat(L1,[X|_],L),suma(L1,X),!.

%EJERCICIO 10
%card(L) escribe para cada elemento en L sus ocurrencias
pert_con_resto(X,L,Resto):-  concat(L1,[X|L2], L), concat(L1,L2, Resto).

card([],[]).
%el siguiente elemento estaba ya en nuestra lista de pares.
%pert_con_resto([X1,N],C,CRest)= X1,N debía aparecer en C, así CRest será
%simplemente como queda despues de quitarlo
card( [X1|L] , [ [X1,N1] |CRest] ):-card(L,C),pert_con_resto([X1,N],C,CRest),!,N1 is N+1.
%el siguiente elemento no estaba
card( [X|L] , [ [X,1]   |C] ):-card(L,C).

card(L):-card(L,C),write(C).

%EJERCICIO 11
%ordered(L) evalua a cierto si L esta ordenada
ordered([]).
ordered([_]).
ordered([A,B|L]):- A =< B, ordered([B|L]).

%EJERCICIO 12
%ordenacion(L1,L2) L2 es la lista L1 ordenada.

permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).
%pongo ! porqué una solución ordenada será la misma que cualquier otra
ordenacion(A,B):- permutacion(A,B),ordered(B),!.

%EJERCICIO 13
% Sea n la longitud de la lista L.
% BEST CASE
% esta_ordenada(L) tiene complejidad lineal, ya que se hacen n-1 comparaciones
% WORST CASE
% En el peor caso el predicado ordenacion(L,LO) tiene que generar todas las
% permutaciones (hay n!) y comprobar que si están ordenadas. Por tanto en el
% peor caso el coste es (n!)n , donde n es la longitud de la lista L.
% Complejidad factorial en n+1.
% Nótese que n! crece muy rápido: 2^n < n! a partir de n=4.


%EJERCICIO 14
%ordenacion por insercion,
%insert(X,L1,L2)L2 es el resultado(ordenado) de insertar X en L1(que viene ordenada)
insert(X,[],[X]).
insert(X,[L1|L],[X,L1|L]):-X  =< L1.
insert(X,[L1|L],[L1|R]):- X > L1, insert(X,L,R).

ordenacion2([],[]).
ordenacion2([L1|L],R):-  ordenacion2(L,R1),insert(L1,R1,R).

%EJERCICIO 15
%peor caso: tener que recorrer L2 por cada elemento de L1 : esto es quadrático
% O(N^2).
%en el mejor caso es lineal O(N)


%EJERCICIO 16
%mergesort(L1,L2) L2 es L1 ordenada
merge([],[],[]). %no lo llamaremos recursivamente
merge([],L,L).
merge(L,[],L).
merge([X1|X],[Y1|Y],[X1|R]):- X1 =< Y1,! , merge(X,[Y1|Y],R).
merge([X1|X],[Y1|Y],[Y1|R]):- merge([X1|X],Y,R).

split([],[],[]).
split([X],[X],[]).
split([A,B|L], [A|X], [B|Y]):- split(L,X,Y).


mergesort([],[]):-!.
mergesort([X],[X]):-!.
mergesort(L,R):-
  split(L,LE,LR),
  mergesort(LE,LEO), mergesort(LR,LRO),
  merge(LEO,LRO,R).


%EJERCICIO 17
% diccionario(A,N) dado un alfabeto A da todas las palabras de N símbolos,
%por orden alfabetico
%L tiene la lista de palabras de diccionario
nmembers(_,0,[]):-!.
nmembers(L,N,[Y|R]):- in(Y,L), N1 is N-1,nmembers(L,N1,R).

writeAll([]) :- !.
writeAll([X|L]) :- write(X), writeAll(L).

diccionario(A, N) :- nmembers(A, N, M), writeAll(M), write(' '), fail.
diccionario(_, _) :- nl.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%PROBLEMA_18%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
palindromos(L) :- setof(P,(permutacion(L,P), es_palindromo(P)),S),
  write(S), nl, fail.
palindromos(_).

es_palindromo([]).
es_palindromo([_]) :- !. % regla adecuada
es_palindromo([X|L]) :- concat(L1,[X],L), es_palindromo(L1).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%PROBLEMA_19%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%19
suma19([],[],[],C,C).
suma19([X1|L1],[X2|L2],[X3|L3],Cin,Cout) :-
	X3 is (X1 + X2 + Cin) mod 10,
	C  is (X1 + X2 + Cin) //  10,
	suma19(L1,L2,L3,C,Cout).


send_more_money1 :-

	L = [S, E, N, D, M, O, R, Y, _, _],
	permutacion(L, [0,1,2,3,4,5,6,7,8,9]),
	suma19([D, N, E, S], [E, R, O, M], [Y, E, N, O], 0, M),

	write('S = '), write(S), nl,
	write('E = '), write(E), nl,
	write('N = '), write(N), nl,
	write('D = '), write(D), nl,
	write('M = '), write(M), nl,
	write('O = '), write(O), nl,
	write('R = '), write(R), nl,
	write('Y = '), write(Y), nl,
	write('  '), write([S,E,N,D]), nl,
	write('  '), write([M,O,R,E]), nl,
	write('-------------------'), nl,
	write([M,O,N,E,Y]), nl.


send_more_money2 :-

	L = [0,1,2,3,4,5,6,7,8,9],
	pert_con_resto(M,  [0,1], _),
	pert_con_resto(M,  L,  L0),
	pert_con_resto(O, L0, L1),
	pert_con_resto(R, L1, L2),
	pert_con_resto(Y, L2, L3),
	pert_con_resto(S, L3, L4),
	pert_con_resto(E, L4, L5),
	pert_con_resto(N, L5, L6),
	pert_con_resto(D, L6, _),
	suma19([D, N, E, S], [E, R, O, M], [Y, E, N, O], 0, M),

	write('S = '), write(S), nl,
	write('E = '), write(E), nl,
	write('N = '), write(N), nl,
	write('D = '), write(D), nl,
	write('M = '), write(M), nl,
	write('O = '), write(O), nl,
	write('R = '), write(R), nl,
	write('Y = '), write(Y), nl,
	write('  '), write([S,E,N,D]), nl,
	write('  '), write([M,O,R,E]), nl,
	write('-------------------'), nl,
	write([M,O,N,E,Y]), nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%PROBLEMA_20%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


simplifica(E,E1):- unpaso(E,E2),!, simplifica(E2,E1).
simplifica(E,E).

unpaso(A+B,A+C):- unpaso(B,C),!.
unpaso(B+A,C+A):- unpaso(B,C),!.
unpaso(A*B,A*C):- unpaso(B,C),!.
unpaso(B*A,C*A):- unpaso(B,C),!.
unpaso(0*_,0):-!.
unpaso(_*0,0):-!.
unpaso(1*X,X):-!.
unpaso(X*1,X):-!.
unpaso(0+X,X):-!.
unpaso(X+0,X):-!.
unpaso(N1+N2,N3):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(N1*N2,N3):- number(N1), number(N2), N3 is N1*N2,!.
unpaso(N1*X+N2*X,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(N1*X+X*N2,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(X*N1+N2*X,N3*X):- number(N1), number(N2), N3 is N1+N2,!.
unpaso(X*N1+X*N2,N3*X):- number(N1), number(N2), N3 is N1+N2,!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%PROBLEMA_21%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mis:- camino( [lado1,3,3], [lado2,0,0], [[lado1,3,3]] ).

camino(Fin,Fin,Cam):- inverso(Cam,Sol), write(Sol), nl.
camino(Ini,Fin,Cam):- paso(Ini,E), novisitado(E,Cam), camino(E,Fin,[E|Cam]).

novisitado(E,Cam):- pert(E,Cam), !,fail.
novisitado(_,_).

paso( [lado1,M1,C1], [lado2,M2,C2] ):- pasan(M,C), M2 is M1-M, C2 is C1-C, safe(M2,C2).
paso( [lado2,M1,C1], [lado1,M2,C2] ):- pasan(M,C), M2 is M1+M, C2 is C1+C, safe(M2,C2).

pasan(M,C):- member( [M,C], [ [0,1], [0,2], [1,0], [1,1], [2,0] ] ).

safe(M,C):- M>=0, M=<3, C>=0, C=<3, nocomen( M, C),
            M1 is 3-M,  C1 is 3-C,  nocomen(M1,C1).

nocomen(0,_).
nocomen(M,C):- M>=C.
