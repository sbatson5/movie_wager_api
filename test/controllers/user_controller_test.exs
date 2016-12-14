defmodule MovieWagerApi.UserControllerTest do
  use MovieWagerApi.ConnCase

  setup do
    conn = build_conn()
    {:ok, conn: conn}
  end

  describe "GET show" do
    test "it returns a 404 when given an invalid id", %{conn: conn} do
      assert_error_sent 404, fn ->
        get(conn, user_path(conn, :show, 1234))
      end
    end

    test "it returns a user when given a valid id", %{conn: conn} do
      user = insert(:user, screen_name: "loremipsumboyz")

      resp = conn
        |> get(user_path(conn, :show, user.id))
        |> json_response(200)

      assert resp["data"]["attributes"]["screen-name"] == "loremipsumboyz"
      assert resp["data"]["type"] == "user"
    end

    test "it returns a 200 when given a valid screen_name", %{conn: conn} do
      user = insert(:user , screen_name: "scottisawesome")

      resp = conn
        |> get(user_path(conn, :show, "scottisawesome"))
        |> json_response(200)

      assert resp["data"]["attributes"]["screen-name"] == "scottisawesome"
      assert resp["data"]["type"] == "user"
    end
  end
end
