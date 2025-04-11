%this will have the module for the factorial calculator
-module(factorial_calculator).
% -export([factorial/1]).


% factorial(Name) ->
%   io:format("Hello, ~s!~n", [Name]).


-export([feel/1]).

feel(T) when T < 0 -> io:format("Freezing ~n");
feel(T) when 0 =< T, T =< 20  -> io:format("Cold ~n");
feel(T) when 21 =< T, T =< 30  -> io:format("Warm ~n");
feel(T) when 30 < T -> io:format("Hot ~n").





