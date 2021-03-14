defmodule Bmi do
  @moduledoc """
  Documentation for `Bmi`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Bmi.hello()
      :world

  """
  def hello do
    :world
  end

  def compute(height_in_cm, weight_in_kg) do
    height_in_m = height_in_cm / 100
    weight_in_kg/(height_in_m*height_in_m)
    |> Float.round(1)
  end
end
