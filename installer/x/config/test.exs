use Mix.Config

# Configure your database
config :x, X.Repo,
  username: "postgres",
  password: "postgres",
  database: "x_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :x, XWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :x, X.Accounts.Guardian,
  issuer: "x",
  secret_key: "wWIC42gV8VDQXL47Sa/BXhoWiAy+Usq7Tmc3eaSbebXT+D+mvlGQJl4HVYOm2MXA"
