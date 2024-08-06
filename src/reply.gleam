import gleam/erlang/os
import gleam/erlang/process
import gleam/http/elli
import gleam/int
import gleam/io
import gleam/result
import gleam/string
import reply/web

pub fn main() {
  let port =
    os.get_env("PORT")
    |> result.then(int.parse)
    |> result.unwrap(3000)

  // Start the web server process
  let assert Ok(_) =
    web.stack()
    |> elli.start(on_port: port)

  ["Started listening on localhost:", int.to_string(port), " ✨"]
  |> string.concat
  |> io.println

  // Put the main process to sleep while the web server does its thing
  process.sleep_forever()
}
