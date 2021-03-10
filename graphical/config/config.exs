# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :graphical,
  ecto_repos: [Graphical.Repo]

# Configures the endpoint
config :graphical, GraphicalWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iJiEV1W90EaW9ggPNw5z/aL1hYcmI/1jiR6hjZWU/TD/Pc4Re/oFuce13q6L9D78",
  render_errors: [view: GraphicalWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Graphical.PubSub,
  live_view: [signing_salt: "GIjlAQdw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Guardian
config :graphical, Graphical.Guardian,
  issuer: "graphical",
  secret_key: "TzK+43GHf/C9GPg6ulIUIwLlgeUbxf8f5BI9SojDWZaLDXMBC+/8WtgtjykHfkOw"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
