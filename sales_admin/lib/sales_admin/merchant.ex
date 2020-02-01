defmodule SalesAdmin.Merchant do
  use Ecto.Schema

  schema "merchants" do
    field :name, :string 
    timestamps() 

    has_one :address, SalesAdmin.Address
  end
end
