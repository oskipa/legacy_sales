# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sales_admin,
  ecto_repos: [SalesAdmin.Repo]

# Configures the endpoint
config :sales_admin, SalesAdminWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cXp091jYouEbUyATFVdzKQY7Dz9kY4AjXTkEGsXzO7mSzgQ9a1JzewnFtxxecTMZ",
  render_errors: [view: SalesAdminWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SalesAdmin.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
