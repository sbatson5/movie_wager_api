defmodule MovieWagerApi.LoadAccountTest do
  use MovieWagerApi.ConnCase

  test "loads the user if there is an :user_id in the session" do
    user = insert(:user)

    conn = build_conn()
      |> setup_session
      |> Plug.Conn.put_session(:user_id, user.id)
      |> MovieWagerApi.LoadAccount.call(nil)

    assert conn.assigns.user == user
  end

  test "passes the conn unchanged if there is no :user_id in the session" do
    conn = build_conn()
      |> setup_session
      |> MovieWagerApi.LoadAccount.call(nil)

    refute conn.assigns[:user]
  end

  defp setup_session(conn) do
    conn
    |> bypass_through(MovieWagerApi.Router, [:browser])
    |> get("/")
  end
end
