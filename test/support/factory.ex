defmodule MovieWagerApi.Factory do
  use ExMachina.Ecto, repo: MovieWagerApi.Repo

  def movie_round_factory do
    %MovieWagerApi.MovieRound{
      code: sequence(:code, &"Monkey #{&1}: Die Harder"),
      start_date: Ecto.Date.from_erl({2016,1,1}),
      end_date: Ecto.Date.from_erl({2016,1,3}),
      box_office_amount: nil,
      title: "Funky Monkey Bunch"
    }
  end

  def user_factory do
    %MovieWagerApi.User{
      screen_name: sequence(:screen_name, &"scottbot_#{&1}"),
      profile_image_url: "http://scottbott.com/image.jpg",
      name: "Scott Bot",
      twitter_id: 123
    }
  end

  def wager_factory do
    %MovieWagerApi.Wager{
      amount: 100000,
      user: build(:user),
      movie_round: build(:movie_round)
    }
  end
end
