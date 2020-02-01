defmodule SalesAdmin.Address do
  use Ecto.Schema
  
   schema("addresses") do
      field :address, :string
      field :fieldress_2, :string
      field :city, :string
      field :tate, :string
      field :postal_code, :string
      field :country, :string
      timestamps() 
    end
end
