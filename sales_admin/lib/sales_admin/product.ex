defmodule SalesAdmin.Product do
  use Ecto.Schema

  schema "products" do
    field :name, :string 
    field :description, :string 
    field :unit_price, :integer 
  end

end
