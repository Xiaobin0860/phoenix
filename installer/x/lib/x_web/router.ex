defmodule XWeb.Router do
  use XWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_auth do
    plug XWeb.Pipeline
  end

  scope "/", XWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", XWeb do
    pipe_through :api

    post "/users", UserController, :create
    post "/users/login", UserController, :login
  end


  scope "/api", XWeb do
    pipe_through [:api, :jwt_auth]

    resources "/users", UserController, except: [:new, :edit, :create]
  end
end
