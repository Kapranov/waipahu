%%%-------------------------------------------------------------------
%% @doc waipahu public API
%% @end
%%%-------------------------------------------------------------------

-module(waipahu_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    waipahu_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
