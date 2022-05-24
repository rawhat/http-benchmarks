-module(hello_handler).

-behaviour(cowboy_handler).

-export([init/2]).

init(Req, State) ->
  Res =
    cowboy_req:reply(200,
                     #{<<"content-type">> => <<"text/plain">>},
                     <<>>,
                     Req),
  {ok, Res, State}.
