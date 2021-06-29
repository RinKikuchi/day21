# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :evacuation_map,
  ecto_repos: [EvacuationMap.Repo]

# Configures the endpoint
config :evacuation_map, EvacuationMapWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iPUlsrOVM3DdLFDQH6sdP6NrUjmpECCatNHL12Njs5fQ/bP/X2lpewmRXA1559TJ",
  render_errors: [view: EvacuationMapWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: EvacuationMap.PubSub,
  live_view: [signing_salt: "gtVwR6AP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
