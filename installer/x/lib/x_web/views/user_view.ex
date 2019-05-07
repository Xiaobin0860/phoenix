defmodule XWeb.UserView do
  use XWeb, :view
  alias XWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user_jwt.json", %{jwt: jwt, user: user}) do
    %{user: Map.merge(render_one(user, UserView, "user.json"), %{jwt: jwt})}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, mail: user.mail, nick: user.nick}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
