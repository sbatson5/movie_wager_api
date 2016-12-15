defmodule MovieWagerApi.SessionController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.UserSerializer

  @no_authentication "User is not logged in"

  def show(conn, _) do
    case conn.assigns[:user] do
      nil ->
        send_resp(conn, 401, @no_authentication)
      user ->
        serialized_user = JaSerializer.format(UserSerializer, user, conn)
        json(conn, serialized_user)
    end
  end

  def delete(conn, _) do
    conn
    |> fetch_session
    |> delete_session(:user_id)
    |> send_resp(204, @no_authentication)
  end
end
