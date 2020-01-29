defmodule ProductTest do
  use ExUnit.Case
  doctest Product

  test "interface" do
    product = %Product{}

    assert Map.has_key?(product, :name)
    assert Map.has_key?(product, :description)
    assert Map.has_key?(product, :price)
    assert Map.has_key?(product, :code)
  end
end
