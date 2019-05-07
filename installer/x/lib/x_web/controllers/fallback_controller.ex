defmodule XWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use XWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(XWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(XWeb.ErrorView)
    |> render(:"404")
  end

  def auth_error(conn, {type, _reason}, _opts) do
    conn
    |> put_status(401)
    |> put_view(XWeb.ErrorView)
    |> render("error.json", error: to_string(type))
  end
end
