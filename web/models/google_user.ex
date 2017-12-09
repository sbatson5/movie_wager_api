defmodule MovieWagerApi.GoogleUser do
  use MovieWagerApi.Web, :model

  schema "google_users" do
    field :family_name, :string
    field :gender, :string
    field :given_name, :string
    field :locale, :string
    field :name, :string
    field :picture, :string
    field :verified_email, :boolean
    field :google_id, :string

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:google_id, :family_name, :gender, :given_name, :locale, :name, :picture, :verified_email])
  end
end
