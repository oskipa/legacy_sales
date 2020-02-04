use Mix.Config

config :sales_admin, SalesAdmin.Repo,
  database: "sales_admin_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
