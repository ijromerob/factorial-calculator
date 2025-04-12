%this will have the module for the factorial calculator
-module(factorial_calculator).

% The export shows the functions that can be accessed outside of the module
% the number after the "/" is the number of arguments (arity)
-export([start_factorial/0,start_list/0, factorial_loop/0, createList_loop/1]).

% This function starts creating a new process
start_factorial()->
  % The new process will use the current module with function loop and zero arguments
  spawn(?MODULE,factorial_loop,[]).

start_list()->
  spawn(?MODULE, createList_loop,[[]]).


factorial_loop() ->

  receive

    {factorial, From, NumberList} ->
      % Lambda function to check numbers if they are negative
      NonNegative = fun(X) -> X>=0 end,
      % sorts list to a list of only positives
      Positives = lists:filter(NonNegative,NumberList),



      Result = lists:map(fun (X) -> fact(X) end,Positives),
      From ! {result, Result},

      factorial_loop();


    stop ->
      io:format("stopping the process ~n"),
      ok;


    _ ->
      io:format("This is embarrassing I don't understand what you said! :/ ~n"),
      factorial_loop()
  end.

createList_loop(CurrentList) ->
  receive
    {newNumber, N } when is_number(N) ->
      NewList = [N | CurrentList],
      createList_loop(NewList);
    {calculate, From, To} ->
      To !{factorial, From , CurrentList},
      NewList = [],
      createList_loop(NewList);

    stop ->
      io:format("stopping the process ~n"),
      ok;

    _ ->
      io:format("sorry I didn't get that ~n"),
      createList_loop(CurrentList)
  end.



% this checks for the factorial cases
% base case in recursion
fact(0)-> 1;
% recursive guard when N is positive using recursion
fact(N) when N > 0 -> N * fact(N - 1).


