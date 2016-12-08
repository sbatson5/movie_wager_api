#-------------------------------------------------------------
#
#  Embedded Tasks
#
#    Tasks that can be run post-release
#
#-------------------------------------------------------------

defmodule MovieWagerApi.EmbeddedTasks do

  #-----------------------------------------------------------
  # Tasks
  #-----------------------------------------------------------

  #-----------------------------------------------------------
  #  Migrate
  #    Convert connected database to use current structures
  #-----------------------------------------------------------
  def migrate do
    # Load application, necessary for performing DB ops
    load_app()
    start_repo(MovieWagerApi.Repo)
    # Access migration folder
    migrations_path = Application.app_dir(:movie_wager_api, "priv/repo/migrations")
    # Perform migration
    info "Executing migrations for #{inspect MovieWagerApi.Repo} in #{migrations_path}:"
    Ecto.Migrator.run(MovieWagerApi.Repo, migrations_path, :up, all: true)
    # This is necessary or the tasklet will never end on its own
    System.halt(0)
  end

  #-----------------------------------------------------------
  # Helper functions
  #-----------------------------------------------------------

  defp load_app do
    start_applications([:logger, :postgrex, :ecto])
    :ok = Application.load(:movie_wager_api)
  end

  defp start_applications(apps) do
    Enum.each(apps, fn app ->
      {:ok, _} = Application.ensure_all_started(app)
    end)
  end

  defp start_repo(repo) do
    {:ok, _} = repo.start_link()
  end

  defp info(message) do
    IO.puts(message)
  end

end
