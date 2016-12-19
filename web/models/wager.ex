defmodule MovieWagerApi.Wager do
  use MovieWagerApi.Web, :model

  schema "wagers" do
    field :amount, :integer
    field :place, :integer

    timestamps

    belongs_to :user, MovieWagerApi.User
    belongs_to :movie_round, MovieWagerApi.MovieRound
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount, :place])
    |> validate_required([:amount, :place])
    |> unique_constraint(:user_movie_round, name: :wagers_user_movie_round_idx)
  end
end
