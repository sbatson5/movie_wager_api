defmodule MovieWagerApi.MovieRoundController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{MovieRound, MovieRoundSerializer, Repo, Scorer}

  def index(conn, _params) do
    movie_rounds = Repo.all(MovieRound)
    serialized_movie_round(conn, movie_rounds, 200)
  end

  def show(conn, %{"id" => identifier}) do
    movie_round = Repo.one!(MovieRound.by_id_or_code(identifier))
    serialized_movie_round(conn, movie_round, 200)
  end

  def create(conn, %{"data" =>  %{"attributes" => movie_round_params}}) do
    changeset = MovieRound.changeset(%MovieRound{}, movie_round_params)
    case Repo.insert(changeset) do
      {:ok, movie_round} ->
        serialized_movie_round(conn, movie_round, :created)

      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  def update(conn, %{"id" => identifier, "data" => %{"attributes" => params}}) do
    movie_round = Repo.one!(MovieRound.by_id_or_code(identifier))
    changeset = MovieRound.changeset(movie_round, params)

    case Repo.update(changeset) do
      {:ok, movie_round} ->
        Scorer.finalize_results(movie_round)
        serialized_movie_round(conn, movie_round, 200)
      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  defp serialized_movie_round(conn, movie_round, status) do
    serialized_movie_round = MovieRoundSerializer
      |> JaSerializer.format(movie_round, conn)

    conn
    |> put_status(status)
    |> json(serialized_movie_round)
  end
end
