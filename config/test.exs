use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :movie_wager_api, MovieWagerApi.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :movie_wager_api, MovieWagerApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "movie_wager_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
