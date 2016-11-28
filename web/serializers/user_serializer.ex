defmodule MovieWagerApi.UserSerializer do
  use JaSerializer

  attributes [:username, :profile_image_url]
end
