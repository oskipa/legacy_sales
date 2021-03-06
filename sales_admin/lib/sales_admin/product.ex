defmodule SalesAdmin.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string 
    field :description, :string 
    field :unit_price, :decimal 
    field :product_code, :string 
    timestamps()
  end

  def changeset(product, params \\ %{}) do
    product
    |> cast(params, [:name, :description, :unit_price, :product_code])
    |> validate_required([:name, :unit_price])
    |> validate_length(:name, min: 3)
    |> validate_number(:unit_price, greater_than: -1.0)
  end
end
