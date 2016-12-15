defmodule MovieWagerApi.MovieRoundController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{Repo, MovieRound, MovieRoundSerializer}

  def index(conn, _params) do
    movie_rounds = Repo.all(MovieRound)

    serialized_rounds = JaSerializer.format(MovieRoundSerializer, movie_rounds, conn)

    json(conn, serialized_rounds)
  end

  def create(conn, %{"data" =>  %{"attributes" => movie_round_params}}) do
    changeset = MovieRound.changeset(%MovieRound{}, movie_round_params)
    case Repo.insert(changeset) do
      {:ok, movie_round} ->
        serialized_movie_round = JaSerializer.format(MovieRoundSerializer, movie_round, conn)

        conn
        |> put_status(:created)
        |> json(serialized_movie_round)

      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end
end
