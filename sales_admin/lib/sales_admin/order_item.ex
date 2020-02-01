defmodule SalesAdmin.OrderItem do
  use Ecto.Schema

  schema "order_items" do
    field :price, :decimal 
    field :quantity, :integer 
    timestamps() 

    belongs_to :order, SalesAdmin.Order
    has_one :product, SalesAdmin.Product
  end
end
