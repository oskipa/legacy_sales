defmodule SalesAdmin.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :first, :string 
    field :last_name, :string
    field :middle_name, :string
    timestamps() 

    belongs_to :address, SalesAdmin.Address

    def changeset(customer, params \\ %{}) do
      customer
      |> cast(params, [:first, :last_name, :middle_name, :address_id])
      |> validate_required([:first, :last_name]) 
      |> validate_length(:first, min: 1)
      |> validate_length(:last_name, min: 1)
    end
  end
end
