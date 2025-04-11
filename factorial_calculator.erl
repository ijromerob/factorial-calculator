%this will have the module for the factorial calculator
-module(factorial_calculator).

% normal factorial 

% -export([fact/1]).

% fact(0)-> 1;
% fact(N) when N > 0 -> N * fact(N - 1);
% fact(N) when N < 0 -> io:format("This is not allowed ~n").

-export([start/0]).

start() ->
    receive
        hello ->
            io:format("Hello received ~n");
        goodbye ->
            io:format("Goodbye received ! ~n");
        _ ->
            io:format("Unknown message ~n")
    end.