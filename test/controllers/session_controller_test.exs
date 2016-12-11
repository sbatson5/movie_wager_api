defmodule MovieWagerApi.SessionControllerTest do
  use MovieWagerApi.ConnCase

  setup do
    conn = build_conn()
    {:ok, conn: conn}
  end

  describe "GET show" do
    test "it returns a 200 when given a user is logged in", %{conn: conn} do
      conn = conn
        |> sign_in(insert(:user))
        |> get(session_path(conn, :show, "movie-wager"))
        |> json_response(200)
    end
  end
end
