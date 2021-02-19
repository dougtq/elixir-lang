defmodule War.Deck do
  defmodule Card do
    defstruct [:suit, :value]
  end

  def new() do
    for value <- values(), suit <- suits() do
      %Card{ value: value, suit: suit}
    end |> Enum.shuffle()
  end

  #use vales 11-14 as Jack-Aces
  defp values(), do: Enum.to_list(2..14)

  defp suits(), do: [:spades, :diamonds, :clubs, :hearts]
end
