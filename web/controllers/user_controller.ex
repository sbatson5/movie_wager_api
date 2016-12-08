defmodule MovieWagerApi.UserController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{Repo, User, UserSerializer}

  def show(conn, %{"id" => identifier}) do
    user = Repo.one!(User.by_id_or_username(identifier))
    serialized_user = JaSerializer.format(UserSerializer, user, conn)
    json(conn, serialized_user)
  end
end
