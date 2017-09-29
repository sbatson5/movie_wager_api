defmodule MovieWagerApi.WagerSerializer do
  use JaSerializer

  attributes [:amount, :place]

  has_one :movie_round, type: "movie-round"
  has_one :user,
    serializer: MovieWagerApi.UserSerializer,
    type: "user",
    include: true
end
