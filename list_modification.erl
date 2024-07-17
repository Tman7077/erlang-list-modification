-module(list_modification).
-export([start/0]).

% Start the interactive console program
start() ->
    List = load_list(),
    io:format("Welcome to the List Manager!~n"),
    loop(List, []).

% Main loop to handle user input
loop(List, History) ->
    io:format("Current list: ~p~n", [List]),
    io:format("Choose an action: add, remove, display, search, sort, undo, save, quit, help~n"),
    Action = string:trim(io:get_line("> ")),
    case Action of
        "add" ->
            io:format("Enter an element to add:~n"),
            Element = string:trim(io:get_line("> ")),
            NewList = List ++ [Element],  % Append element to the end of the list
            loop(NewList, [List | History]);
        "remove" ->
            io:format("Enter an element to remove:~n"),
            Element = string:trim(io:get_line("> ")),
            NewList = lists:delete(Element, List),
            loop(NewList, [List | History]);
        "display" ->
            io:format("List: ~p~n", [List]),
            loop(List, History);
        "search" ->
            io:format("Enter an element to search:~n"),
            Element = string:trim(io:get_line("> ")),
            search_element(Element, List),
            loop(List, History);
        "sort" ->
            NewList = lists:sort(List),
            loop(NewList, [List | History]);
        "undo" ->
            case History of
                [Previous | Rest] ->
                    io:format("Undo successful.~n"),
                    loop(Previous, Rest);
                [] ->
                    io:format("No actions to undo.~n"),
                    loop(List, History)
            end;
        "save" ->
            save_list(List),
            io:format("List saved successfully.~n"),
            loop(List, History);
        "quit" ->
            io:format("Goodbye!~n"),
            ok;
        "help" ->
            display_help(),
            loop(List, History);
        _ ->
            io:format("Invalid action, please try again.~n"),
            loop(List, History)
    end.

% Function to search for an element in the list
search_element(Element, List) ->
    Index = find_index(Element, List, 1),
    case Index of
        0 -> io:format("Element ~p not found in the list.~n", [Element]);
        _ -> io:format("Element ~p found at index ~p.~n", [Element, Index])
    end.

% Function to find the index of an element in the list
find_index(_, [], _) -> 0;
find_index(Element, [Element | _], Index) -> Index;
find_index(Element, [_ | Tail], Index) -> find_index(Element, Tail, Index + 1).

% Function to display help
display_help() ->
    io:format("Available actions:~n"),
    io:format("add - Add an element to the list~n"),
    io:format("remove - Remove an element from the list~n"),
    io:format("display - Display the current list~n"),
    io:format("search - Search for an element in the list~n"),
    io:format("sort - Sort the list~n"),
    io:format("undo - Undo the last action~n"),
    io:format("save - Save the list to a file~n"),
    io:format("quit - Quit the program~n"),
    io:format("help - Display this help message~n").

% Function to save the list to a file
save_list(List) ->
    {ok, File} = file:open("list.txt", [write]),
    io:format(File, "~p.", [List]),
    file:close(File).

% Function to load the list from a file
load_list() ->
    io:format("Loading list from file...~n"),
    case file:read_file("list.txt") of
        {ok, Data} ->
            io:format("File read successfully.~n"),
            StringData = binary_to_list(Data),
            case erl_scan:string(StringData) of
                {ok, Tokens, _} ->
                    io:format("File scanned successfully.~n"),
                    case erl_parse:parse_term(Tokens) of
                        {ok, List} when is_list(List) ->
                            io:format("File parsed successfully. Loaded list: ~p~n", [List]),
                            List;
                        _ ->
                            io:format("Error: Invalid format in list.txt. Starting with an empty list.~n"),
                            []
                    end;
                _ ->
                    io:format("Error: Failed to scan list.txt. Starting with an empty list.~n"),
                    []
            end;
        {error, Reason} ->
            io:format("Error: Failed to read list.txt. Reason: ~p. Starting with an empty list.~n", [Reason]),
            []
    end.