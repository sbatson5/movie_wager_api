defmodule MovieWagerApi.Authentication do
  import Plug.Conn, only: [put_session: 3]

  def sign_in(conn, user) do
    put_session(conn, :user_id, user.id)
  end
end
