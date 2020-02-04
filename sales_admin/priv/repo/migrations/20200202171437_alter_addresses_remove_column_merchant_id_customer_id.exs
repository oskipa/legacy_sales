defmodule SalesAdmin.Repo.Migrations.AlterAddressesRemoveColumnMerchantIdCustomerId do
  use Ecto.Migration

  def change do
    alter table("addresses") do
      remove :merchant_id
      remove :customer_id
    end
  end
end
