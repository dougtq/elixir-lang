defmodule Weather.Router do
  use Plug.Router

  plug Plug.Parsers, parsers: [:json],
                              pass: ["text/*"],
                              json_decoder: Jason

  plug :match
  plug :dispatch

  get "/" do
    render(conn, "index.html")
  end

  post "/fetch" do
    IO.puts(inspect(conn.body_params))
    fetch_weather(conn, conn.body_params)
  end

  get "/ping" do
    conn |>
    send_resp(200, "pong")
  end

  match _ do
    conn |>
    send_resp(404, "404")
  end

  defp render(%{ status: status } = conn, template, assigns \\ []) do
    body =
      "lib/weather/templates"
      |> Path.join(template)
      |> String.replace_suffix(".html", ".html.eex")
      |> EEx.eval_file(assigns)

    conn |>
    send_resp((status || 200), body)
  end

  defp render_json(%{ status: status } = conn, data) do
    body = Jason.encode!(data)
    conn |>
    send_resp((status || 200), body)
  end

  defp fetch_weather(conn, %{ "city" => city }) do
    IO.puts("entrou no def correto")
    data = Weather.fetch(city)
    IO.puts(inspect(data))
    render_json(conn, data)
  end

  defp fetch_weather(conn, _) do
    IO.puts("entrou no def 500")
    conn |>
    send_resp(500, "invalid payload")
  end
end
