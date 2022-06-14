import gleam/bit_builder
import gleam/erlang
import gleam/http
import gleam/http/request.{Request}
import gleam/http/response
import gleam/result
import mist

pub fn main() {
  let empty_response =
    response.new(200)
    |> response.set_body(bit_builder.new())

  let not_found =
    response.new(404)
    |> response.set_body(bit_builder.new())

  assert Ok(_) =
    mist.run_service(
      8080,
      fn(req: Request(BitString)) {
        case req.method, request.path_segments(req) {
          http.Get, [] -> empty_response
          http.Get, ["user", id] ->
            response.new(200)
            |> response.set_body(bit_builder.from_bit_string(<<id:utf8>>))
          http.Post, ["user"] -> {
            let content_type =
              req
              |> request.get_header("content-type")
              |> result.unwrap("application/octet-stream")
            response.new(200)
            |> response.set_body(bit_builder.from_bit_string(req.body))
            |> response.prepend_header("content-type", content_type)
          }
          _, _ -> not_found
        }
      },
    )
  erlang.sleep_forever()
}
