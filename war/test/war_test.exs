defmodule WarTest do
  use ExUnit.Case
  doctest War

  test "greets the world" do
    assert War.hello() == :world
  end
end
