defmodule Web.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> put_resp_header("content-type", "text/html; charset")
    |> send_file(200, "lib/web/public/elixir.html")

    send_resp(conn, 200, "I <3 Elixir! ")
  end

  match _ do
    send_resp(conn, 404, "The page you are looking for could not be found")
  end
end
