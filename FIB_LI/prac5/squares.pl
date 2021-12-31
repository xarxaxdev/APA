:- use_module(library(clpfd)).

%ejemplo(_, Big, [S1...SN]): how to fit all squares of sizes S1...SN in a square of size Big?
ejemplo(0,  3,[2,1,1,1,1,1]).
ejemplo(1,  4,[2,2,2,1,1,1,1]).
ejemplo(2,  5,[3,2,2,2,1,1,1,1]).
ejemplo(3, 19,[10,9,7,6,4,4,3,3,3,3,3,2,2,2,1,1,1,1,1,1]).
ejemplo(4,112,[50,42,37,35,33,29,27,25,24,19,18,17,16,15,11,9,8,7,6,4,2]).
ejemplo(5,175,[81,64,56,55,51,43,39,38,35,33,31,30,29,20,18,16,14,9,8,5,4,3,2,1]).

main:-
    ejemplo(3,Big,Sides),
    nl, write('Fitting all squares of size '), write(Sides), write(' into big square of size '), write(Big), nl,nl,
    length(Sides,N),
    length(RowVars,N), % get list of N prolog vars: Row coordinates of each small square
    length(ColVars,N),
    RowVars ins 1..Big,%cardinalities
    ColVars ins 1..Big,
    insideBigSquare(Big,Sides,RowVars),%no need for the length since
    insideBigSquare(Big,Sides,ColVars),%we will treat every Var
    nonoverlapping(Sides,RowVars,ColVars),
    append(RowVars,ColVars,AllVars),
    labeling([ffc],AllVars),%ffc d'acord amb el que vam fer al SAT
    displaySol(N,Sides,RowVars,ColVars), halt.



insideBigSquare(_,[],[]):- !.
insideBigSquare( Big, [S|Sides], [V|Vars]):-
  V+ S -1 #=< Big,%a block must be insertable within boundaries
  insideBigSquare(Big,Sides,Vars).

nonoverlapping([],[],[]).
nonoverlapping([S|Sides],[R|Row],[C|Col]):-
  nonoverlap(S,R,C,Sides,Row,Col),
  nonoverlapping(Sides, Row, Col).

%given a square and position return whether
%there exists a compatible combination
nonoverlap(_,_,_,[],[],[]).
nonoverlap(S,R,C,[S2|Sides],[R2|Row],[C2|Col]):-
  R2 #>= R+S  #\/ % or
  C2 #>= C+S  #\/
  R2 #=< R - S2 #\/
  C2 #=< C - S2,
  nonoverlap(S,R,C,Sides,Row,Col).

/**alternativa nonoverlapping
nonoverlapping(Sides, RowVars, ColVars):-
  createRectangles(Sides, RowVars, ColVars, L),
  disjoint2(L).

createRectangles([], [], [], []):-!.
createRectangles([X | Sides], [Y | RowVars], [Z | ColVars], [A | L]):-
  A = f(Y, X, Z, X),
  createRectangles(Sides, RowVars, ColVars, L).

**/


displaySol(N,Sides,RowVars,ColVars):-
    between(1,N,Row), nl, between(1,N,Col),
    nth1(K,Sides,S),
    nth1(K,RowVars,RV),    RVS is RV+S-1,     between(RV,RVS,Row),
    nth1(K,ColVars,CV),    CVS is CV+S-1,     between(CV,CVS,Col),
    writeSide(S), fail.
displaySol(_,_,_,_):- nl,nl,!.

writeSide(S):- S<10, write('  '),write(S),!.
writeSide(S):-       write(' ' ),write(S),!.
