defmodule GeneratingDoc.MixProject do
  use Mix.Project

  def project do
    [
      app: :generating_doc,
      name: "Doc Project",
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19.3", only: [:dev]},
      {:earmark, "~> 1.3", only: [:dev]}
    ]
  end
end
