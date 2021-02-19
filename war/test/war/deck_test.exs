defmodule War.DeckTest do
  use ExUnit.Case

  test "new deck contains 52 cards" do
    deck = War.Deck.new()
    assert length(deck) == 52
  end
end
