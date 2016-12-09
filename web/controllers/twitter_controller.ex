defmodule MovieWagerApi.TwitterController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{Repo, User, UserSerializer}

  def create(conn, %{"oauth_token" => oauth_token, "oauth_verifier" => oauth_verifier}) do
    case ExTwitter.access_token(oauth_verifier, oauth_token) do
      {:ok, access_token} ->
        ExTwitter.configure(
          consumer_key: "",
          consumer_secret: "",
          access_token: access_token.oauth_token,
          access_token_secret: access_token.oauth_token_secret
        )

        tweet = ExTwitter.user_timeline |> List.first

        render_user(conn, tweet.user)
      _ ->
        send_resp(conn, :unprocessable_entity, "")
     end
  end

  def create(conn, _) do
    token = ExTwitter.request_token("http://localhost:4200/authenticated")
    {:ok, authenticate_url} = ExTwitter.authenticate_url(token.oauth_token)

    json(conn, %{"url" => authenticate_url})
  end

  defp render_user(conn, user) do
    case add_or_update_user(user) do
      {:ok, user} ->
        serialized_user = JaSerializer.format(UserSerializer, user, conn)
        json(conn, serialized_user)
      {:error, changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  defp add_or_update_user(user) do
    case Repo.get_by(User, twitter_id: user.id) do
      nil ->
        User.changeset(%User{}, %{twitter_id: user.id, screen_name: user.screen_name, profile_image_url: user.profile_image_url, name: user.name})
        |> Repo.insert
      user ->
        User.changeset(user, %{twitter_id: user.id, screen_name: user.screen_name, profile_image_url: user.profile_image_url, name: user.name})
        |> Repo.update
    end

  end
end
