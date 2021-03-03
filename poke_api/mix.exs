defmodule PokeApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :poke_api,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :plug, :cowboy, :httpoison, :redix],
      mod: { PokeApi, [] }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0.1"},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.7"},
      {:redix, "~> 1.0.0"}
    ]
  end
end
