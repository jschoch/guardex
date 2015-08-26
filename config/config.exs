# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :guardex, Guardex.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "t8I2LIpKa1zEq+bi+WqTPy5sjsvXIEuKpTCufjSKQk2Zeb5mFplfFRfBy6UXB1cQ",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Guardex.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Guardian

config :joken, config_module: Guardian.JWT

config :guardian, Guardian,
  issuer: "Guardex",
  ttl: { 30, :days },
  verify_issuer: true,
  secret_key: "super secreted here",
  serializer: Guardex

config :guardian, Guardian,
       permissions: %{
         default: [:read, :write],
         admin: [:dashboard, :reconcile]
       }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
