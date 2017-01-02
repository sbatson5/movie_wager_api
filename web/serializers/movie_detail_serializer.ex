defmodule MovieWagerApi.MovieDetailSerializer do
  use JaSerializer

  attributes [
    :imdb_code,
    :poster_url,
    :release_date,
    :rating,
    :runtime,
    :genres,
    :summary,
    :director,
    :writers,
    :stars,
    :trailer_link
  ]
end
