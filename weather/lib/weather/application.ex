defmodule Weather.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Weather.Worker.start_link(arg)
      # {Weather.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: Weather.Router, options: [port: 4001]}
    ]

    Logger.info "Poke Api has started on 4001!"

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Weather.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
