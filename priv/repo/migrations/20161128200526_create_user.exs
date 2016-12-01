defmodule MovieWagerApi.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :profile_image_url, :string

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
