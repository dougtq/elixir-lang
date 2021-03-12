defmodule Weather do
  @moduledoc """
  Documentation for `Weather`.
  """
  def fetch(city) do
    [city]
    |> Metex.Coordinator.retrieve_temps()
    |> List.first
  end
end
