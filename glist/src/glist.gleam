import gleam/erlang
import gleam/http
import gleam/http/request.{Request}
import gleam/http/response
import mist/http as mhttp
import mist

pub fn main() {
  let empty_response =
    response.new(200)
    |> response.set_body(<<>>)

  let not_found =
    response.new(404)
    |> response.set_body(<<>>)

  assert Ok(_) =
    mist.serve(
      8080,
      mhttp.handler(fn(req: Request(BitString)) {
        // io.debug(req)
        case req.method, request.path_segments(req) {
          http.Get, [] -> empty_response
          http.Get, ["user", id] ->
            response.new(200)
            |> response.set_body(<<id:utf8>>)
          http.Post, ["user"] ->
            response.new(200)
            |> response.set_body(req.body)
          _, _ -> not_found
        }
      }),
    )
  erlang.sleep_forever()
}
