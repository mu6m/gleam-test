import gleam/bit_array
import gleam/bytes_builder
import gleam/http.{Get, Post}
import gleam/http/request
import gleam/http/response
import gleam/http/service
import gleam/result
import gleam/string
import reply/web/logger

fn not_found() {
  let body =
    "not found"
    |> bit_array.from_string

  response.new(404)
  |> response.set_body(body)
  |> response.prepend_header("content-type", "text/plain")
}

fn test() {

  response.new(200)
  |> response.set_body(bit_array.from_string("pong"))
  |> response.prepend_header("content-type", "text/plain")
}

pub fn service(request) {
  let path = request.path_segments(request)

  case request.method, path {
    Get, ["ping"] -> test(name)
    _, _ -> not_found()
  }
}

pub fn stack() {
  service
  |> service.prepend_response_header("made-with", "Gleam")
  |> service.map_response_body(bytes_builder.from_bit_array)
  |> logger.middleware
}
