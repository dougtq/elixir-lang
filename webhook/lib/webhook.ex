defmodule Webhook do
  @moduledoc """
  Documentation for `Webhook`.
  """
  use Application
  require Logger

  @doc """
  Start webhook and its supervisor

  ## Examples
      iex> Webhook.start(nil, nil)
      { :ok,  pid }
  """
  def start(_type, _args) do
    port = Application.get_env(:webhook, :cowboy_port, 8081)

    children = [
      {Plug.Cowboy, scheme: :http, plug: Webhook.Router, options: [port: port]}
    ]

    Logger.info "Webhook has started on #{port}!"

    Supervisor.start_link(children, [strategy: :one_for_one, name: Webhook.Supervisor])
  end

  @doc """
  Hello world.

  ## Examples

      iex> Webhook.hello()
      :world

  """
  def hello do
    :world
  end
end
