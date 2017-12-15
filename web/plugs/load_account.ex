defmodule MovieWagerApi.LoadAccount do
  import Plug.Conn
  alias MovieWagerApi.Repo
  alias MovieWagerApi.User

  def init(_options), do: nil

  def call(conn, _options) do
    conn |> load_access_token
  end

  defp load_access_token(conn) do
    IO.inspect(conn)
    IO.puts("trying to load")
    if access_token = get_session(conn, :access_token) do
      IO.puts("we found stuff")
      IO.puts(access_token)
      assign(conn, :access_token, access_token)
    else
      conn
    end
  end

  defp load_user(conn) do
    if user = get_user(conn) do
      conn |> assign(:user, user)
    else
      conn
    end
  end

  defp get_user(conn) do
    if user_id = get_session(conn, :user_id) do
      Repo.get(User, user_id)
    end
  end
end
