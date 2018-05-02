%%% Title: hw3_1.pl
%%% Author: kevin110604
%%% Function: Goldbach's conjecture
%%% How to run: swipl -q -s hw3_1.pl

% determine whether P is a prime number or not
is_prime(2).
is_prime(3).
is_prime(P) :- 
    integer(P),                                 % P is a int
    P > 3, 
    P mod 2 =\= 0,                              % P isn't even
    \+ odd_factor(P, 3).                        % doesn't have odd factor

% determine whether N has an odd factor L or not
odd_factor(N, L) :- N mod L =:= 0.
odd_factor(N, L) :-
    L * L < N,                                  % only need to check until √N
    L2 is L + 2,                                % next odd number
    odd_factor(N, L2).

% goldbach/2
goldbach(4,[2,2]).
goldbach(N, L) :- 
    N mod 2 =:= 0,                              % N is even
    N > 4, 
    goldbach(N, L, 3).                          % start from 3 to search

% goldbach/3
goldbach(N, [P1, P2], P1) :- 
    P2 is N - P1,                               % N=P1+P2
    is_prime(P2).                               % check if P2 is a prime
goldbach(N, L, P1) :- 
    P1 < N, 
    next_prime(P1, PP),                         % search the next prime PP
    goldbach(N, L, PP).                         % use PP as the new P1

% search for the next prime
next_prime(P, PP) :- PP is P + 2, is_prime(PP).
next_prime(P, PP) :- P_new is P + 2, next_prime(P_new, PP).

% get_ans
get_ans(X) :-
    goldbach(X, [P1, P2]),
    write(P1), put(' '), writeln(P2).

% main
:-
    readln(X),
    get_ans(X).

