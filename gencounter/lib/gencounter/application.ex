defmodule Gencounter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  use Supervisor

  @impl true
  def start(_type, _args) do
    children = [
      worker(Gencounter.Producer, [0]),
      worker(Gencounter.ProducerConsumer, []),
      worker(Gencounter.Consumer, [], id: :a),
      worker(Gencounter.Consumer, [], id: :b)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gencounter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
