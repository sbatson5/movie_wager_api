defmodule MovieWagerApi.MovieRound do
  use MovieWagerApi.Web, :model

  alias MovieWagerApi.MovieDetail

  schema "movie_rounds" do
    field :code, :string
    field :start_date, Ecto.Date
    field :end_date, Ecto.Date
    field :box_office_amount, :integer
    field :title, :string

    has_one :movie_detail, MovieDetail, foreign_key: :movie_round_id

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
