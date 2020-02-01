defmodule SalesAdmin.Customer do
  use Ecto.Schema

  schema "customers" do
    field :first_name, :string 
    field :last_name, :string
    field :middle_name, :string
    timestamps() 

    has_one :address, SalesAdmin.Address
  end
end
