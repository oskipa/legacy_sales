defmodule SalesAdmin.Repo.Migrations.CreateAddress do
  use Ecto.Migration

  def change do
    create table("addresses") do
      add :address, :string
      add :address_2, :string
      add :city, :string
      add :tate, :string
      add :postal_code, :string
      add :country, :string
      timestamps() 
    end
  end
end
