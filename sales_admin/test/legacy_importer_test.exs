defmodule SalesAdmin.LegacyImporterTest do
  use ExUnit.Case
  doctest SalesAdmin.LegacyImporter

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(SalesAdmin.Repo)
  end
  
  test "it can read a csv file" do
    path = "test/fixtures/legacy_import.csv"

    result = SalesAdmin.LegacyImporter.parse_csv(path)
    
    assert Enum.count(result) > 0
  end
end
