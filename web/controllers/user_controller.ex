defmodule MovieWagerApi.UserController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{Repo, User, UserSerializer, GoogleUser}

  def create(conn, %{"code" => code, "redirect_uri" => redirect_uri, "client_id" => client_id}) do
    request_body = %{
      "code" => code,
      "redirect_uri" => redirect_uri,
      "client_id" => client_id,
      "client_secret" => "XmWMcmdGwTUnbXccg1z8I8Iy",
      "scope" => "",
      "grant_type" => "authorization_code"
    } |> Plug.Conn.Query.encode

    headers = %{
      "Content-Type" => "application/x-www-form-urlencoded",
      "X-Requested-With": "XMLHttpRequest"
    }

    case HTTPoison.post("https://accounts.google.com/o/oauth2/token", request_body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        json(conn, Poison.decode!(body))
      {:error, error} -> IO.inspect(error)
    end
  end

  def create(conn, %{"id" => google_id, "user" => google_user_info}) do
    params = %{
      "family_name" => google_user_info["familyName"],
      "gender" => google_user_info["gender"],
      "given_name" => google_user_info["givenName"],
      "locale" => google_user_info["locale"],
      "name" => google_user_info["name"],
      "picture" => google_user_info["picture"],
      "verified_email" => google_user_info["verifiedEmail"]
    }
    IO.puts("yo ==============")
    GoogleUser
    |> where(google_id: ^google_id)
    |> Repo.one()
    |> case do
      nil -> create_new_user(conn, google_id, params)
      user -> update_existing(conn, user, params)
    end
  end

  defp update_existing(conn, user, params) do
    IO.puts("we are updated!!!!")
    changeset = GoogleUser.changeset(user, params)
    case Repo.update(changeset) do
      {:ok, _} ->
        send_resp(conn, 200, "")
      {:error,} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  defp create_new_user(conn, google_id, params) do
    params = params |> Map.put("google_id", google_id) |> IO.inspect
    IO.puts("hheereerereeee")
    changeset = GoogleUser.changeset(%GoogleUser{}, params)
    case Repo.insert(changeset) do
      {:ok, _} ->
        send_resp(conn, 200, "")
      {:error, _} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  def show(conn, %{"id" => identifier}) do
    user = Repo.one!(User.by_id_or_screen_name(identifier))
    serialized_user = JaSerializer.format(UserSerializer, user, conn)
    json(conn, serialized_user)
  end
end
