%this will have the module for the factorial calculator
-module(factorial_calculator).

% The export shows the functions that can be accessed outside of the module
% the number after the "/" is the number of arguments (arity)
-export([start_factorial/0,start_list/0, factorial_loop/0, createList_loop/1, menu/2]).

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


menu(ListPid, FactorialPid) ->
  % Start of the menu with options
  io:format("~n -------------------Factorial Calculator Menu------------------- ~n"),
  io:format("1. Add number to list~n"),
  io:format("2. Calculate factorials~n"),
  io:format("3. Exit~n"),
  io:format("Choose an option: "),
    % Reads the lines and matches it with the options that are provided
    case io:get_line("") of
        "1\n" ->
            io:format("Enter a number: "),
            case io:get_line("") of
                Line ->
                    % First it tries to to convert to a float
                    case string:to_float(string:trim(Line)) of
                        {error, _} ->
                            % if returns an error, it tries to return an integer
                            case string:to_integer(string:trim(Line)) of
                                {Int, _} ->
                                    % it is sent to the ListPid the new number
                                    ListPid ! {newNumber, Int},
                                    io:format("Added ~p to the list.~n", [Int]);
                                % if it is unsuccessful, it is deemed as an invalid input
                                _ ->
                                    io:format("Invalid input!~n")
                            end;
                        {Float, _} ->
                            % it is sent to the ListPid the new number
                            ListPid ! {newNumber, Float},
                            io:format("Added ~p to the list.~n", [Float])
                    end,
                    % Continue with recursion
                    menu(ListPid, FactorialPid)
            end;

        "2\n" ->
            % Send the calculate instruction with the list
            ListPid ! {calculate, self(), FactorialPid},
            receive
              % if there is a response, it will be displayed
                {result, ResultList} ->
                    io:format("Factorials: ~p~n", [ResultList])
            end,
            % continue with recursion
            menu(ListPid, FactorialPid);

        % stops the program
        "3\n" ->
            % stops the processes
            ListPid ! stop,
            FactorialPid ! stop,
            io:format("Goodbye!~n"),
            ok;

        _ ->
            io:format("Invalid option!~n"),
            menu(ListPid, FactorialPid)
    end.
