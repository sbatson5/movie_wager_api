defmodule MovieWagerApi.Scorer do
  alias MovieWagerApi.{Repo, Wager}

  import Ecto.Query

  def finalize_results(%{box_office_amount: nil}), do: nil

  def finalize_results(movie_round) do
    sort_wagers(movie_round.id, movie_round.box_office_amount)
    |> Enum.with_index(1)
    |> Enum.each(fn {wager, idx} ->
      changeset = Wager.changeset(wager, %{place: idx})

      Repo.update(changeset)
    end)
  end

  def sort_wagers(movie_round_id, box_office_amount) do
    wagers = Wager
      |> where(movie_round_id: ^movie_round_id)
      |> Repo.all

    Enum.sort(wagers, fn(current, next) ->
      abs(current.amount - box_office_amount) < abs(next.amount - box_office_amount)
    end)
  end
end
