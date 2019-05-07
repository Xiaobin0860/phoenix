defmodule XWeb.UserController do
  use XWeb, :controller

  require Logger

  alias X.Accounts
  alias X.Accounts.User
  alias X.Accounts.Guardian

  action_fallback XWeb.FallbackController

  def login(conn, %{"mail" => mail, "pass" => pass}) do
    with {:ok, %User{} = user} <- Accounts.auth_user(mail, pass),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn |> render("user_jwt.json", jwt: token, user: user)
    end
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      Logger.debug("create #{inspect user} #{token}")

      conn
      |> put_status(:created)
      |> render("user_jwt.json", jwt: token, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
