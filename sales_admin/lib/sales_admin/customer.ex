defmodule SalesAdmin.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :first_name, :string 
    field :last_name, :string
    field :middle_name, :string
    timestamps() 

    has_one :address, SalesAdmin.Address

    def changeset(customer, params \\ %{}) do
      customer
      |> cast(params, [:first_name, :last_name, :middle_name, :address])
      |> validate_required([:first_name, :last_name]) 
      |> validate_length(:first_name, min: 1)
      |> validate_length(:last_name, min: 1)
    end
  end
end
