defmodule MovieWagerApi.MovieRoundControllerTest do
  use MovieWagerApi.ConnCase

  setup do
    conn = build_conn()
    {:ok, conn: conn}
  end

  describe "GET index" do
    test "it returns the proper payload with no params", %{conn: conn} do
      [first_movie_round, second_movie_round] = insert_pair(:movie_round)

      conn
      |> get(movie_round_path(conn, :index))
      |> json_response(200)
    end
  end
end
