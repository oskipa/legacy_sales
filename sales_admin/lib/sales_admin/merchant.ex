defmodule SalesAdmin.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchants" do
    field :name, :string 
    timestamps() 

    belongs_to :address, SalesAdmin.Address
  end

  def changeset(merchant, params \\ %{}) do
    merchant
    |> cast(params, [:name, :address_id])
    |> validate_required([:name])
    |> validate_length(:name, min: 3)
  end

end
