
%concat (A , B , A+B)
concat([],L,L).
concat([X |L1],L2,[X|L3]):- concat(L1,L2,L3).

%funcion de pertenencia (elem, lista)
%is_in(X,[X,_]).
%is_in(X, [_ | L]) :- is_in(X,L).
%aqui decimos: X está en L si existe alguna combinación en que X esté dentro de una lista
%y L sea la concatenación de está lista y otra
is_in(X,L) :- concat(_, [X|_], L).


%coge X de L y deja el resto en Resto
pert_con_resto(X,L,Resto):-  concat(L1,[X|L2], L), concat(L1,L2, Resto).

% longitud de una lista
long([],0).
long([_|L],M):- long(L,N), M is N+1.

%factores_primos(X,L) da los factores primos de L(con repeticiones)
factores_primos(1,[]) :- !.%no se xk se necesita !
factores_primos(N,[F|L]):-
  nat(F), F>1,
  0 is N mod F,
  N1 is N // F,
  factores_primos(N1,L),
  !.

%pert_con_resto coge un elemento de L, luego se devuelve la permutación de
%la parte restante de (que será la parte restante de permutacion)
permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).

%subcjto(L,S) es: "S es un subconjunto de L".
subcjto([],[]).
%quitamos un elemento de C y S
subcjto([X|C],[X|S]):-subcjto(C,S).
%o solo de C
subcjto([_|C],S):-subcjto(C,S).


%fact(X,F)=el factorial de X es F
fact(0,1):-!.
fact(X,F) :- X1 is X-1, fact(X1,F1), F is X*F1,!.

%define cualquier natural
nat(0).
nat(N):- nat(N1), N is N1 + 1.

%dado una X e Y, M es su min comun multiplo
mcm(X,Y,M):- nat(M), M > 0, 0 is M mod X, 0 is M mod Y .
%mcm(X,Y,M):- nat(N), N > 0, M is N * X, 0 is M mod Y .%alternativa eficiente




%juego cifras, nos dice si hay una combinacion usando[*,+,-] de elementos de L
%tal que el resultado sea N
cifras(L,N):- subcjto(L,S), permutacion(S,P), expresion(P,E),
N is E, write(E),nl,fail.

%expresion(P,X) dada una lista de números nos da todas las posibles combinaciones
%de suma,resta y multiplicacion con ellos
expresion([X],X).
expresion(L,E1+E2):- concat(L1,L2,L), L1\=[], L2\=[],
  expresion(L1,E1), expresion(L2,E2).
expresion(L,E1-E2):- concat(L1,L2,L), L1\=[], L2\=[],
  expresion(L1,E1), expresion(L2,E2).
expresion(L,E1*E2):- concat(L1,L2,L), L1\=[], L2\=[],
  expresion(L1,E1), expresion(L2,E2).





%calculo de derivadas der(E,X,D) = la derivada de E respecto X es D
der(X,X,1):-!.
der(C,_,0):- number(C).
der(A+B,X,DA+DB):- der(A,X,DA),der(B,X,DB).
der(A-B,X,DA-DB):- der(A,X,DA),der(B,X,DB).
der(A*B,X,A*DB+B*DA):- der(A,X,DA),der(B,X,DB).
der(sin(A),X,cos(A)*DA):- der(A,X,DA).
der(cos(A),X,-sin(A)*DA):- der(A,X,DA).
der(eˆA,X,DA*eˆA):- der(A,X,DA).
der(ln(A),X,DA*1/A):- der(A,X,DA).
