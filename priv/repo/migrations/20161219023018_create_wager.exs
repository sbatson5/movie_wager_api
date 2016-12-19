defmodule MovieWagerApi.Repo.Migrations.CreateWager do
  use Ecto.Migration

  def change do
    create table(:wagers) do
      add :movie_round_id, references(:movie_rounds)
      add :user_id, references(:users)
      add :amount, :integer
      add :place, :integer

      timestamps()
    end

    create unique_index(:wagers, [:user_id, :movie_round_id], name: :wagers_user_movie_round_idx)
  end
end
