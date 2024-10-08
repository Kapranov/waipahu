-module(pokemon_app).

-behaviour(application).

-export([start/2, stop/1, pikachu/0, raichu/0, run/0]).

start(_StartType, _StartArgs) ->
    pokemon_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
pikachu() ->
  receive
    {talk} -> io:format("Pikachu! Pika, pika!~n"), pikachu();
    {thunder_stone} -> io:format("Pikachu is evolving to Raichu!~n"), raichu();
    {Other} -> io:format("Pikachu is very sorry but it doesn't quite know what to do with ~w.~n", [Other]), pikachu()
  end.

raichu() ->
  receive
    {talk} -> io:format("Rai!~n");
    {thunder_stone} -> io:format("Thunder stone has no effect on Raichu.~n");
    {Other} -> io:format("Raichu stares at ~w with a puzzled smile.~n", [Other])
  end,
  raichu().

run() ->
  Poke = spawn_link(pokemon_app, pikachu, []),
  Poke ! {talk},
  Poke ! {fire_stone},
  Poke ! {thunder_stone},
  Poke ! {talk},
  Poke ! {fire_stone},
  Poke ! {thunder_stone},
  Poke ! {talk}.
