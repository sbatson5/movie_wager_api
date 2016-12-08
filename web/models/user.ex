defmodule MovieWagerApi.User do
  use MovieWagerApi.Web, :model

  schema "users" do
    field :username, :string
    field :profile_image_url, :string
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :profile_image_url])
    |> unique_constraint(:username)
    |> validate_required([:username])
  end

  def by_id_or_username(identifier) when is_integer(identifier) do
    from u in MovieWagerApi.User, where: u.id == ^identifier
  end

  def by_id_or_username(identifier) when is_binary(identifier) do
    case Integer.parse(identifier) do
      {int, ""} -> by_id_or_username(int)
      _error -> from u in MovieWagerApi.User, where: u.username == ^identifier
    end
  end
end
