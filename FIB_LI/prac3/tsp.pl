
% Given a directed graph with N nodes, we want to find a Hamiltonian
% cycle: a cycle visiting each node exactly once.

% Moreover, we consider that:
%  -trajects between nodes with the same parity have cost 0 euros
%  -trajects between nodes of different parity  have length 1 euro
% For example, the following solution has cost 10:
%   1 10 4 8 3 20 18 14 12 11 15 2 5 9 17 16 7 13 19 6 1
%    ^      ^ ^           ^     ^ ^      ^  ^       ^ ^
% We want to find a Hamiltomian cicle with cost at most maxCost.

% Complete the following program to compute one such Hamiltonian cycle.

% MANDATORY: Use the SAT variable: visited-i-p meaning "node i is visited in position p"
% More variables might be needed.

%%% input:
maxCost(10).
numNodes(20).
adjacency(1,[10]).
adjacency(2,[7,5,17]).  % Three directed edges from node 2:  2->7, 2->5 and 2->17.
adjacency(3,[6,20,11]).
adjacency(4,[14,15,1,8,5]).
adjacency(5,[16,4,9,10,11]).
adjacency(6,[1,13,17]).
adjacency(7,[16,9,13,11]).
adjacency(8,[7,3,10,6,17]).
adjacency(9,[6,17,11]).
adjacency(10,[7,11,5,6,4]).
adjacency(11,[20,8,15,4,1,16,3]).
adjacency(12,[15,11,3]).
adjacency(13,[5,2,19,3,6]).
adjacency(14,[10,12,9,7]).
adjacency(15,[20,1,14,18,12,2]).
adjacency(16,[7,6,4,8,2,10]).
adjacency(17,[20,5,16,3,8]).
adjacency(18,[15,16,7,14,3]).
adjacency(19,[13,6]).
adjacency(20,[12,6,18,7,16]).
%%% end input


%Helpful prolog predicates:
position(P):- numNodes(N), between(0,N,P).
node(I):-     adjacency(I,_).


:-dynamic(varNumber/3).
symbolicOutput(0). % set to 1 to see symbolic output only; 0 otherwise.

writeClauses:-
    init,
    eachNexactlyOneP,%each node must appear at one position at most
    %not quite sure if this one is necessary,
    %forcing 1  to be last would do the same.
    eachPexactlyOneN,%each position must have only 1 node
    removeWrongAdjacencies,%we declare as false non-adjacencies
    %mustBeAdjacent,
    %gotoadjacent,
    genCostVar, %we use a new variable to express cost
    costMenorMax, % we express cost has to be lower than Max
    true.

init:- numNodes(N),
  writeClause([ visited-1-0 ]),%we start with node 1
  writeClause([ visited-1-N ]),%in the last step we must return to 1
  fail.
init.


eachNexactlyOneP:-
  node(N),% we don't count position 0(we have to end in the same starting node)
  findall(visited-N-P,(position(P), P > 0),Lits),
  exactly(1,Lits),
  fail.
eachNexactlyOneP.

eachPexactlyOneN:-
  position(P),P > 0,
  findall(visited-N-P,node(N),Lits),
  exactly(1,Lits),
  fail.
eachPexactlyOneN.

%remove all wrong adjacencies
removeWrongAdjacencies:-
  node(N1),node(N2),adjacency(N1,L),position(P1),
  not(member(N2,L)),
  P2 is P1+1,
  writeClause([\+visited-N1-P1,\+visited-N2-P2]),
  fail.
removeWrongAdjacencies.

position2(P):- numNodes(N), between(1,N,P).
nadjacents(N,A):- adjacency(N,AL), member(A,AL).

mustBeAdjacent:-
  position(P), member(N,L),
  findall(visited-N1-P, adjacency(N1,L), Lits),
  P1 is P-1,writeClause([\+visited-N-P1|Lits]),
  fail.
mustBeAdjacent.
gotoadjacent:-
  position2(P), node(I),
  findall(visited-N-P, nadjacents(I,N), Lits),
  P1 is P-1,writeClause([\+visited-I-P1|Lits]),
  fail.
gotoadjacent.

genCostVar:-
  position(P1),P2 is P1 +1,adjacency(N1,L),%dado un nodo y su pos
  member(N2,L), %para cada uno de sus caminos genero el coste.
  A is N1 mod 2, B is N2 mod 2, A\=B,%si lo hay
  writeClause([\+visited-N1-P1,\+visited-N2-P2,cost1-P1]),
  %así solo generamos coste si (N1,P1) -> (N2,P2)
  fail.
genCostVar.

costMenorMax:-
  findall(cost1-P,position(P),Lits),
  maxCost(Max),
  atMost(Max,Lits),
  fail.
costMenorMax.


%% Display solution
displaySol(M):- position(P), member(visited-Node-P,M), write(Node), write(' '), fail.
displaySol(_):- nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Everything below is given as a standard library, reusable for solving
%    with SAT many different problems.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Express that Var is equivalent to the disjunction of Lits:
expressOr( Var, Lits ):- member(Lit,Lits), negate(Lit,NLit), writeClause([ NLit, Var ]), fail.
expressOr( Var, Lits ):- negate(Var,NVar), writeClause([ NVar | Lits ]),!.


%%%%%% Cardinality constraints on arbitrary sets of literals Lits:

exactly(K,Lits):- atLeast(K,Lits), atMost(K,Lits),!.

atMost(K,Lits):-   % l1+...+ln <= k:  in all subsets of size k+1, at least one is false:
	negateAll(Lits,NLits),
	K1 is K+1,    subsetOfSize(K1,NLits,Clause), writeClause(Clause),fail.
atMost(_,_).

atLeast(K,Lits):-  % l1+...+ln >= k: in all subsets of size n-k+1, at least one is true:
	length(Lits,N),
	K1 is N-K+1,  subsetOfSize(K1, Lits,Clause), writeClause(Clause),fail.
atLeast(_,_).

negateAll( [], [] ).
negateAll( [Lit|Lits], [NLit|NLits] ):- negate(Lit,NLit), negateAll( Lits, NLits ),!.

negate(\+Lit,  Lit):-!.
negate(  Lit,\+Lit):-!.

subsetOfSize(0,_,[]):-!.
subsetOfSize(N,[X|L],[X|S]):- N1 is N-1, length(L,Leng), Leng>=N1, subsetOfSize(N1,L,S).
subsetOfSize(N,[_|L],   S ):-            length(L,Leng), Leng>=N,  subsetOfSize( N,L,S).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAIN:

main:-  symbolicOutput(1), !, writeClauses, halt.   % print the clauses in symbolic form and halt
main:-  initClauseGeneration,
	tell(clauses), writeClauses, told,          % generate the (numeric) SAT clauses and call the solver
	tell(header),  writeHeader,  told,
	numVars(N), numClauses(C),
	write('Generated '), write(C), write(' clauses over '), write(N), write(' variables. '),nl,
	shell('cat header clauses > infile.cnf',_),
	write('Calling solver....'), nl,
	shell('picosat -v -o model infile.cnf', Result),  % if sat: Result=10; if unsat: Result=20.
	treatResult(Result),!.

treatResult(20):- write('Unsatisfiable'), nl, halt.
treatResult(10):- write('Solution found: '), nl, see(model), symbolicModel(M), seen, displaySol(M), nl,nl,halt.

initClauseGeneration:-  %initialize all info about variables and clauses:
	retractall(numClauses(   _)),
	retractall(numVars(      _)),
	retractall(varNumber(_,_,_)),
	assert(numClauses( 0 )),
	assert(numVars(    0 )),     !.

writeClause([]):- symbolicOutput(1),!, nl.
writeClause([]):- countClause, write(0), nl.
writeClause([Lit|C]):- w(Lit), writeClause(C),!.
w( Lit ):- symbolicOutput(1), write(Lit), write(' '),!.
w(\+Var):- var2num(Var,N), write(-), write(N), write(' '),!.
w(  Var):- var2num(Var,N),           write(N), write(' '),!.


% given the symbolic variable V, find its variable number N in the SAT solver:
var2num(V,N):- hash_term(V,Key), existsOrCreate(V,Key,N),!.
existsOrCreate(V,Key,N):- varNumber(Key,V,N),!.                            % V already existed with num N
existsOrCreate(V,Key,N):- newVarNumber(N), assert(varNumber(Key,V,N)), !.  % otherwise, introduce new N for V

writeHeader:- numVars(N),numClauses(C), write('p cnf '),write(N), write(' '),write(C),nl.

countClause:-     retract( numClauses(N0) ), N is N0+1, assert( numClauses(N) ),!.
newVarNumber(N):- retract( numVars(   N0) ), N is N0+1, assert(    numVars(N) ),!.

% Getting the symbolic model M from the output file:
symbolicModel(M):- get_code(Char), readWord(Char,W), symbolicModel(M1), addIfPositiveInt(W,M1,M),!.
symbolicModel([]).
addIfPositiveInt(W,L,[Var|L]):- W = [C|_], between(48,57,C), number_codes(N,W), N>0, varNumber(_,Var,N),!.
addIfPositiveInt(_,L,L).
readWord( 99,W):- repeat, get_code(Ch), member(Ch,[-1,10]), !, get_code(Ch1), readWord(Ch1,W),!. % skip line starting w/ c
readWord(115,W):- repeat, get_code(Ch), member(Ch,[-1,10]), !, get_code(Ch1), readWord(Ch1,W),!. % skip line starting w/ s
readWord(-1,_):-!, fail. %end of file
readWord(C,[]):- member(C,[10,32]), !. % newline or white space marks end of word
readWord(Char,[Char|W]):- get_code(Char1), readWord(Char1,W), !.
%========================================================================================
