defmodule PokeApi do
  use Application
  require Logger

  def start(_type, _args) do
    port = Application.get_env(:poke_api, :cowboy_port, 4300)

    children = [
      {Plug.Cowboy, scheme: :http, plug: PokeApi.Router, options: [port: port]}
    ]

    Logger.info "Poke Api has started on #{port}!"

    PokeApi.Database.start(nil, nil)
    Supervisor.start_link(children, [strategy: :one_for_one, name: PokeApi.Supervisor])
  end
end
