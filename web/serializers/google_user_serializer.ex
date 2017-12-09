defmodule MovieWagerApi.GoogleUserSerializer do
  use JaSerializer

  attributes [:family_name, :gender, :given_name, :locale, :name, :picture, :verified_email]
end
