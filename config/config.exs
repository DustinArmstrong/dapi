# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dapi,
  ecto_repos: [Dapi.Repo]

# Configures the endpoint
config :dapi, DapiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ds/eS78fmOhpiDTVupJtp57Vx/bN7wrqob7PCv/zAW2M5Q8s7+tnmuqLUNPEegNV",
  render_errors: [view: DapiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dapi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
