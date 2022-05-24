-module(user_handler).

-behaviour(cowboy_handler).

-export([init/2]).

init(Req, State) ->
  case cowboy_req:method(Req) of
    <<"GET">> -> handle_get(Req, State);
    <<"POST">> -> handle_post(Req, State)
  end.

handle_get(Req, State) ->
  Id = cowboy_req:binding(id, Req),
  Res = cowboy_req:reply(200,
                     #{<<"content-type">> => <<"text/plain">>},
                     Id,
                     Req),
  {ok, Res, State}.

handle_post(Req, State) ->
  {ok, Data} = cowboy_req:read_body(Req),
  Res =
    cowboy_req:reply(200,
                     #{<<"content-type">> => <<"text/plain">>},
                     Data,
                     Req),
  {ok, Res, State}.
