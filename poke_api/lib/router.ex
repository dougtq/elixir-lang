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
          String.downcase(response.body) == "not found" ->
            { status, body } = mount_response({ :not_found, "Poke not found" })
            conn |>
            send_resp(status, body)
          true ->
            poke_details = Poison.decode!(response.body)

            { status, body } = mount_response({ :ok, "Poke details found", poke_details })

            conn |>
            send_resp(status, body)
        end
      {:error, _} ->

        { status, body } = mount_response({ :error, "An error ocurred" })

        conn |>
        send_resp(status, body)
    end
  end

  match _ do
    { status, body } = mount_response({ :not_found, "Resource not found!" })

    conn |>
    send_resp(status, body)
  end

  # defp mount_response(message, status, poke_details) do
  #   body = %{
  #     message: message,
  #     status: status || 200,
  #     details: poke_details || nil
  #   }
  #
  #   {status, Poison.encode!(body)}
  # end
  #
  # # fix this with pattern matching
  # defp mount_error_response(message, status) do
  #   body = %{
  #     message: message,
  #     status: status || 500
  #   }
  #
  #   {status, Poison.encode!(body)}
  # end

  defp mount_response({ :ok, message, poke_details }) do
    body = %{
      message: message,
      status: 200,
      details: poke_details || nil
    }

    { body.status, Poison.encode!(body)}
  end

  defp mount_response({ :error, message }) do
    body = %{
      message: message,
      status: 500,
    }

    { body.status, Poison.encode!(body)}
  end

  defp mount_response({ :not_found, message }) do
    body = %{
      message: message,
      status: 404,
    }

    { body.status, Poison.encode!(body)}
  end

  defp get_poke(poke_name) do
    poke_api_url = Application.get_env(:poke_api, :poke_api_url, nil)

    HTTPoison.get(poke_api_url <> "pokemon" <> "/" <> poke_name)
  end
end
