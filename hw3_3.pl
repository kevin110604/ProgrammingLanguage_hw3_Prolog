%%% Title: hw3_3.pl
%%% Author: kevin110604
%%% Function: Reachable: determine if node A and node B are connected
%%% How to run: swipl -q -s hw3_3.pl

% has a edge
has_edge(A, B) :- edge(A, B); edge(B, A).

% print a given list
print_list([]).
print_list([X| T]) :-
    writeln(X),                           % write X to the current output        % write a newline to the current output
    print_list(T).                      % print the tail

% append one element X behind the list
append_X([], X, [X]).
append_X([H| L1], X, [H| L2]) :- append_X(L1, X, L2).      

% determine whether A&B is connected or not
is_connect(A, B, Result, _T, _NA) :- has_edge(A, B) -> Result = 'Yes'.
is_connect(A, B, Result, T, NA) :-
	T =\= 0, 
	TT is T - 1,
	has_edge(X, B),
	is_connect(A, X, Result, TT, NA).
is_connect(_A, _B, Result, _T, _NA) :- Result='No'.

% construct the graph
con_graph(N, P) :-
	N > 0,
	readln(P),							% readline, P=[PA, PB]
	nth0(0, P, PA), 
	nth0(1, P, PB),
	assert(edge(PA, PB)),				% Assert a clause (fact or rule) into the database.
	%assert(has_edge(PB, PA)),
	NN is N - 1,						% if (N==0) break;
	con_graph(NN, _P);					% else N--; con_graph(N, _P);
	N =:= 0.

% search the graph
srh_graph(Query_num, NA, P, L1, L2) :-
	Query_num > 0,
	readln(P),							% readline, P=[PA, PB]
	nth0(0, P, PA),
	nth0(1, P, PB),
	NAtmp is NA * 10000,
	is_connect(PA, PB, Result, NAtmp, NA),
	append_X(L1, Result, L2),
	QQ is Query_num - 1,				% if (Query_num==0)
	srh_graph(QQ, NA, _A, L2, _L3);		% 		print_list(L1); break;
	Query_num =:= 0, 					% else
	print_list(L1).						%		Query_num--; srh_graph(Query_num, L, _A, L2, _L3);

% main
:-
	readln(N),							% readline, N=[NA, NB]
	nth0(0, N, NA),						% nth0(?Index, ?List, ?Elem)
	nth0(1, N, NB),						% True when Elem is the Index'th element of List.
	con_graph(NB, _P),					% NB: # of edges
	readln(X),							% readline, X=NC
	member(NC, X),						% member(?Elem, ?List), True if Elem is a member of List.
	srh_graph(NC, NA, _NB, _S1, _S2).	% NA: # of nodes, NC: # of queries