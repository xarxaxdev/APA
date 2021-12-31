/*1. Dado un natural N, definimos la secuencia de naturales que empieza
   por N y en la que cada nÃºmero es igual a la suma de los cuadrados
   de los dÃ­gitos del nÃºmero anterior. Ejemplo: 44, 32, 13, 10, 1.

   Escribe un predicado Prolog que, dado un nÃºmero N, determine si
   dicha secuencia converge a 1. Nota: el predicado deberÃ­a detectar
   ciclos que no contienen el uno para evitar la no-terminaciÃ³n del
   programa.  */

%digits(N,L) da cierto si L es la lista de dígitos que concatenada compone N
digits(N,[N]):-between(0,9,N).
digits(N,[L1|L]):-
  N1 is floor(N/10),
  L1 is N mod 10,!,
  digits(N1,L).

sumaquadrados([X],Y):- Y is X*X.
sumaquadrados([L1|L],Y):- sumaquadrados(L,Rest),Y is Rest+(L1*L1).

converge(1,_).
converge(X,Visited):-
  digits(X,L),
  sumaquadrados(L,Ans),!,
  not( member(Ans,Visited)),
  converge(Ans,[X|Visited]).


%converge(1).
%converge(4):-!,fail.
converge(N):- converge(N,[]).
/*  digits(N,L),
  sumaquadrados(L,Ans),!,
  converge(Ans).*/
