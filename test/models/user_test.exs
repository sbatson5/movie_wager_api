defmodule MovieWagerApi.UserTest do
  use MovieWagerApi.ModelCase

  alias MovieWagerApi.User

  @valid_attrs %{username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "`by_id_or_username` queries by id when passed an integer" do
    user = insert(:user, username: "wehavefun")
    query = User.by_id_or_username(user.id)
    assert Repo.one(query).username == user.username
  end
end
