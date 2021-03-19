defmodule GuardClausesTest do
  use ExUnit.Case
  doctest GuardClauses

  test "greets the world" do
    assert GuardClauses.hello() == :world
  end
end
