defmodule MovieWagerApi.Authentication do
  import Plug.Conn, only: [get_session: 2, put_session: 3]

  def sign_in(conn, access_token) do
    IO.puts("put session !!!!!!!!!!!!!!!!!!!!!!")
    conn = put_session(conn, :access_token, access_token)
    IO.inspect(get_session(conn, :access_token))
    conn
  end

  def sign_in(conn, user) do
    put_session(conn, :user_id, user.id)
  end
end
