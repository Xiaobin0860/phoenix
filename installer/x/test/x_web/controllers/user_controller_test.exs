defmodule XWeb.UserControllerTest do
  use XWeb.ConnCase

  alias X.Accounts
  alias X.Accounts.User

  @create_attrs %{
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
  @invalid_attrs %{mail: nil, nick: nil, pass: nil, pass_confirmation: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "auth error", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 401)["error"] == "unauthenticated"
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      ret = post(conn, Routes.user_path(conn, :create), user: @create_attrs)

      assert %{
               "id" => id,
               "mail" => mail,
               "nick" => nick,
               "jwt" => jwt
             } = json_response(ret, 201)["user"]

      assert mail == @create_attrs.mail
      assert nick == @create_attrs.nick

      ret =
        conn
        |> put_req_header("authorization", "Bearer " <> jwt)
        |> get(Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "mail" => mail,
               "nick" => nick
             } = json_response(ret, 200)["data"]

      assert mail == @create_attrs.mail
      assert nick == @create_attrs.nick
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "mail" => mail,
               "nick" => nick
             } = json_response(conn, 200)["data"]

      assert mail == @update_attrs.mail
      assert nick == @update_attrs.nick
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      ret = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(ret, 204)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end
  end

  defp create_user(%{conn: conn}) do
    user = fixture(:user)
    {:ok, jwt, _} = Accounts.auth_token(user.mail, user.pass)
    {:ok, user: user, conn: put_req_header(conn, "authorization", "Bearer " <> jwt)}
  end
end
