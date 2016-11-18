defmodule MovieWagerApi.MovieRound do
  use MovieWagerApi.Web, :model

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
end
