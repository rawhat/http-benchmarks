%%%-------------------------------------------------------------------
%% @doc glowboy public API
%% @end
%%%-------------------------------------------------------------------

-module(glowboy_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    glowboy_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
