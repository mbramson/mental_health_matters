use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mental_health_matters, MentalHealthMatters.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :mental_health_matters, MentalHealthMatters.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("PG_USER"),
  password: System.get_env("PG_PASSWORD"),
  database: "mental_health_matters_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
