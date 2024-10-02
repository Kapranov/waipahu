%%%-------------------------------------------------------------------
%% @doc lahaina public API
%% @end
%%%-------------------------------------------------------------------

-module(lahaina_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    lahaina_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
