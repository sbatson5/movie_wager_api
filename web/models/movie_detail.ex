defmodule MovieWagerApi.MovieDetail do
  use MovieWagerApi.Web, :model

  alias MovieWagerApi.MovieRound

  schema "movie_details" do
    field :imdb_code, :string
    field :poster_url, :string
    field :release_date, Ecto.Date
    field :rating, :string
    field :runtime, :string
    field :genres, :string
    field :summary, :string
    field :director, :string
    field :writers, :string
    field :stars, :string
    field :trailer_link, :string

    belongs_to :movie_round, MovieRound
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:imdb_code, :poster_url, :release_date, :rating, :runtime, :genres, :summary, :director, :writers, :stars, :trailer_link])
  end
end
