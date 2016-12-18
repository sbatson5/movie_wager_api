defmodule MovieWagerApi.UserSerializer do
  use JaSerializer

  attributes [:name, :profile_image_url, :screen_name, :twitter_id]
end
