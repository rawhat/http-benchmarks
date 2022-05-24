%%%-------------------------------------------------------------------
%% @doc glowboy public API
%% @end
%%%-------------------------------------------------------------------

-module(glowboy_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
  Dispatch =
    cowboy_router:compile([{<<"localhost">>,
                            [{<<"/">>, hello_handler, []},
                             {<<"/user/[:id]">>, user_handler, []}]}]),
  {ok, _} =
    cowboy:start_clear(glowboy_listener, [{port, 8080}], #{env => #{dispatch => Dispatch}}),
  glowboy_sup:start_link().

stop(_State) ->
  ok.

%% internal functions
