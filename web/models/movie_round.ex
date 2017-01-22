defmodule MovieWagerApi.MovieRound do
  use MovieWagerApi.Web, :model

  alias MovieWagerApi.MovieRound

  schema "movie_rounds" do
    field :code, :string
    field :start_date, Ecto.Date
    field :end_date, Ecto.Date
    field :box_office_amount, :integer
    field :title, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:code, :start_date, :end_date, :box_office_amount, :title])
    |> validate_required([:code, :start_date, :end_date, :title])
  end

  def by_id_or_code(identifier) when is_integer(identifier) do
    from u in MovieRound, where: u.id == ^identifier
  end

  def by_id_or_code(identifier) when is_binary(identifier) do
    case Integer.parse(identifier) do
      {int, ""} -> by_id_or_code(int)
      _error -> from m in MovieRound, where: m.code == ^identifier
    end
  end
end
