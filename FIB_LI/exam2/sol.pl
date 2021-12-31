
% This was the simple solution we prepared:

noTaskStartsTooLate(AvailableHours):-
    possibleStart(T,AvailableHours,HStart),
    usableMachine(T,M),
    \+machineIsFastEnoughForThisStartTime(T,M,AvailableHours,HStart),
    writeClause([ \+machine-T-M, \+start-T-HStart ]), fail.
noTaskStartsTooLate(_).

relateStartVarsWithActiveVars(AvailableHours):-
    possibleStart(T,AvailableHours,HStart),
    duration(T,M,D),
    machineIsFastEnoughForThisStartTime(T,M,AvailableHours,HStart),   % <---- CRUCIAL LINE!
    ActiveUntilH is HStart+D-1, between(HStart,ActiveUntilH,H),
    writeClause([ \+machine-T-M, \+start-T-HStart, active-T-H ]), fail.
relateStartVarsWithActiveVars(_).


% But many students OMITTED THAT CRUCIAL LINE!
% And then what happens? You generate clauses containing active-T-H with H>AvailableHours.
% For example, if we have task(1, 2,55, [1-6,5-19,6-10]), then, for example,
% noTaskStartsTooLate(70) will generate clauses like:  \+machine-1-5, \+start-1-55             
% relateStartVarsWithActiveVars(70) will generate:     \+machine-1-5, \+start-1-55, active-1-73
% This second clause is not wrong; in fact it is subsumed by the first one.
% BUT: the variable active-1-73 is simply never forced to be true, nor to be false.
% So the SAT solver may return a model where active-1-73 is true, and then
% the predicate hoursUsed will say that this solution takes at least 73 hours, even
% when we have really found a solution below 70!

% Imagine this happened to you during the exam. Then you might have thought:
% " Oh! displaySol shows me a solution of cost 60, but then says it has cost 73!
%   How is this cost 73 computed from the model M?  Ahhh, like this:
%      hoursUsed(M,K):- findall(H,member(active-_-H,M),L), max_list(L,K),!.
%   Ok, let's write the model M. Ahhh, I see! There is a crazy variable active-1-73!  "

% And then you might have fixed relateStartVarsWithActiveVars doing one of:
% A) add that crucial line
% B) add H =< AvailableHours (just before writeClause)
% C) add another Prolog clause relateStartVarsWithActiveVars saying
%                   that beyond AvailableHours nobody is active...
% D) ...
% Since many people got stuck, we helped during the exam by suggesting one of these fixes.
