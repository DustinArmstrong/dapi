# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Dapi.Repo.insert!(%Dapi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Dapi.Repo

alias Dapi.Accounts.{Credential, User}

alias Dapi.Campaigns.{Game, Player}

alias Dapi.Characters.Character

user = Repo.insert!(
  %User{username: "admin", name: "admin"}
)
credential = Repo.insert!(
  %Credential{user: user, email: "admin@example.com", password: "password"}
)
game = Repo.insert!(
  %Game{name: "Campaign One", user: user}
)
game2 = Repo.insert!(
  %Game{name: "Campaign Two", user: user}
)
character = Repo.insert!(
  %Character{name: "Chester", user: user}
)
character2 = Repo.insert!(
  %Character{name: "Wallace", user: user}
)
player = Repo.insert!(
  %Player{game: game, character: character}
)
player2 = Repo.insert!(
  %Player{game: game, character: character2}
)
