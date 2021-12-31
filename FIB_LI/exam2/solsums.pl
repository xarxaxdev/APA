:- use_module(library(clpfd)).

    
% We want to generalize the well-known puzzle SEND+MORE=MONEY: assign distinct digits in 0..9 to each letter
% such that the sum is correct, for example,  2817+0368=03185.
% For instance we want to do LI+IS+NICE = TRUE.
% Complete the following program:

main:- puzzle( [L,I] + [I,S] + [N,I,C,E] = [T,R,U,E]   ),  write( [L,I] + [I,S] + [N,I,C,E] = [T,R,U,E]   ), nl,nl,halt.
main:- puzzle( [S,E,N,D] + [M,O,R,E]     = [M,O,N,E,Y] ),  write(   [S,E,N,D] + [M,O,R,E]   = [M,O,N,E,Y] ), nl,nl,halt.
main:- write('no solution'), nl,nl, halt.

puzzle(L1+L2+L3=R):-
    append(  L1,L2, L12),
    append( L12,L3,L123),
    append(L123, R,   L), sort(L,Vars),
    Vars ins 0..9,
    all_different(Vars),
    makeSum(L1,S1),
    makeSum(L2,S2),
    makeSum(L3,S3),
    makeSum( R, S),
    S1 + S2 + S3 #= S,
    label(Vars),!.

puzzle(L1+L2=R):-
    append( L1,L2, L12),
    append(L12, R,   L), sort(L,Vars),
    Vars ins 0..9,
    all_different(Vars),
    makeSum(L1,S1),
    makeSum(L2,S2),
    makeSum( R, S),
    S1 + S2 #= S,
    label(Vars),!.


makeSum(L,S):- reverse(L,L1), makeSum1(1,L1,S),!. % e.g., makeSum( [A,B,C],  1*C + 10*B + 100*A).

makeSum1(F,[S],F*S):-!.
makeSum1(F,[S|L],F*S+S1):- F1 is F*10, makeSum1(F1,L,S1),!.

