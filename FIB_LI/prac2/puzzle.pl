


/*2. Tenemos una fila de cinco casas, con cinco vecinos con casas de
colores diferentes, y cinco profesiones, animales, bebidas y
nacionalidades diferentes, y sabiendo que:

    1 - El que vive en la casa roja es de Peru
    2 - Al frances le gusta el perro
    3 - El pintor es japones
    4 - Al chino le gusta el ron
    5 - El hungaro vive en la primera casa
    6 - Al de la casa verde le gusta el coÃ±ac
    7 - La casa verde esta a la izquierda de la blanca
    8 - El escultor crÃ­a caracoles
    9 - El de la casa amarilla es actor
   10 - El de la tercera casa bebe cava
   11 - El que vive al lado del actor tiene un caballo
   12 - El hungaro vive al lado de la casa azul
   13 - Al notario la gusta el whisky
   14 - El que vive al lado del medico tiene un ardilla,

Escribe un programa Prolog que averigue para cada persona todas sus
caracteristicas de la forma [num_casa,color,profesion,animal,bebida,pais]
averiguables. No todas las caracterÃ­sticas se pueden averiguar.
*/

left(R1, R2):- R2 is R1 + 1.
right(R1, R2):- R2 is R1 - 1.

near(R1, R2):- left(R1, R2).
near(R1, R2):- right(R1, R2).

%[num_casa,color,profesion,animal,bebida,pais]
casas:-	Sol = [	[1,A1,B1,C1,D1,E1],
		[2,A2,B2,C2,D2,E2],
		[3,A3,B3,C3,D3,E3],
		[4,A4,B4,C4,D4,E4],
		[5,A5,B5,C5,D5,E5] ],
        member([_,roja,_,_,_,peru] , Sol),
        member([_,_,_,perro,_,francia] , Sol),
        member([_,_,pintor,_,_,japon] , Sol),
        member([_,_,_,_,ron,china] , Sol),
        member([1,_,_,_,_,hungaria] , Sol),
        member([_,verde,_,_,cognac,_] , Sol),
        member([F, verde, _, _, _, _], Sol),
        member([F2, blanca, _, _, _, _], Sol),
        left(F,F2),
        member([_,_,escultor,caracoles,_,_] , Sol),
        member([_,amarilla,actor,_,_,_] , Sol),
        member([3,_,_,_,cava,_] , Sol),
        member([G,_,actor,_,_,_] , Sol),
        member([G2,_,_,caballo,_,_] , Sol),
        near(G,G2),
        member([H,azul,_,_,_,_] , Sol),
        member([H2,_,_,_,_,hungaria] , Sol),
        near(H,H2),
        member([_,_,notario,_,whisky,_] , Sol),
        member([I,_,medico,_,_,_] , Sol),
        member([I2,_,_,ardilla,_,_] , Sol),
        near(I,I2),
	write(Sol), nl.









%SPOILER SOLUCIO
/*
vecinoIzq(R1, R2):- R2 is R1 + 1.
vecinoDer(R1, R2):- R2 is R1 - 1.

vecino(R1, R2):- vecinoIzq(R1, R2).
vecino(R1, R2):- vecinoDer(R1, R2).

casas:- Sol = [[1, _, _, _, _, _],
               [2, _, _, _, _, _],
               [3, _, _, _, _, _],
               [4, _, _, _, _, _],
               [5, _, _, _, _, _]],
               member([_, roja, _, _, _, peru], Sol),
               member([_, _, _, perro, _, francia], Sol),
               member([_, _, pintor, _, _, japon], Sol),
               member([_, _, _, _, ron, china], Sol),
               member([1, _, _, _, _, hongria], Sol),
               member([_, verde, _, _, coñac, _], Sol),
               member([R1, verde, _, _, _, _], Sol),
               member([R2, blanca, _, _, _, _], Sol),
               vecinoIzq(R1, R2),
               member([_, _, escultor, caracoles, _, _], Sol),
               member([_, amarilla, actor, _, _, _], Sol),
               member([3, _, _, _, cava, _], Sol),
               member([R4, _, _, caballo, _, _], Sol),
               member([R5, _, actor, _, _, _], Sol),
               vecino(R4, R5),
               member([R6, _, _, _, _, hongria], Sol),
               member([R7, azul, _, _, _, _], Sol),
               vecino(R6, R7),
               member([_, _, notario, _, whisky, _], Sol),
               member([R8, _, _, ardilla, _, _], Sol),
               member([R9, _, medico, _, _, _], Sol),
               vecino(R8, R9),
               write(Sol), nl.
*/
