defmodule MovieWagerApi.UserSerializer do
  use JaSerializer

  attributes [:screen_name, :profile_image_url, :twitter_id, :name]
end
