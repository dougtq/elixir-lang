defmodule Chatter.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Chatter.Message
  alias Chatter.Repo

  schema "messages" do
    field :message, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:name, :message])
    |> validate_required([:name, :message])
  end

  def get_msgs(limit \\ 25) do
    Repo.all(Message, limit: limit)
  end
end
