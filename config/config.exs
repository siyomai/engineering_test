# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :engineering_test,
  ecto_repos: [EngineeringTest.Repo]

# Configures the endpoint
config :engineering_test, EngineeringTest.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZFFyzhW2hZtbrEHNd9mC4Ser2izqMcjFR+TgTz7HXTduYqKQrK0l/0pjQTql6XWm",
  render_errors: [view: EngineeringTest.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EngineeringTest.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
