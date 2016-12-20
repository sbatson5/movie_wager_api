defmodule MovieWagerApi.WagerController do
  use MovieWagerApi.Web, :controller

  alias MovieWagerApi.{Wager, WagerSerializer}

  def create(conn, %{"data" => %{"attributes" => wager_params, "relationships" => relationship_params}}) do
    params = get_relationship_ids(relationship_params)
      |> Map.merge(wager_params)

    changeset = Wager.changeset(%Wager{}, params)

    case Repo.insert(changeset) do
      {:ok, wager} ->
        serialized_wager(conn, wager, :created)
      {:error, changeset} ->
        if changeset.errors[:user_movie_round] do
          send_resp(conn, :unprocessable_entity, "You have already created a bet for this round")
        else
          send_resp(conn, :unprocessable_entity, "Invalid entry")
        end
    end
  end

  def update(conn, %{"id" => id, "data" => %{"attributes" => wager_params}}) do
    wager = Repo.get!(Wager, id)

    changeset = Wager.changeset(wager, wager_params)

    case Repo.update(changeset) do
      {:ok, wager} ->
        serialized_wager(conn, wager, 200)
      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end

  defp serialized_wager(conn, wager, status) do
    wager_with_relationships = preload(wager)

    serialized_wager = WagerSerializer
      |> JaSerializer.format(wager_with_relationships, conn)

    conn
    |> put_status(status)
    |> json(serialized_wager)
  end

  defp preload(wager) do
    Repo.preload(wager, [:user, :movie_round])
  end

  defp get_relationship_ids(%{"movie_round" => movie_round_params, "user" => user_params}) do
    %{"user_id" => get_id(user_params), "movie_round_id" => get_id(movie_round_params)}
  end

  defp get_id(%{"data" => %{"id" => id}}), do: id
end
