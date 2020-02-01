defmodule SalesAdmin.Repo.Migrations.AlterCustomerFirstName do
  use Ecto.Migration

  def change do
    rename table("customers"), :first, to: :first_name
  end
end
