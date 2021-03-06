defmodule MovieWagerApi.WagerTest do
  use MovieWagerApi.ModelCase

  alias MovieWagerApi.Wager

  @valid_attrs %{amount: 42, place: 42, user_id: 50, movie_round_id: 55}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Wager.changeset(%Wager{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Wager.changeset(%Wager{}, @invalid_attrs)
    refute changeset.valid?
  end
end
