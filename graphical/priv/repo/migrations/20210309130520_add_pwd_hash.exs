defmodule Graphical.Repo.Migrations.AddPwdHash do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :pwd_hash, :string
    end
  end
end
