# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :simple_auth,
  ecto_repos: [SimpleAuth.Repo]

# Configures the endpoint
config :simple_auth, SimpleAuth.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "W+lGl/kOh6aOHv/J0Pnph4CYve0oFNhNNxriZ/w7jC7+AzsDP+Zt98XPh2R9mnTj",
  render_errors: [view: SimpleAuth.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SimpleAuth.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"