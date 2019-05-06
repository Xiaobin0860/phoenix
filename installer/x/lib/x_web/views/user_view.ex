defmodule XWeb.UserView do
  use XWeb, :view
  alias XWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      mail: user.mail,
      pass_hash: user.pass_hash,
      nick: user.nick}
  end
end
