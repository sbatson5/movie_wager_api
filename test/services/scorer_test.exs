defmodule MovieWagerApi.ScorerServiceTest do
  use ExUnit.Case
  use MovieWagerApi.ServiceCase

  alias MovieWagerApi.{Wager, Scorer}

  describe "sort_wagers" do
    test "it properly sorts wagers" do
      movie_round = insert(:movie_round, box_office_amount: 1000)
      [_wager_one, wager_two, wager_three] = place_three_wagers(movie_round)
      sorted_wagers = Scorer.sort_wagers(movie_round.id, movie_round.box_office_amount)

      assert List.first(sorted_wagers).amount == wager_three.amount
      assert List.last(sorted_wagers).amount == wager_two.amount
    end
  end

  describe "finalize_results" do
    test "it returns nil with no amount" do
      movie_round = insert(:movie_round)

      refute Scorer.finalize_results(movie_round)
    end

    test "it populates place for each wager" do
      movie_round = insert(:movie_round, box_office_amount: 1000)
      [wager_one, wager_two, wager_three] = place_three_wagers(movie_round)

      Scorer.finalize_results(movie_round)

      assert Repo.get(Wager, wager_three.id).place == 1
      assert Repo.get(Wager, wager_one.id).place == 2
      assert Repo.get(Wager, wager_two.id).place == 3
    end
  end

  defp place_three_wagers(movie_round) do
    wager_one = insert(:wager, movie_round: movie_round, amount: 890)
    wager_two = insert(:wager, movie_round: movie_round, amount: 700)
    wager_three = insert(:wager, movie_round: movie_round, amount: 1100)

    [wager_one, wager_two, wager_three]
  end
end
