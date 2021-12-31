padre(juan,pedro).
padre(maria,pedro).
hermano(pedro,vicente).
hermano(pedro,alberto).
tio(X,Y):- padre(X,Z), hermano(Z,Y).


%funcion de pertenencia
is_in(X,[X,_]).
is_in(X, [_ | L]) :- is_in(X,L).

%concat
concat([],L,L).
concat([X |L1],L2,[X|L3]):- concat(L1,L2,L3).
