defmodule MovieWagerApi.MovieRoundController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{Repo, MovieRound, MovieRoundSerializer}

  def index(conn, _params) do
    movie_rounds = Repo.all(MovieRound)

    serialized_rounds = JaSerializer.format(MovieRoundSerializer, movie_rounds, conn)

    json(conn, serialized_rounds)
  end
end
