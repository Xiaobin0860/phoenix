defmodule X.AccountsTest do
  use X.DataCase

  alias X.Accounts

  describe "users" do
    alias X.Accounts.User

    @valid_attrs %{
      mail: "some@mail",
      nick: "SomeNick",
      pass: "12345678",
      pass_confirmation: "12345678"
    }
    @update_attrs %{
      mail: "some@updated.mail",
      nick: "SomeUpdatedNick",
      pass: "12345678",
      pass_confirmation: "12345678"
    }
    @invalid_attrs %{mail: nil, nick: nil, pass_hash: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      u1 = user_fixture()
      [u2] = Accounts.list_users()
      assert u1.id == u2.id
      assert u1.mail == u2.mail
      assert u1.nick == u2.nick
      assert true == Argon2.verify_pass(u1.pass, u2.pass_hash)
    end

    test "get_user!/1 returns the user with given id" do
      u1 = user_fixture()
      u2 = Accounts.get_user!(u1.id)
      assert u1.id == u2.id
      assert u1.mail == u2.mail
      assert u1.nick == u2.nick
      assert true == Argon2.verify_pass(u1.pass, u2.pass_hash)
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.mail == @valid_attrs.mail
      assert user.nick == @valid_attrs.nick
      assert true == Argon2.verify_pass(@valid_attrs.pass, user.pass_hash)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.mail == @update_attrs.mail
      assert user.nick == @update_attrs.nick
      assert true == Argon2.verify_pass(@update_attrs.pass, user.pass_hash)
    end

    test "update_user/2 with invalid data returns error changeset" do
      u1 = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(u1, @invalid_attrs)
      u2 = Accounts.get_user!(u1.id)
      assert u1.id == u2.id
      assert u1.mail == u2.mail
      assert u1.nick == u2.nick
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
