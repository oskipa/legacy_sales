defmodule SalesAdmin.Repo.Migrations.CreateCustomer do
  use Ecto.Migration

  def change do
    create table("customers") do
      add :first, :string
      add :last_name, :string
      add :middle_name, :string
      add :address_id, references(:addresses)
      timestamps() 
    end
  end
end
