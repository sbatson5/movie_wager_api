defmodule MovieWagerApi.UserController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{Repo, User, UserSerializer}

  def show(conn, %{"id" => identifier}) do
    User.by_id_or_username(identifier)
    |> Repo.one
    |> case do
      %User{} = user ->
        serialized_user = JaSerializer.format(UserSerializer, user, conn)
        json(conn, serialized_user)
      nil -> send_resp(conn, 404, "")
    end
  end
end
