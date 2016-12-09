defmodule MovieWagerApi.User do
  use MovieWagerApi.Web, :model

  schema "users" do
    field :screen_name, :string
    field :profile_image_url, :string
    field :twitter_id, :integer
    field :name, :string
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:screen_name, :profile_image_url, :twitter_id, :name])
    |> unique_constraint(:screen_name)
    |> validate_required([:screen_name])
  end

  def by_id_or_screen_name(identifier) when is_integer(identifier) do
    from u in MovieWagerApi.User, where: u.id == ^identifier
  end

  def by_id_or_screen_name(identifier) when is_binary(identifier) do
    case Integer.parse(identifier) do
      {int, ""} -> by_id_or_screen_name(int)
      _error -> from u in MovieWagerApi.User, where: u.screen_name == ^identifier
    end
  end
end
