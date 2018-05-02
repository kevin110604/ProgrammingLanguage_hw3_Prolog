%%% Title: hw3_2.pl
%%% Author: kevin110604
%%% Function: Lowest Common Ancestor (LCA)
%%% How to run: swipl -q -s hw3_2.pl

% define ancestor rule
ancestor(A, B) :- parent(A, B).         % if A is B's parent then A is B's ancestor
ancestor(A, B) :- parent(X, B), ancestor(A, X).     % if X is B's parent and A is X's ancestor then A is B's ancesor

% print a given list
print_list([]).
print_list([X| T]) :-
    write(X),                           % write X to the current output
    nl,                                 % write a newline to the current output
    print_list(T).                      % print the tail

% append one element X behind the list
append_X([], X, [X]).
append_X([H| L1], X, [H| L2]) :- append_X(L1, X, L2).

% get A&B's LCA R
lca(A, B, R) :- 
    A==B -> R=A;
    ancestor(A, B) -> R=A;
    parent(X, A),lca(X, B, R).

% construct tree
con_tree(N, P) :-
	N > 0,
	readln(P),
	nth0(0, P, A), nth0(1, P, B),       % True when Elem is the Index'th element of List
	assert(parent(A, B)),               % Assert a clause (fact or rule) into the database.
	NN is N - 1,                        % if (N==0) break;
	con_tree(NN, _P);                   % else      con_tree(N-1, _P);
	N = 0.

% search tree
srh_tree(T, P, L1, L2) :-
	T > 0,
	readln(P),
	nth0(0, P, A), nth0(1, P, B),       % True when Elem is the Index'th element of List
	lca(A, B, R),                       % find LCA
	append_X(L1, R, L2),
	TT is T - 1,                        % if (T==0)
	srh_tree(TT, _A, L2, _L3);          %       print_list(L1)
	T = 0,                              % else
	print_list(L1).                     %       srh_tree(T0, _A, S2, _L3)

% main
:-
    readln(N),                          % N nodes (Read a sentence up till NewLine)
	member(X, N),
	con_tree(X-1, _P),
	readln(T),                          % numbers of queries
	member(Y, T),
	srh_tree(Y, _A, _L1, _L2).
