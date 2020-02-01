defmodule SalesAdmin.Repo.Migrations.AlterAddressessAddCustomerIdAndMerchantId do
  use Ecto.Migration

  def change do
    alter table("addresses") do
      add :customer_id, references("customers")
      add :merchant_id, references("merchants")
    end
  end
end
