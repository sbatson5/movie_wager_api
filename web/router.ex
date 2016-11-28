defmodule MovieWagerApi.Router do
  use MovieWagerApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json-api"]
    plug :fetch_session
    plug JaSerializer.Deserializer
  end

  scope "/api/v1", MovieWagerApi do
    pipe_through :api

    resources "/movie-rounds", MovieRoundController, only: [:index, :create]
  end
end
