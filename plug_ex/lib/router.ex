defmodule PlugEx.Router do
  use Plug.Router

  plug :match
  plug :dispatch
  plug Plug.Static, at: "/home", from: :server

  get "/" do
    send_resp(conn, 200, "Hello!!")
  end

  get "/about/:username" do
    conn |>
    send_resp(200, "Hello, #{username}")
  end

  get "/home" do
    conn |>
    put_resp_header("content-type", "text/html; charset=utf-8") |>
    send_file(200, "static/home.html")
  end

  match _, do: send_resp(conn, 404, "Not found :(")

end
