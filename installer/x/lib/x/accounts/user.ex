defmodule X.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :mail, :string
    field :nick, :string
    field :pass_hash, :string
    # Virtual fields:
    field :pass, :string, virtual: true
    field :pass_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:mail, :nick, :pass, :pass_confirmation])
    |> validate_required([:mail, :nick, :pass, :pass_confirmation])
    |> validate_format(:mail, ~r/@/)
    |> validate_length(:pass, min: 8, max: 32)
    |> validate_format(:nick, ~r/^[a-zA-Z][a-zA-Z0-9]{4,32}$/)
    # Check that pass === pass_confirmation
    |> validate_confirmation(:pass)
    |> unique_constraint(:mail)
    |> unique_constraint(:nick)
    |> put_pass_hash
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{pass: pass}} ->
        put_change(changeset, :pass_hash, Argon2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
