defmodule MovieWagerApi.WagerSerializer do
  use JaSerializer

  attributes [:amount, :place]

  has_one :movie_round, type: "movie-round"
  has_one :user, type: "user"
end
