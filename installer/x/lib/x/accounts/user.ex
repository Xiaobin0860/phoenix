defmodule X.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :mail, :string
    field :nick, :string
    field :pass_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:mail, :pass_hash, :nick])
    |> validate_required([:mail, :pass_hash, :nick])
    |> unique_constraint(:mail)
    |> unique_constraint(:nick)
  end
end
