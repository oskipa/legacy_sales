defmodule SalesAdmin.Order do
  use Ecto.Schema

  schema "orders" do
    field :notes, :string 
    field :last_name, :string
    field :middle_name, :string
    timestamps() 

    has_one :customer, SalesAdmin.Customer
    has_one :merchant, SalesAdmin.Merchant
    has_many :order_items, SalesAdmin.OrderItem
  end
end
