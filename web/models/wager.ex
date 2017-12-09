defmodule MovieWagerApi.Wager do
  use MovieWagerApi.Web, :model

  schema "wagers" do
    field :amount, :integer
    field :place, :integer

    timestamps()

    belongs_to :user, MovieWagerApi.User
    belongs_to :movie_round, MovieWagerApi.MovieRound
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount, :place, :user_id, :movie_round_id])
    |> validate_required([:amount, :user_id, :movie_round_id])
    |> unique_constraint(:user_movie_round, name: :wagers_user_movie_round_idx)
  end
end
