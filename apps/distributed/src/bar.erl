-module(bar).
-export([start/0]).

start() ->
  {foo_handler, 'foo@localhost.example'} ! {self(), hello},
  io:format(""),
  receive
    {goodbye} ->
      io:format("[bar] Received `goodbye`, terminating...~n"),
      self() ! stop
  end.
