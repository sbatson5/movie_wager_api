defmodule MovieWagerApi.MovieRoundSerializer do
  use JaSerializer

  alias MovieWagerApi.MovieDetailSerializer

  attributes [
    :code,
    :start_date,
    :end_date,
    :box_office_amount,
    :title
  ]

  has_one :movie_detail,
    serializer: MovieDetailSerializer,
    include: true
end
