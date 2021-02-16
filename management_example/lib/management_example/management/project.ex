defmodule ManagementExample.Management.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
