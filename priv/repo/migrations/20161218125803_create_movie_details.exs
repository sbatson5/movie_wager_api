defmodule MovieWagerApi.Repo.Migrations.CreateMovieRound do
  use Ecto.Migration

  def change do
    create table(:movie_details) do
      add :imdb_code, :string
      add :poster_url, :string
      add :release_date, :date
      add :rating, :string
      add :runtime, :string
      add :genres, :string
      add :summary, :string
      add :director, :string
      add :writers, :string
      add :stars, :string
      add :trailer_link, :string
      add :movie_round_id, references(:movie_rounds)
    end

  end
end
