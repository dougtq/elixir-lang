defmodule Scheduler.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :name, :string
    many_to_many :user, Scheduler.Accounts.User, join_through: Scheduler.Companies.CompaniesUsers

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
