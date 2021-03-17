defmodule InterfaceLikeTest do
  use ExUnit.Case
  doctest InterfaceLike

  test "greets the world" do
    assert InterfaceLike.hello() == :world
  end
end
