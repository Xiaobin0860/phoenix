# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :x,
  ecto_repos: [X.Repo]

# Configures the endpoint
config :x, XWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mEnMYrd/59oEgBee4vFeavxOhgq0jNFMdOH8S4KK7B1a7I9ViiU6s/UmmvS+m/Hq",
  render_errors: [view: XWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub: [name: X.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
