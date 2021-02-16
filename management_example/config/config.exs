# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :management_example,
  ecto_repos: [ManagementExample.Repo]

# Configures the endpoint
config :management_example, ManagementExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Cxsr1idGyTvzGJBP5hTQ8lA4JQhUry8dMJjYiqIviCRbaxayT5/ih5cwKJ3IgPuH",
  render_errors: [view: ManagementExampleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ManagementExample.PubSub,
  live_view: [signing_salt: "iigoHgC1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# config :mime, :types, %{
#     "application/vnd.api+json" => ["json-api"]
# }

# Configures Phoenix json api enconder
config :phoenix, :format_encoders,
  "json-api": Poison

# Use Jason for JSON parsing in Phoenix
# config :phoenix, :json_library, Poison

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
