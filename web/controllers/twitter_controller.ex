defmodule MovieWagerApi.TwitterController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{Authentication, Repo, User, UserSerializer}

  def create(conn, %{"oauth_token" => oauth_token, "oauth_verifier" => oauth_verifier}) do
    case ExTwitter.access_token(oauth_verifier, oauth_token) do
      {:ok, access_token} ->
        # TODO: pull consumer info from system
        ExTwitter.configure(
          consumer_key: "t5uCiD2SrYK6Zc9AuILSly7C5",
          consumer_secret: "CogJgS1Y0ZpTNsq3PjZX0KTOUOrototM7dIgipVe2fjS68SOm6",
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
    # TODO: get redirect URL from system
    token = ExTwitter.request_token("http://localhost:4200/authenticated")
    {:ok, authenticate_url} = ExTwitter.authenticate_url(token.oauth_token)

    json(conn, %{"url" => authenticate_url})
  end

  defp render_user(conn, user) do
    case add_or_update_user(user) do
      {:ok, user} ->
        Authentication.sign_in(conn, user)
        |> json(%{"user_id" => user.id})
      {:error, changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  defp add_or_update_user(user) do
    changes = %{
      twitter_id: user.id,
      screen_name: user.screen_name,
      profile_image_url: user.profile_image_url,
      name: user.name
    }
    case Repo.get_by(User, twitter_id: user.id) do
      nil ->
        User.changeset(%User{}, changes) |> Repo.insert
      user_record ->
        User.changeset(user_record, changes) |> Repo.update
    end
  end
end
