defmodule SalesAdmin.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_items" do
    field :price, :decimal 
    field :quantity, :integer 
    timestamps() 

    belongs_to :order, SalesAdmin.Order
    belongs_to :product, SalesAdmin.Product
  end

  def changeset(order_item, params \\ %{}) do
    order_item
    |> cast(params, [:price, :quantity, :order, :product])
    |> validate_required([:price, :quantity, :order, :product])
  end
end
