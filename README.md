# MovieWagerApi

## What you need:

The first step is installing Elixir which you can do by following instructions on the [Elixir Website](http://elixir-lang.org/install.html)

You will also need Postgres -- which can be installed with homebrew: `brew install postgresql`.

## Setting up your credentials

Copy the `dev.secret.example.exs` to `dev.secret.exz` file and uncomment out the block of code.
Enter in your postgres credentials:

```
config :movie_wager_api, MovieWagerApi.Repo,
  username: "your_username",
  password: "your_password"
```

Similarly, you will want to follow the same steps for `test.secret.example.exs`.
The secret files are not checked into source control, so don't worry about your credentials being shared.

## Setting up the app
To get everything running quickly, I set up a `setup` script.
Simply run `bin/setup` from the root directory of this repo and that should get you into a work state.

*Note*: This script clears the database and gets you to a clean state.
All data you may have will be lost.


## Starting the app
To start your Phoenix app:

  * Install dependencies with `mix deps.get` (handled through `bin/setup`)
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate` (handled through `bin/setup`)
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
