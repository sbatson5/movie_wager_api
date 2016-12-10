defmodule MovieWagerApi.UserTest do
  use MovieWagerApi.ModelCase

  alias MovieWagerApi.User

  @valid_attrs %{screen_name: "some content", twitter_id: 4}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "`by_id_or_screen_name` queries by id when passed an integer" do
    user = insert(:user, screen_name: "wehavefun")
    query = User.by_id_or_screen_name(user.id)

    assert Repo.one(query).screen_name == user.screen_name
  end

  test "`by_id_or_screen_name` queries by string id's" do
    user = insert(:user, id: 5)
    query = User.by_id_or_screen_name("5")

    assert Repo.one(query).id == 5
  end

  test "by_id_or_screen_name` queries by screen_name when passed" do
    screen_name = "scottisawesome"
    user = insert(:user, screen_name: screen_name)
    query = User.by_id_or_screen_name(screen_name)

    assert Repo.one(query).id == user.id
  end
end
