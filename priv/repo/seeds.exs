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

alias Dapi.Accounts
alias Dapi.Accounts.{Credential, User, UserType}

alias Dapi.Campaigns.{Game, Player}

alias Dapi.Characters.Character

default_type = Repo.insert!(
  %UserType{name: "Default", actions: []}
)

admin_type = Repo.insert!(
  %UserType{name: "Admin", actions: []}
)

admin_params = %{"credential" => %{"email" => "admin@example.com", "password" => "password"},
                 "user_type_id" => "#{admin_type.id}",
                 "name" => "admin", "username" => "admin"}
Accounts.create_user(admin_params)
admin = Accounts.get_user!(1)

user_params = %{"credential" => %{"email" => "user@example.com", "password" => "password"},
                "user_type_id" => "#{default_type.id}",
                "name" => "user", "username" => "user"}
Accounts.create_user(user_params)
user = Accounts.get_user!(2)



game = Repo.insert!(
  %Game{name: "Campaign One", user: admin}
)
game2 = Repo.insert!(
  %Game{name: "Campaign Two", user: admin}
)

character = Repo.insert!(
  %Character{name: "Chester", user: admin}
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
