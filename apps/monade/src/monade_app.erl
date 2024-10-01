-module(monade_app).

-behaviour(application).

-export([start/2, stop/1]).
-export([write_file/3]).

-compile({parse_transform,do}).

start(_StartType, _StartArgs) ->
    monade_sup:start_link().

stop(_State) ->
    ok.

%% internal functions

-type error_m(Result,Reason) :: ok | {ok,Result} | {error,Reason}.

-spec write_file(term(), term(), [atom()]) -> error_m(ok, term()).
write_file(Path, Data, Modes) ->
  Modes1 = [binary, write | (Modes -- [binary, write])],
  do([error_m ||
      Bin <- make_binary(Data),
      Hdl <- file:open(Path, Modes1),
      Result <- do([error_m ||
          ok <- file:write(Hdl, Bin),
          file:sync(Hdl)]),
      file:close(Hdl),
      Result]).

-spec make_binary(atom()|list()|binary()) -> error_m(binary(), term()).
make_binary(Bin) when is_binary(Bin) ->
  do([error_m || return(Bin)]);
make_binary(Atom) when is_atom(Atom) ->
  error_m:return(atom_to_binary(Atom,latin1));
make_binary(List) ->
  try {ok,iolist_to_binary(List)}
  catch error:_ -> {error, {not_iolist,List}}
  end.
