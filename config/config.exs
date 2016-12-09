# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :movie_wager_api,
  ecto_repos: [MovieWagerApi.Repo]

# Configures the endpoint
config :movie_wager_api, MovieWagerApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zM9UVtA1heQ10QEh/78e4AphWog3VzmezzyN1ie89C5um8FCuJWn4oYSqoFPvD1L",
  render_errors: [view: MovieWagerApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MovieWagerApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :extwitter, :oauth, [
   consumer_key: ""
   consumer_secret: ""
   access_token: ""
   access_token_secret: ""
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
