defmodule MathUnitTest do
  @spec add(number, number) :: number
  def add(x, y), do: x + y

  @spec subtract(number, number) :: number
  def subtract(x, y), do: x - y

  @spec multiply(number, number) :: number
  def multiply(x, y), do: x * y
end
