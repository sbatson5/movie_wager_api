defmodule MovieWagerApi.SessionControllerTest do
  use MovieWagerApi.ConnCase

  setup do
    conn = build_conn()
    {:ok, conn: conn}
  end

  describe "GET show" do
    test "it returns a user when given a user is logged in", %{conn: conn} do
      resp = conn
        |> sign_in(insert(:user, screen_name: "cabbage"))
        |> get(session_path(conn, :show, "movie-wager"))
        |> json_response(200)

      assert resp["data"]["attributes"]["screen-name"] == "cabbage"
      assert resp["data"]["type"] == "user"
    end

    test "it returns no content when not signed in", %{conn: conn} do
      resp = get(conn, session_path(conn, :show, "movie-wager"))

      assert resp.status == 401
    end
  end

  describe "DELETE delete" do
    test "it deletes the session", %{conn: conn} do
      user = insert(:user)

      conn = sign_in(conn, user)
        |> delete(session_path(conn, :delete, "movie-wager"))

      assert conn.status == 204
    end
  end
end
