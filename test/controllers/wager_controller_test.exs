defmodule MovieWagerApi.WagerControllerTest do
  use MovieWagerApi.ConnCase

  setup do
    conn = build_conn()
    {:ok, conn: conn}
  end

  describe "GET index" do
    test "it returns the specific wager for the user", %{conn: conn} do
      movie_round = insert(:movie_round)
      user = insert(:user)

      wager = insert(:wager, user: user, movie_round: movie_round)
      insert_pair(:wager)

      resp = conn
        |> get(wager_path(conn, :index, %{user_id: user.id, movie_round_id: movie_round.id}))
        |> json_response(200)

      assert length(resp["data"]) == 1
      assert ids_from_response(resp) == [wager.id]
    end

    test "it returns wagers for a given round", %{conn: conn} do
      movie_round = insert(:movie_round)

      [wager_one, wager_two] = insert_pair(:wager, movie_round: movie_round)
      insert_pair(:wager)

      resp = conn
        |> get(wager_path(conn, :index, %{movie_round_id: movie_round.id}))
        |> json_response(200)

      assert length(resp["data"]) == 2
      assert ids_from_response(resp) == [wager_one.id, wager_two.id]
    end
  end

  describe "POST create" do
    test "it creates and returns a valid wager", %{conn: conn} do
      wager_params = %{amount: 5}

      user = insert(:user)
      movie_round = insert(:movie_round)

      json = json_for(:wager, wager_params)
        |> put_relationships(user, movie_round)

      conn
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
      wager = insert(:wager, amount: 50)
      user = insert(:user)
      movie_round = insert(:movie_round)

      json = json_for(:wager, %{amount: 1000})
        |> put_relationships(user, movie_round)

      resp = conn
        |> put(wager_path(conn, :update, wager.id), json)
        |> json_response(200)

      assert resp["data"]["attributes"]["amount"] == 1000
    end
  end
end
