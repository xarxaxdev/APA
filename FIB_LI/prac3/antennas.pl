
% The Swiss Telephone Company (STC) needs to place new 5G antenna
% stations to cover ALL cities of Switzerland.  STC has a long list of
% possible antenna stations. Each city has a (non-empty) list of
% locations covering it. Moreover, there a list of important cities that
% must be covered by at least two stations. Overall, we can use at most
% **maxStations** antenna stations.

% Complete the following program to compute which antenna stations
% should be chosen.

%MANDATORY: Use the SAT variable: used-S meaning "antenna station S is used"

maxStations(8).
numStations(20).
city(1,[12,8,1,5,6,9]).
city(2,[6,14,17,10,2]).
city(3,[12,8,2]).
city(4,[5,20,16]).
city(5,[19,11,12,2,1]).
city(6,[16,10,3,5,13]).
city(7,[5,13,19]).
city(8,[17,14,15,8,5]).
city(9,[13,14,6,11,19]).
city(10,[5,10,19]).
city(11,[1,5,8]).
city(12,[12,20,18,7]).
city(13,[7,3,16]).
city(14,[15,3,10,17]).
city(15,[8,3,1]).
city(16,[18,1,7]).
city(17,[10,5,19]).
city(18,[7,19,8,1,4]).
city(19,[17,9,20,7,13]).
city(20,[14,10,19]).
city(21,[6,5,3,15,19,20]).
city(22,[16,20,15,17]).
city(23,[17,6,20]).
city(24,[17,16,8,13,12,19]).
city(25,[8,11,5,2,6]).
city(26,[12,8,19]).
city(27,[19,17,20,18,14]).
city(28,[14,5,9,11,18,20]).
city(29,[7,1,11,12]).
city(30,[5,6,14,11]).
city(31,[10,2,6,9,15,13,20]).
city(32,[19,7,11,16,12]).
city(33,[11,6,9,17]).
city(34,[4,19,5,3,1,17,12]).
city(35,[18,14,12,3,16,1]).
city(36,[14,19,4]).
city(37,[7,2,14,4]).
city(38,[4,7,5,3,14]).
city(39,[18,4,16,15]).
city(40,[10,8,9]).
city(41,[6,13,1,4]).
city(42,[11,19,2]).
city(43,[1,2,17,12,16]).
city(44,[13,4,5,8,1]).
city(45,[17,20,15,3,14,4]).
city(46,[18,10,2,16]).
city(47,[1,11,16,2,20]).
city(48,[6,1,16]).
city(49,[9,5,19,11]).
city(50,[10,19,4,6]).
importantCities([1,5,10,20]).
% end input

:-dynamic(varNumber/3).
symbolicOutput(0). % set to 1 to see symbolic output only; 0 otherwise.

%%%%%% Some helpful definitions to make the code cleaner:
station(S):- numStations(M), between(1,M,S).

writeClauses:-
    minStationReq,
    minImportantStationReq,
    maxStationsLimit,
    true.


minStationReq:-
  city(_,Ants),
  findall(used-S,member(S,Ants),Lits),
  atLeast(1,Lits),
  fail.
minStationReq.

minImportantStationReq:-
  city(C,Ants),importantCities(Imps),
  member(C,Imps),
  findall(used-S,member(S,Ants),Lits),
  atLeast(2,Lits),
  fail.
minImportantStationReq.


maxStationsLimit:-
  maxStations(M),
  findall(used-S,station(S), Lits),
  atMost(M,Lits),
  fail.
maxStationsLimit.

%% Display solution
displaySol(M):- findall( S, member(used-S,M), L), sort(L,L1), length(L1,K),
		nl, write(K), write(' antenna stations: '),
		member(S,L1), write(S), write(' '), fail.
displaySol(_).



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
