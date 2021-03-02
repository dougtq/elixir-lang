defmodule PokeApi.Router do
  use Plug.Router
  require Logger

  plug Plug.Logger
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug :match
  plug :dispatch


  get "/ping" do
    conn |>
    send_resp(200, "pong")
  end

  get "/favicon.ico" do
    conn |>
    send_resp(200, "")
  end

  get "/poke/:name" do
    case get_poke name do
      {:ok, response} ->
        IO.puts(inspect(response))

        cond do
          response.body == "Not Found" ->
            { status, body } = mount_error_response("Poke not found", 404)
            conn |>
            send_resp(status, body)
          true ->
            poke_details = Poison.decode!(response.body)

            { status, body } = mount_response("Poke details found", 200, poke_details)

            conn |>
            send_resp(status, body)
        end
      {:error, _} ->

        { status, body } = mount_error_response("An error ocurred", 500)

        conn |>
        send_resp(status, body)
    end
  end

  match _ do
    { status, body } = mount_error_response("Resource not found!", 404)

    conn |>
    send_resp(status, body)
  end

  defp mount_response(message, status, poke_details) do
    body = %{
      message: message,
      status: status || 200,
      details: poke_details || nil
    }

    {status, Poison.encode!(body)}
  end

  # fix this with patter matching
  defp mount_error_response(message, status) do
    body = %{
      message: message,
      status: status || 500
    }

    {status, Poison.encode!(body)}
  end

  defp get_poke(poke_name) do
    poke_api_url = Application.get_env(:poke_api, :poke_api_url, nil)

    HTTPoison.get(poke_api_url <> "pokemon" <> "/" <> poke_name)
  end


end
