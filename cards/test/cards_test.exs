defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  setup_all _ctx do
    [hello: Cards.hello]
  end

  setup _ctx do
    [deck: Cards.create_deck, cards_left: Cards.create_hand(5) |> elem(1)]
  end

  test "greets the world", %{hello: hello} do
    assert hello == :world
  end

  test "create_deck makes 40 cards", %{deck: deck} do
    assert length(deck) == 40
  end

  test "shuffle randomizes a deck", %{deck: deck} do
    refute deck == Cards.shuffle(deck)
    refute deck == Cards.shuffle(deck)
  end

  test "creates a hand of cards of randomic size" do
    hand_size = Enum.random(1..40)
    assert length(Cards.create_hand(hand_size) |> elem(0)) == hand_size
  end

  test "creates a hand of 5 cards and check the number of cards left", %{cards_left: cards_left} do
    assert length(cards_left) == 35
  end

  test "check if a deck does not contains a alien of clubs card", %{deck: deck} do
    refute Cards.contains?(deck, %{suit: :clubs, value: :alien}) == true
  end

  test "check if a deck contains a queen of clubs", %{deck: deck} do
    assert Cards.contains?(deck, %{suit: :clubs, value: :queen}) == true
  end
end
