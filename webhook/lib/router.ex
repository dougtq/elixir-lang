defmodule Webhook.Router do
  @moduledoc """
  Documentation for `Router`.
  """
  use Plug.Router
  use Plug.ErrorHandler
  require Logger

  if Mix.env == :dev do
    use Plug.Debugger
  end

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

  post "/events" do
    body = conn.body_params
    IO.puts(inspect(conn.body_params))

    cond do
      Map.has_key?(body, "_json") === false -> mount_response({ :error, "invalid or null payload of events" })
      Map.has_key?(body, "_json") === true and length(body["_json"]) === 0 -> mount_response({ :not_found, conn, "empty payload of events" })
      Map.has_key?(body, "_json") === true and length(body["_json"]) -> mount_response({ :ok, "events received successfully" })
    end
  end

  match _ do
    { status, body } = mount_response({ :not_found, "Resource not found!" })

    conn |>
    send_resp(status, body)
  end

  defp handle_errors(conn, %{ kind: _kind, reason: _reason, stack: _stack }) do
    { status, body } = mount_response({ :error, "invalid or null payload of events" })
    conn |>
    send_resp(status, body)
  end

  defp mount_response({ :ok, conn, message }) do
    body = %{
      message: message,
      status: 200,
    }

    send_response_json({ conn, %{ status: body.status, body: Poison.encode!(body) } })
  end

  defp mount_response({ :error, conn, message }) do
    body = %{
      message: message,
      status: 500,
    }

    send_response_json({ conn, %{ status: body.status, body: Poison.encode!(body) } })
  end

  defp mount_response({ :not_found, conn, message }) do
    body = %{
      message: message,
      status: 404,
    }

    send_response_json({ conn, %{ status: body.status, body: Poison.encode!(body) } })
  end

  defp send_response_json({ conn, %{ status: status, body: body }}) do
    conn |>
    put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(status, body)
  end
end
