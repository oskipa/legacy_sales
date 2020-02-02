defmodule SalesAdmin.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchants" do
    field :name, :string 
    timestamps() 

    has_one :address, SalesAdmin.Address
  end

  def changeset(merchant, params \\ %{}) do
    merchant
    |> cast(params, [:name, :address])
    |> validate_required([:name])
    |> validate_length(:name, min: 3)
  end

end
