-module(procedural_app).

-behaviour(application).

-export([start/2, stop/1, abs_value/2, success/0, failure/0]).

start(_StartType, _StartArgs) ->
    procedural_sup:start_link().

stop(_State) ->
    ok.

abs_value(negative, X) -> -X;
abs_value(positive, X) -> X.

success() -> ok.
failure() -> error.
