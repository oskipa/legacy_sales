defmodule SalesAdmin.Repo.Migrations.Product do
  use Ecto.Migration

  def change do
    create table("products") do
      add :name, :string
      add :description, :string
      add :unit_price, :decimal
      add :product_code, :string
      timestamps()
    end
  end
end
