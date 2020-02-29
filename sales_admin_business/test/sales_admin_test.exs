defmodule SalesAdminTest do
  use ExUnit.Case
  doctest SalesAdmin

  test "greets the world" do
    assert SalesAdmin.hello() == :world
  end
end
