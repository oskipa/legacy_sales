defmodule SalesAdmin.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :notes, :string 
    timestamps() 

    has_one :customer, SalesAdmin.Customer
    has_one :merchant, SalesAdmin.Merchant
    has_many :order_items, SalesAdmin.OrderItem
  end

  def changeset(order, params \\ %{}) do
    order
    |> cast(params, [:notes, :customer, :merchant, :order_items])
    |> validate_required([:customer, :merchant, :order_items])
  end
end
