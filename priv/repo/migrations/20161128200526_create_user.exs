defmodule MovieWagerApi.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :screen_name, :string, null: false
      add :profile_image_url, :string
      add :twitter_id, :integer, null: false
      add :name, :string

      timestamps()
    end

    create unique_index(:users, [:screen_name])
  end
end
