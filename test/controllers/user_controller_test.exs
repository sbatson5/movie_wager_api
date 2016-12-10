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

    test "it returns a 200 when given a valid id", %{conn: conn} do
      user = insert(:user)

      conn
      |> get(user_path(conn, :show, user.id))
      |> json_response(200)
    end

    test "it returns a 200 when given a valid screen_name", %{conn: conn} do
      user = insert(:user , screen_name: "scottisawesome")

      conn
      |> get(user_path(conn, :show, "scottisawesome"))
      |> json_response(200)
    end
  end
end
