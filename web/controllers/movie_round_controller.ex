defmodule MovieWagerApi.MovieRoundController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{Repo, MovieRound, MovieRoundSerializer}

  def index(conn, _params) do
    movie_rounds = Repo.all(MovieRound)
    |> MovieRoundSerializer.format(conn)

    json(conn, movie_rounds)
  end
end
