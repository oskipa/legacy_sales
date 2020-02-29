import Config

config :sales_admin,
      ecto_repos: [SalesAdmin.Repo]

config :sales_admin, SalesAdmin.Repo,
  database: "sales_admin_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

import_config "#{Mix.env()}.exs"
