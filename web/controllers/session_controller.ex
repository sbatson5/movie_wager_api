defmodule MovieWagerApi.SessionController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{Repo, User, UserSerializer}

  def show(conn, _) do
    case conn.assigns[:user] do
      nil ->
        send_resp(conn, :no_content, "")
      user ->
        serialized_user = JaSerializer.format(UserSerializer, user, conn)
        json(conn, serialized_user)
    end
  end

  def delete(conn, _) do
    conn
    |> fetch_session
    |> delete_session(:user_id)
    |> send_resp(:no_content, "")
  end
end
