defmodule GeneratingDocTest do
  use ExUnit.Case
  doctest GeneratingDoc

  test "greets the world" do
    assert GeneratingDoc.hello() == :world
  end
end
