defmodule MovieWagerApi.MovieRoundTest do
  use MovieWagerApi.ModelCase

  alias MovieWagerApi.MovieRound

  @valid_attrs %{box_office_amount: 42, code: "some content", end_date: %{day: 17, month: 4, year: 2010}, start_date: %{day: 17, month: 4, year: 2010}, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = MovieRound.changeset(%MovieRound{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = MovieRound.changeset(%MovieRound{}, @invalid_attrs)
    refute changeset.valid?
  end
end
