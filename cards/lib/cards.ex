defmodule Cards do
  @moduledoc """
  Documentation for `Cards` Module.
  Provides methods for creating and handling a deck of cards
  """


  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

  """
  @spec hello :: :world
  def hello do
    :world
  end

  @doc """
  Returns a list of maps represeting a deck of cards.

  ## Examples

      iex(1)> _deck = Cards.create_deck
      [
        %{suit: :spades, value: :ace},
        %{suit: :diamonds, value: :ace},
        %{suit: :clubs, value: :ace},
        %{suit: :hearts, value: :ace},
        %{suit: :spades, value: :two},
        %{suit: :diamonds, value: :two},
        %{suit: :clubs, value: :two},
        %{suit: :hearts, value: :two},
        %{suit: :spades, value: :three},
        %{suit: :diamonds, value: :three},
        %{suit: :clubs, value: :three},
        %{suit: :hearts, value: :three},
        %{suit: :spades, value: :four},
        %{suit: :diamonds, value: :four},
        %{suit: :clubs, value: :four},
        %{suit: :hearts, value: :four},
        %{suit: :spades, value: :five},
        %{suit: :diamonds, value: :five},
        %{suit: :clubs, value: :five},
        %{suit: :hearts, value: :five},
        %{suit: :spades, value: :six},
        %{suit: :diamonds, value: :six},
        %{suit: :clubs, value: :six},
        %{suit: :hearts, value: :six},
        %{suit: :spades, value: :seven},
        %{suit: :diamonds, value: :seven},
        %{suit: :clubs, value: :seven},
        %{suit: :hearts, value: :seven},
        %{suit: :spades, value: :queen},
        %{suit: :diamonds, value: :queen},
        %{suit: :clubs, value: :queen},
        %{suit: :hearts, value: :queen},
        %{suit: :spades, value: :jack},
        %{suit: :diamonds, value: :jack},
        %{suit: :clubs, value: :jack},
        %{suit: :hearts, value: :jack},
        %{suit: :spades, value: :king},
        %{suit: :diamonds, value: :king},
        %{suit: :clubs, value: :king},
        %{suit: :hearts, value: :king}
      ]
  """
  @spec create_deck :: list
  def create_deck do
    for value <- values(), suit <- suits() do
      %{ value: value, suit: suit}
    end
  end

  defp values(), do: [:ace, :two, :three, :four, :five, :six, :seven, :queen, :jack, :king]

  defp suits(), do: [:spades, :diamonds, :clubs, :hearts]

  @doc """
  Receives a deck then shuffles it.
  """
  @spec shuffle(list) :: list
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Receives a deck and a card map then checks if that card is on the deck.

  ## Examples

      iex> Cards.contains?([%{suit: :clubs, value: :king}], %{suit: :clubs, value: :king})
      true
  """
  @spec contains?(list, map) :: boolean
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Receives a deck and a hand size then takes that amount of cards from the deck and returns the remainder of the deck.
  The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> Cards.deal([%{suit: :clubs, value: :jack}], 1)
      {[%{suit: :clubs, value: :jack}], []}
  """
  @spec deal(list, number) :: tuple
  def deal(deck, hand_size) do
      Enum.split(deck, hand_size)
  end

  @doc """
  Receives a deck and a filename then saves it as a file.

  ## Examples

      iex> Cards.save([%{suit: :clubs, value: :jack}], "test.txt")
      :ok
  """
  @spec save(
          list,
          charlist
        ) :: :ok | {:error, atom}
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Receives a filename then tries to load it.

  ## Examples

      iex> Cards.load("my_deck.txt")
      { :ok, [
                %{suit: :spades, value: :ace},
                %{suit: :diamonds, value: :ace},
                %{suit: :clubs, value: :ace},
                %{suit: :hearts, value: :ace},
                %{suit: :spades, value: :two},
                %{suit: :diamonds, value: :two},
                %{suit: :clubs, value: :two},
                %{suit: :hearts, value: :two},
                %{suit: :spades, value: :three},
                %{suit: :diamonds, value: :three},
                %{suit: :clubs, value: :three},
                %{suit: :hearts, value: :three},
                %{suit: :spades, value: :four},
                %{suit: :diamonds, value: :four},
                %{suit: :clubs, value: :four},
                %{suit: :hearts, value: :four},
                %{suit: :spades, value: :five},
                %{suit: :diamonds, value: :five},
                %{suit: :clubs, value: :five},
                %{suit: :hearts, value: :five},
                %{suit: :spades, value: :six},
                %{suit: :diamonds, value: :six},
                %{suit: :clubs, value: :six},
                %{suit: :hearts, value: :six},
                %{suit: :spades, value: :seven},
                %{suit: :diamonds, value: :seven},
                %{suit: :clubs, value: :seven},
                %{suit: :hearts, value: :seven},
                %{suit: :spades, value: :queen},
                %{suit: :diamonds, value: :queen},
                %{suit: :clubs, value: :queen},
                %{suit: :hearts, value: :queen},
                %{suit: :spades, value: :jack},
                %{suit: :diamonds, value: :jack},
                %{suit: :clubs, value: :jack},
                %{suit: :hearts, value: :jack},
                %{suit: :spades, value: :king},
                %{suit: :diamonds, value: :king},
                %{suit: :clubs, value: :king},
                %{suit: :hearts, value: :king}
              ] }
  """
  @spec load(charlist) :: {:error, charlist} | {:ok, list}
  def load(filename) do
    case File.read(filename) do
      { :error, reason } -> { :error, "There is something wrong with the file: #{reason}"}
      { :ok, binary }-> { :ok, :erlang.binary_to_term(binary) }
    end
  end

  @doc """
  Receives a number of the hand size, then creates a deck, shuffles it and deals.
  """
  @spec create_hand(number) :: tuple
  def create_hand(hand_size) do
    Cards.create_deck
      |> Cards.shuffle
      |> Cards.deal(hand_size)
  end
end
