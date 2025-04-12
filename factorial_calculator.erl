%this will have the module for the factorial calculator
-module(factorial_calculator).

% The export shows the functions that can be accessed outside of the module
% the number after the "/" is the number of arguments (arity)
-export([start/0, loop/0]).

% This function starts creating a new process
start()->
  % The new process will use the current module with function loop and zero arguments
  spawn(?MODULE,loop,[]).

% This function creates a loop with recursion
loop() ->
  % the receiver checks for specific inputs
  receive
    % checks for the message structure
    % factorial tag and sends the process that called the function
    % positive numbers
    {factorial, From, N} when N >= 0 ->
      % the Result is sent back the process (shell)
      Result = fact(N),
      From ! {result, N, Result},
      % calls itself again
      loop();

    %checks for negative numbers
    {factorial, _, N} when N< 0 ->
      io:format("Impossible to compute, it is a negative number: ~p~n", [N]),
      loop();

    % stops the process
    stop ->
      io:format("stopping the process ~n"),
      ok;

    % checks for any other format message sent
    _ ->
      io:format("This is embarrassing I don't understand what you said! :/ ~n"),
      loop()
  end.

% this checks for the factorial cases
% base case in recursion
fact(0)-> 1;
% recursive guard when N is positive using recursion
fact(N) when N > 0 -> N * fact(N - 1);
% guard whenever there is a negative number
fact(N) when N < 0 -> io:format("This is not allowed ~n").