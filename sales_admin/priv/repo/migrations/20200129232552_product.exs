defmodule SalesAdmin.Repo.Migrations.Product do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :string
      add :unit_price, :integer
    end
  end
end
