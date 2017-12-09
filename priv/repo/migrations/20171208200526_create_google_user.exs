defmodule MovieWagerApi.Repo.Migrations.CreateGoogleUser do
  use Ecto.Migration

  def change do
    create table(:google_users) do
      add :family_name, :string
      add :gender, :string
      add :given_name, :string
      add :locale, :string
      add :name, :string
      add :picture, :string
      add :verified_email, :boolean
      add :google_id, :string, null: false
      timestamps()
    end
  end
end
