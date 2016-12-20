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

    test "it returns 422 with duplicate round and user", %{conn: conn} do
      original_wager = insert(:wager)
      wager_params = %{amount: 5, place: nil}

      json = json_for(:wager, wager_params)
        |> put_relationships(original_wager.user, original_wager.movie_round)

      resp = conn
        |> post(wager_path(conn, :create), json)

      assert resp.status == 422
      assert resp.resp_body == "You have already created a bet for this round"
    end
  end

  describe "PATCH update" do
    test "it updates and returns a valid wager", %{conn: conn} do
      wager_params = %{amount: 1000}

      wager = insert(:wager)

      user = insert(:user)
      movie_round = insert(:movie_round)

      json = json_for(:wager, wager_params)
        |> put_relationships(user, movie_round)

      resp = conn
        |> put(wager_path(conn, :update, wager.id), json)
        |> json_response(200)
    end
  end
end
