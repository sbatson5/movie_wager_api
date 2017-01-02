defmodule MovieWagerApi.MovieRoundController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{Repo, MovieRound, MovieRoundSerializer}

  def index(conn, _params) do
    movie_rounds = Repo.all(MovieRound)

    serialized_rounds = JaSerializer.format(MovieRoundSerializer, movie_rounds, conn)

    json(conn, serialized_rounds)
  end

  def show(conn, %{"id" => id}) do
    round = Repo.get(MovieRound, id)
    serialized_round = JaSerializer.format(MovieRoundSerializer, round, conn)
    json(conn, serialized_round)
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

  # def update(conn, %{"id" => id, "data" => %{"attributes" => params}}) do
  #   movie_round = Repo.get!(Wager, id)
  #
  #   changeset = MovieRound.changeset(movie_round, params)
  #
  #   case Repo.update(changeset) do
  #     {:ok, movie_round} ->
  #       serialized_movie_round(conn, wager, 200)
  #     {:error, _changeset} ->
  #       send_resp(conn, :unprocessable_entity, "")
  #   end
  # end

  defp serialized_movie_round(conn, movie_round, status) do
    serialized_movie_round = MovieRoundSerializer
      |> JaSerializer.format(movie_round, conn)

    conn
    |> put_status(status)
    |> json(serialized_movie_round)
  end
end
