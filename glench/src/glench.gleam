import gleam/erlang
import gleam/http
import gleam/http/request.{Request}
import gleam/http/response
import gleam/otp/actor
import gleam/otp/process
import glisten
import glisten/tcp
import mist/http as mhttp
import mist

pub external fn observer_start() -> Nil =
  "observer" "start"

pub fn main() {
  let empty_response =
    response.new(200)
    |> response.set_body(<<>>)
    |> mhttp.to_bit_builder

  let not_found =
    response.new(404)
    |> response.set_body(<<>>)

  // assert Ok(_) =
  //   mist.serve(
  //     8080,
  //     mhttp.handler(fn(req: Request(BitString)) {
  //       case req.method, request.path_segments(req) {
  //         http.Get, [] -> empty_response
  //         http.Get, ["user", id] ->
  //           response.new(200)
  //           |> response.set_body(<<id:utf8>>)
  //         http.Post, ["user"] -> empty_response
  //         _, _ -> not_found
  //       }
  //     }),
  //   )

  assert Ok(_) = glisten.serve(
    8080,
    tcp.handler(fn(_msg, ws_state) {
      let #(socket, _state) = ws_state
      assert Ok(_) = tcp.send(socket, empty_response)
      actor.Stop(process.Normal)
    }),
    Nil
  )

  // observer_start()
  erlang.sleep_forever()
}
