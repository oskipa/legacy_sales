defmodule SalesAdmin.Repo.Migrations.CreateMerchant do
  use Ecto.Migration

  def change do
    create table("merchants") do
      add :name, :string
      add :address_id, references(:addresses)
      timestamps() 
    end
  end
end
