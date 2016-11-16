defmodule MovieWagerApi.MovieRoundSerializer do
  use JaSerializer

  attributes [
    :code,
    :start_date,
    :end_date,
    :box_office_amount,
    :title
  ]
end
