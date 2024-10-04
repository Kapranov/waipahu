-module(foo).
-export([start/0]).

start() ->
  register(foo_handler, self()),
  io:format("[foo] Registered with the name `foo_handler` on node ~w~n", [node()]),
  receive
    {Sender, hello} ->
      io:format("[foo] Received `hello`, will terminate after replying `goodbye`~n"),
      Sender ! {goodbye},
      self() ! stop
  end.
