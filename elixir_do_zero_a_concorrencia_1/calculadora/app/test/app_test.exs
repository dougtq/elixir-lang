defmodule AppTest do
  use ExUnit.Case
  doctest App

  test "greets the world" do
    assert App.hello() == :world
  end

  test "the truth" do
    assert 1 + 1 == 2
  end
end
