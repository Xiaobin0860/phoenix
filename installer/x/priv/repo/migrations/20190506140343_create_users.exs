defmodule X.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :mail, :string
      add :pass_hash, :string
      add :nick, :string

      timestamps()
    end

    create unique_index(:users, [:mail])
    create unique_index(:users, [:nick])
  end
end
