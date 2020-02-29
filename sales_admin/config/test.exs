use Mix.Config

# Configure your database
config :sales_admin, SalesAdmin.Repo,
  username: "postgres",
  password: "postgres",
  database: "sales_admin_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sales_admin, SalesAdminWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
