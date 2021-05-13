# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :foodApp,
  ecto_repos: [FoodApp.Repo]

# Configures the endpoint
config :foodApp, FoodAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SZSLZQnLPe5Z5cGX82tkNC4PHwoIyWwLl1WHzYelGkhhtfuzbPpnrQK6UhG3G6ck",
  render_errors: [view: FoodAppWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: FoodApp.PubSub,
  live_view: [signing_salt: "/1kwypu/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :foodApp, FoodApp.Guardian,
       issuer: "foodApp",
       secret_key: "AULdneJfiKl2gie82cYFu+IAPL19TRvPFFRh5GyGczhWEvB3frJHBa/wioY2ceMK"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
