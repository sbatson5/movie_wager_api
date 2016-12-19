defmodule MovieWagerApi.WagerControllerTest do
  use MovieWagerApi.ConnCase

  setup do
    conn = build_conn()
    {:ok, conn: conn}
  end

  describe "POST create" do
    test "it creates and returns a valid wager", %{conn: conn} do
      wager_params = %{amount: 5, place: nil}

      user = insert(:user)
      movie_round = insert(:movie_round)

      json = json_for(:wager, wager_params)
        |> put_relationships(user, movie_round)

      resp = conn
        |> post(wager_path(conn, :create), json)
        |> json_response(201)
        |> assert_jsonapi_relationship("user", user.id)
        |> assert_jsonapi_relationship("movie-round", movie_round.id)
    end
  end
end
