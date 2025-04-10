%this will have the module for the factorial calculator
-module(factorial_calculator).
% -export([factorial/1]).


% factorial(Name) ->
%   io:format("Hello, ~s!~n", [Name]).


% -export([feel/1]).

% feel(T) when T < 0 -> io:format("Freezing ~n");
% feel(T) when 0 =< T, T =< 20  -> io:format("Cold ~n");
% feel(T) when 21 =< T, T =< 30  -> io:format("Warm ~n");
% feel(T) when 30 < T -> io:format("Hot ~n").

% Recursion of a countdown 

% -export([countdown/1]).

% countdown(0) -> io:format("blast off!~n");
% countdown(N) when N > 0 ->
%     io:format("~p~n",[N]),
%     countdown(N-1).


% sum of numbers from 1 to N recursively
% -export([sum/1]).

% sum(0) -> 0;
% sum(N) when N > 0 -> N + sum(N-1).

-export([length/1]).

length([]) -> 0;
length([_Head | Tail]) -> 1 + length(Tail).

