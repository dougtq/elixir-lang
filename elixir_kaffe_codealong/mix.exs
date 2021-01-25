defmodule ElixirKaffeCodealong.MixProject do
  use Mix.Project

  def application do
    [
      extra_applications: [:logger, :kaffe],
      mod: {ElixirKaffeCodealong.Application, []}
      # now that we're using the Application module, this is where we'll tell it to start.
      # We use the keyword `mod` with applications that start a supervision tree,
      # which we configured when adding our Kaffe.Consumer to Application above.
    ]
  end

  def project do
    [
      app: :elixir_kaffe_codealong,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:kaffe, "~> 1.9"}
    ]
  end
end
