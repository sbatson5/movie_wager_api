defmodule MovieWagerApi.MovieRoundSerializer do
  use JaSerializer

  attributes [
    :code,
    :start_date,
    :end_date,
    :box_office_amount,
    :title
  ]

  def id(%{code: code}, _conn), do: code
end
