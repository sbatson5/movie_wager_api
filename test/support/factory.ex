defmodule MovieWagerApi.Factory do
  use ExMachina.Ecto, repo: MovieWagerApi.Repo

  def movie_round_factory do
    %MovieWagerApi.MovieRound{
      code: "Monkey",
      start_date: Ecto.Date.from_erl({2016,1,1}),
      end_date: Ecto.Date.from_erl({2016,1,3}),
      box_office_amount: 10000000,
      title: "Funky Monkey Bunch"
    }
  end

  def user_factory do
    %MovieWagerApi.User{
      screen_name: "scottbot",
      profile_image_url: "http://scottbott.com/image.jpg",
      name: "Scott Bot",
      twitter_id: 123
    }
  end
end
