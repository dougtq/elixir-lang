defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "greets the world" do
    assert Cards.hello() == :world
  end

  test "create_deck makes 40 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 40
  end

  test "shuffle randomizes a deck" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
    refute deck == Cards.shuffle(deck)
  end

  test "create a hand of cards of randomic size" do
    hand_size = Enum.random(1..40)
    hand = Cards.create_hand(hand_size) |> elem(0)
    assert length(hand) == hand_size
  end

  test "check if a deck does not contains a alien of clubs card" do
    deck = Cards.create_deck
    refute Cards.contains?(deck, %{suit: :clubs, value: :alien }) == true
  end

  test "check if a deck contains a queen of clubs" do
    deck = Cards.create_deck
    assert Cards.contains?(deck, %{suit: :clubs, value: :queen }) == true
  end
end
