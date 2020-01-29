defmodule SalesAdmin.Repo do
  use Ecto.Repo,
    otp_app: :sales_admin,
    adapter: Ecto.Adapters.Postgres
end
