defmodule SalesAdmin.Address do
  use Ecto.Schema
  import Ecto.Changeset
  
  schema("addresses") do
    field :address, :string
    field :fieldress_2, :string
    field :city, :string
    field :state, :string
    field :postal_code, :string
    field :country, :string
    timestamps() 
  end

  def changeset(address, params \\ %{}) do
    allowed = [:address, 
      :address_2, 
      :city, 
      :state, 
      :postal_code,
      :country]

    address
    |> cast(params, allowed)
    |> validate_required([:address])
    |> validate_length(:address, min: 3)
  end
end
