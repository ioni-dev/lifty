# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lifty,
  ecto_repos: [Lifty.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :lifty, LiftyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AcEzIvkqdm6CGH036wQtXpXVmBUkUINYO7OGpaKqSuPIaqNx1ZXqZWSv6yjD/ofk",
  render_errors: [view: LiftyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Lifty.PubSub,
  live_view: [signing_salt: "03Ka9K3x"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :ueberauth, Ueberauth,
    base_path: "/api/auth",
    providers: [
      identity: {Ueberauth.Strategy.Identity, [
        callback_methods: ["POST"],
        nickname_field: :email,
        param_nesting: "user",
        uid_field: :email
      ]}
    ]

  config :lifty, Lifty.Guardian,
    issuer: "lifty",
    secret_key: "AcEzIvkqdm6CGH036wQtXpXVmBUkUINYO7OGpaKqSuPIaqNx1ZXqZWSv6yjD/ofk",

    # We will get round to using these permissions at the end
    permissions: %{
      default: [:read_users, :write_users]
    }
# Configure the authentication plug pipeline
config :lifty, LiftyWeb.Plug.AuthAccessPipeline,
module: Lifty.Guardian,
error_handler: LiftyWeb.Plug.AuthErrorHandler
