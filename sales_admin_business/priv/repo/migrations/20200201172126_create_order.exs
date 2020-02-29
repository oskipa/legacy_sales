defmodule SalesAdmin.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table("orders") do
      add :customer_id, references("customers")
      add :merchant_id, references("merchants")
      add :notes, :text
      timestamps()
    end
  end
end
