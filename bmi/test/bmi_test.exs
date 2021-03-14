defmodule BmiTest do
  use ExUnit.Case
  doctest Bmi

  test "greets the world" do
    assert Bmi.hello() == :world
  end

  test "the BMI of a person with 180cm and 70kg is 21.6" do
    assert Bmi.compute(180, 70) == 21.6
  end

  test "the BMI of a person with 170cm and 90kg is 31.1" do
    assert Bmi.compute(170, 90) == 31.1
  end
end
