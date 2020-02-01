defmodule SalesAdmin.Repo.Migrations.CreateOrderItems do
  use Ecto.Migration

  def change do
    create table("order_items") do
      add :order_id, references("orders")
      add :product_id, references("products")
      add :price, :decimal
      add :quantity, :integer
      timestamps()
    end
  end
end
