defmodule SalesAdmin.Repo.Migrations.AlterAddressessAlterTateToState do
  use Ecto.Migration

  def change do
    rename table("addresses"), :tate, to: :state
  end
end
