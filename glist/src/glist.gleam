import gleam/bytes_builder
import gleam/erlang/process
import gleam/http
import gleam/http/request.{type Request}
import gleam/http/response
import gleam/result
import mist

pub fn main() {
  let empty_bytes = mist.Bytes(bytes_builder.new())
  let empty_response =
    response.new(200)
    |> response.set_body(empty_bytes)

  let not_found =
    response.new(404)
    |> response.set_body(empty_bytes)

  let too_large =
    response.new(413)
    |> response.set_body(empty_bytes)

  let assert Ok(subj) =
    fn(req: Request(BitArray)) {
      case req.method, request.path_segments(req) {
        http.Get, [] -> empty_response
        http.Get, ["user", id] ->
          response.new(200)
          |> response.set_body(
            mist.Bytes(bytes_builder.from_bit_array(<<id:utf8>>)),
          )
        http.Post, ["user"] -> {
          let content_type =
            req
            |> request.get_header("content-type")
            |> result.unwrap("application/octet-stream")
          response.new(200)
          |> response.set_body(
            mist.Bytes(bytes_builder.from_bit_array(req.body)),
          )
          |> response.prepend_header("content-type", content_type)
        }
        _, _ -> not_found
      }
    }
    |> mist.new
    |> mist.read_request_body(40_000_000, too_large)
    |> mist.port(8080)
    |> mist.start_http

  process.sleep_forever()
}
