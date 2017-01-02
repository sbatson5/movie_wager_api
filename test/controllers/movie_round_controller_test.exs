defmodule MovieWagerApi.MovieRoundControllerTest do
  use MovieWagerApi.ConnCase

  setup do
    conn = build_conn()
    {:ok, conn: conn}
  end

  describe "GET index" do
    test "it returns the proper payload with no params", %{conn: conn} do
      insert_pair(:movie_round)

      resp = conn
        |> get(movie_round_path(conn, :index))
        |> json_response(200)

      assert length(resp["data"]) == 2
    end
  end

  describe "GET show" do
    test "it returns a single record with a proper id", %{conn: conn} do
      [movie_round, _] = insert_pair(:movie_round)

      resp = conn
        |> get(movie_round_path(conn, :show, movie_round.id))
        |> json_response(200)

      assert resp["data"]["id"] == Integer.to_string(movie_round.id)
    end
  end

  describe "POST create" do
    test "it inserts records with proper params", %{conn: conn} do
      movie_params = params_for(:movie_round, title: "movie title")
      conn
      |> post(movie_round_path(conn, :create), json_for(:movie_round, movie_params))
      |> json_response(201)

      new_movie_round = MovieWagerApi.Repo.get_by(MovieWagerApi.MovieRound, title: "movie title")
      assert new_movie_round
    end

    test "it returns 401 with invalid credentials", %{conn: conn} do
      movie_params = %{}

      resp = post(conn, movie_round_path(conn, :create), json_for(:movie_round, movie_params))

      assert resp.status == 422
    end
  end
end
