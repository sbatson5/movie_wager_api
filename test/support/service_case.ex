defmodule MovieWagerApi.ServiceCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias MovieWagerApi.Repo
      import MovieWagerApi.Factory
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MovieWagerApi.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(MovieWagerApi.Repo, {:shared, self()})
    end

    :ok
  end
end
