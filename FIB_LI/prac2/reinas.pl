/*3. Haz un programa prolog que escriba la manera de colocar sobre un tablero de
   ajedrez ocho reinas sin que Ã©stas se ataquen entre sÃ­.
   Por ejemplo, Ã©sta serÃ­a una solucion:

      . . x . . . . .
      . . . . . x . .
      . . . x . . . .
      . x . . . . . .
      . . . . . . . x
      . . . . x . . .
      . . . . . . x .
      x . . . . . . .*/

reinas:-
  permutation([1,2,3,4,5,6,7,8],Matrix),
  diagonales(Matrix),
  printReinas(Matrix).

diagonales([]).
diagonales([R1|Matrix]):- noAmenazada(R1,Matrix,1),diagonales(Matrix).

noAmenazada(_,[],_).
noAmenazada(R,[RNext|Matrix],D):-
  R-RNext =\= D,%abajo a la izquierda
  RNext -R =\= D,%abajo a la derecha
  Dnew is D +1,
  noAmenazada(R,Matrix,Dnew).

printReinas([]).
printReinas([R1|Rest]):- printRow(R1), nl, printReinas(Rest).

printRow(R1):-leftDotsPrint(R1), write('X'),rightDotsPrint(R1).

leftDotsPrint(1):-!.
leftDotsPrint(N):- N1 is N-1,write('.'),leftDotsPrint(N1).

rightDotsPrint(8):-!.
rightDotsPrint(N):- N1 is N+1,write('.'),rightDotsPrint(N1).
