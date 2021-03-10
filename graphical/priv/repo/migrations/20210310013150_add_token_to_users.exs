defmodule Graphical.Repo.Migrations.AddTokenToUsers do
  use Ecto.Migration

  def change do
    alter talbe(:users) do
      add :token, :string
    end
  end
end
